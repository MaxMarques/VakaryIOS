//
//  PointInterestDetailView.swift
//  Vakary
//
//  Created by Marques on 21/11/2022.
//

import SwiftUI
import MapKit
import Kingfisher

struct PointInterestDetailView: View {
    @EnvironmentObject var map: MapModel
    let location: InterestPoint

    var body: some View {
        ScrollView {
            VStack {
                imageSection
                    .shadow(color: Color.black.opacity(0.3), radius: 20, x: 0, y: 10)
                VStack(alignment: .leading, spacing: 16) {
                    titleSection
                    Divider()
                    descriptionSection
                    Divider()
                    mapLayer
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
            }.padding(.bottom, 100)
        }.ignoresSafeArea()
            .background(.ultraThinMaterial)
            .overlay(backButtion, alignment: .topLeading)
    }
}

struct PointInterestDetailView_Previews: PreviewProvider {
    @State static var showPointInterestDetail: Bool = false
    static let location: InterestPoint = InterestPoint(id: "", name: "", likes: 0, averageTime: 0, averagePrice: "", covidRestriction: false, handicapAccess: false, image: "", createdAt: "", updatedAt: "", descriptionId: "", localisationId: "", contactId: "", City: City(id: "", name: "", code: 0, localisation: Localisation(id: "", longitude: 0.0, latitude: 0.0)), Localisation: Localisation(id: "", longitude: 0.0, latitude: 0.0), Contact: Contact(id: "", email: "", phone: "", websiteLink: ""), Description: Description(id: "", fr: "", en: "", de: "", es: ""), InterestPointWithType: [])
    static var previews: some View {
        PointInterestDetailView(location: location)
    }
}

extension PointInterestDetailView {
    private var imageSection: some View {
        TabView {
            KFImage(URL(string: location.image ?? "PointInterest"))
                .placeholder {
                    Image("PointInterest")
                        .resizable()
                }
                .scaledToFill()
                .frame(width: UIScreen.main.bounds.width)
                .clipped()
//            ForEach(location.image, id: \.self) {
//                Image($0)
//                    .resizable()
//                    .scaledToFill()
//                    .frame(width: UIScreen.main.bounds.width)
//                    .clipped()
//            }
        }
        . frame(height: 500)
        . tabViewStyle(PageTabViewStyle())
    }
    private var titleSection: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(location.name ?? "Ce point d'interet n'est pas nommé")
                .font(.largeTitle)
                .fontWeight(.semibold)
            Text(location.City?.name ?? "Aucune information disponible pour le nom de la ville")
                .font(.title3)
                .foregroundColor(.secondary)
        }
    }
    private var descriptionSection: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text(location.Description?.fr ?? "Aucune description disponible")
                .font(.subheadline)
                .foregroundColor(.secondary)
        }
    }
    private var mapLayer: some View {

        struct IdentifiableCoordinate: Identifiable {
            var id = UUID()
            var coordinate: CLLocationCoordinate2D
        }
        
        let coordinate = CLLocationCoordinate2D(latitude: (location.Localisation?.latitude)!, longitude: (location.Localisation?.longitude)!)
        let span = MKCoordinateSpan(latitudeDelta: 0.02, longitudeDelta: 0.02)
        
        return Map(coordinateRegion: .constant(MKCoordinateRegion(center: coordinate, span: span)), annotationItems: [IdentifiableCoordinate(coordinate: coordinate)]) { loc in
            MapAnnotation(coordinate: loc.coordinate) {
                LocationAnnotationsView()
                    .shadow(radius: 10)
            }
        }
        .allowsHitTesting(false)
        .aspectRatio(1, contentMode: .fit)
        .cornerRadius(30)
    }
    private var backButtion: some View {
        Button {
            withAnimation {
                map.showPointInterestDetail = false
            }
        } label: {
            Image(systemName: "xmark")
                .font(.headline)
                .padding(16)
                .foregroundColor(Color(red: 0.927, green: 0.713, blue: 0.104))
                .background(Color(red: 0.112, green: 0.098, blue: 0.22))
                .cornerRadius(10)
                .shadow(radius: 4)
                .padding()
        }
    }
}

extension Image {
    func dataPicture(url: URL) -> Self {
        if let data = try? Data(contentsOf: url) {
            return Image(uiImage: UIImage(data: data)!)
                .resizable()
        }
        return self
            .resizable()
    }
}
