//
//  MapDisplayView.swift
//  Vakary
//
//  Created by Marques on 13/12/2022.
//

import SwiftUI
import MapKit

struct MapDisplayView: View {
    @State private var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 49.1196964, longitude:  6.1763552), latitudinalMeters: 4000, longitudinalMeters: 4000)
        
    @State private var mapType: MKMapType = .standard

    var body: some View {
        ZStack {
            UIKitMapView(region: region, mapType: mapType)
            VStack {
                Spacer()
                
                Picker("", selection: $mapType) {
                    Text(LocalizedStringKey("SettingsMapV1")).tag(MKMapType.standard)
                    Text(LocalizedStringKey("SettingsMapV2")).tag(MKMapType.hybrid)
                    Text(LocalizedStringKey("SettingsMapV3")).tag(MKMapType.satellite)
                }
                .pickerStyle(.segmented)
                .background(.thickMaterial)
            }
            .offset(y: -40)
        }
        .ignoresSafeArea(.all)
    }
}

struct MapDisplayView_Previews: PreviewProvider {
    static var previews: some View {
        MapDisplayView()
    }
}

struct UIKitMapView: UIViewRepresentable {
    let region: MKCoordinateRegion
    let mapType: MKMapType
    
    func makeUIView(context: Context) -> MKMapView {
        let mapView = MKMapView()
        mapView.setRegion(region, animated: false)
        mapView.mapType = mapType
        mapView.isRotateEnabled = false
        return mapView
    }
    
    func updateUIView(_ mapView: MKMapView, context: Context) {
        mapView.mapType = mapType
    }
    
    
    func makeCoordinator() -> MapCoordinator {
        MapCoordinator()
    }
    
    final class MapCoordinator: NSObject, MKMapViewDelegate {
        
    }
}
struct MapTypeExample_Previews: PreviewProvider {
    static var previews: some View {
        MapDisplayView()
    }
}
