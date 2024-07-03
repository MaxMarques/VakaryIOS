//
//  MapComponent.swift
//  Vakary
//
//  Created by Marques on 17/10/2022.
//

import MapKit
import SwiftUI

class LocalisationStore: ObservableObject {
    @Published var city: String = ""
}

class UserLocalisationStore: ObservableObject {
    @Published var lastUserLocation: MKUserLocation?
}

struct MapComponent: UIViewRepresentable {
    @EnvironmentObject var dataStore: DataStore
    @EnvironmentObject var map: MapModel
    @StateObject var city = LocalisationStore()
    @StateObject var UserLocation = UserLocalisationStore()
    
    let mapView = MKMapView()
    let locationManager = LocationManager()
    
    func makeUIView(context: Context) -> some UIView {
        mapView.delegate = context.coordinator
        mapView.isRotateEnabled = true
        mapView.showsUserLocation = true
        mapView.tintColor = .black
        mapView.userTrackingMode = .follow
        return mapView
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        if map.centerUserLoclisation {
            context.coordinator.centerUserLocalisation(forUserLocation: UserLocation.lastUserLocation!)
            map.centerUserLoclisation = false
        }
        if map.itineraryChoice && dataStore.itineraryArray.count > 0 {
            let coordinate = CLLocationCoordinate2D(latitude: (dataStore.itineraryArray[0].Localisation?.latitude)!, longitude: (dataStore.itineraryArray[0].Localisation?.longitude)!)
            context.coordinator.addAndSelectAnnotation(withCoordinate: coordinate)
            context.coordinator.configurePolyline(useLocationUser: true, withSourceCoordinate: coordinate, withDestinationCoordinate: coordinate)
            
            var index = 0
            
            for i in dataStore.itineraryArray {
                if index != 0 {
                    let coordinate = CLLocationCoordinate2D(latitude: (i.Localisation?.latitude)!, longitude: (i.Localisation?.longitude)!)
                    let oldCoordinate = CLLocationCoordinate2D(latitude: (dataStore.itineraryArray[index - 1].Localisation?.latitude)!, longitude: (dataStore.itineraryArray[index - 1].Localisation?.longitude)!)
                    context.coordinator.addAndSelectAnnotation(withCoordinate: coordinate)
                    context.coordinator.configurePolyline(useLocationUser: false, withSourceCoordinate: oldCoordinate, withDestinationCoordinate: coordinate)
                }
                index += 1
            }
        } else {
            context.coordinator.clearMapViewAnfdRecenterOnUserLocation()
        }
    }
    
    func makeCoordinator() -> MapCoordinator {
        return MapCoordinator(parent: self, city: city, userLocation: UserLocation)
        }
    }

    extension MapComponent {

        class MapCoordinator: NSObject, MKMapViewDelegate {
            
            let parent: MapComponent
            @Published var city: LocalisationStore
            @Published var userLocation: UserLocalisationStore
            
            var geoCoder = CLGeocoder()
            var userLocationCoordinate: CLLocationCoordinate2D?
            var currentRegion: MKCoordinateRegion?
            
            init(parent: MapComponent, city: LocalisationStore, userLocation: UserLocalisationStore) {
                self.parent = parent
                self.city = city
                self.userLocation = userLocation
                super.init()
            }
            
            func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) {
                let location = CLLocation(latitude: userLocation.coordinate.latitude, longitude: userLocation.coordinate.longitude)
                self.geoCoder.reverseGeocodeLocation(location, completionHandler:
                                                        {
                    placemarks, error -> Void in
                    
                    guard let placeMark = placemarks?.first else { return }
                    
                    if let city = placeMark.locality {
                        UserDefaults.standard.set(city, forKey: "city")
                        self.city.city = city
                    }
                })
                self.userLocation.lastUserLocation = userLocation
            }
            
            func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
                
                let polyline = MKPolylineRenderer(overlay: overlay)
                polyline.strokeColor = .systemPink
                polyline.lineWidth = 6
                
                return polyline
            }
            
            func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
                if let annotationCoordinates = view.annotation?.coordinate {
                    parent.map.interestPointChoice = annotationCoordinates
                }
            }
            
            func addAndSelectAnnotation(withCoordinate coordinate: CLLocationCoordinate2D) {
                
                let annot = MKPointAnnotation()
                
                annot.coordinate = coordinate
                parent.mapView.addAnnotation(annot)
            }
            
            func configurePolyline(useLocationUser data: Bool, withSourceCoordinate Sourcecoordinate: CLLocationCoordinate2D, withDestinationCoordinate coordinate: CLLocationCoordinate2D) {
                
                guard let userLocationCoordinate = self.userLocationCoordinate else { return }
                
                if data == true {
                    getDestinationRoute(from: userLocationCoordinate, to: coordinate) { route in
                        self.parent.mapView.addOverlay(route.polyline)
                    }
                } else {
                    getDestinationRoute(from: Sourcecoordinate, to: coordinate) { route in
                        self.parent.mapView.addOverlay(route.polyline)
                    }
                }
            }

            func getDestinationRoute(from userLocation: CLLocationCoordinate2D, to destination: CLLocationCoordinate2D, completion: @escaping(MKRoute) -> Void) {

                let userPlacemark = MKPlacemark(coordinate: userLocation)
                let destPlacemark = MKPlacemark(coordinate: destination)
                let request = MKDirections.Request()
                
                request.source = MKMapItem(placemark: userPlacemark)
                request.destination = MKMapItem(placemark: destPlacemark)
                request.transportType = [.walking]
                
                let directions = MKDirections(request: request)
                directions.calculate { response, error in
                    if let error = error {
                        print("DEBUG: Failed to get directions with error\(error.localizedDescription)")
                        return
                    }
                    guard let route = response?.routes.first else { return }
                    completion(route)
                }
            }

            func clearMapViewAnfdRecenterOnUserLocation() {
                parent.mapView.removeAnnotations(parent.mapView.annotations)
                parent.mapView.removeOverlays(parent.mapView.overlays)
                
                if let currentRegion = currentRegion {
                    parent.mapView.setRegion(currentRegion, animated: true)
                }
            }

            func centerUserLocalisation(forUserLocation userLocation: MKUserLocation) {
                let coordinate = userLocation.coordinate
                self.userLocationCoordinate = coordinate
                
                let region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: coordinate.latitude, longitude: coordinate.longitude), span: MKCoordinateSpan(latitudeDelta: 0.005, longitudeDelta: 0.005))
                
                self.currentRegion = region
                parent.mapView.setRegion(region, animated: true)
            }
    }
}
