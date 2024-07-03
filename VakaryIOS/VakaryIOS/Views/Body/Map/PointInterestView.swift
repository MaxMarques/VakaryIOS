//
//  PointInterestView.swift
//  Vakary
//
//  Created by Marques on 18/11/2022.
//

import SwiftUI
import SwiftUIFontIcon
import CoreLocation
import Kingfisher

struct PointInterestView: View {
    @EnvironmentObject var map: MapModel
    let location: InterestPoint
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 16) {
                imageSection
                titleSection
            }
            VStack {
                HStack {
                    Spacer()
                    closeButton
                        .onTapGesture {
                            withAnimation() {
                                map.interestPointChoice = CLLocationCoordinate2D(latitude: 0, longitude: 0)
                            }
                        }
                }
                learnMoreButton
            }.padding(.top, 30)
        }.padding(30)
            .background(RoundedRectangle(cornerRadius: 10)
                    .fill(.ultraThinMaterial)
                    .offset(y: 65)
                    .padding(.horizontal, 10)
            )
            .cornerRadius(10)
    }
}

struct PointInterestView_Previews: PreviewProvider {
    @State static var interestPointChoice: CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: 0, longitude: 0)
    @State static var showPointInterestDetail: Bool = false
    static let location: InterestPoint = InterestPoint(id: "", name: "", likes: 0, averageTime: 0, averagePrice: "", covidRestriction: false, handicapAccess: false, image: "", createdAt: "", updatedAt: "", descriptionId: "", localisationId: "", contactId: "", City: City(id: "", name: "", code: 0, localisation: Localisation(id: "", longitude: 0.0, latitude: 0.0)), Localisation: Localisation(id: "", longitude: 0.0, latitude: 0.0), Contact: Contact(id: "", email: "", phone: "", websiteLink: ""), Description: Description(id: "", fr: "", en: "", de: "", es: ""), InterestPointWithType: [])
    static var previews: some View {
        PointInterestView(location: location)
    }
}

extension PointInterestView {
    private var imageSection: some View {
        ZStack {
            KFImage(URL(string: location.image ?? "PointInterest"))
                .placeholder {
                    Image("PointInterest")
                        .resizable()
                }
                .scaledToFill()
                .frame(width: 100, height: 100)
                .cornerRadius(10)
        }.padding(6)
            .background(Color(red: 0.927, green: 0.713, blue: 0.104))
            .cornerRadius(10)
    }
    
    private var titleSection: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(location.name ?? "Point d'interet")
                .font(.title2)
                .fontWeight(.bold)
        }
    }
    
    private var learnMoreButton: some View {
        Button {
            withAnimation {
                map.showPointInterestDetail = true
            }
        } label: {
            Text("En savoir plus")
                .font(.headline)
                .frame(width: 130, height: 50)
                .foregroundColor(Color(red: 0.927, green: 0.713, blue: 0.104))
        }.background(Color(red: 0.112, green: 0.098, blue: 0.22))
            .cornerRadius(10)
    }
    
    private var closeButton: some View {
        Image(systemName: "xmark.circle")
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: 35, height: 35)
            .foregroundColor(Color(.red))
            .padding(.bottom, 20)
    }
}

extension Image {
    func data(url:URL) -> Self {
        if let data = try? Data(contentsOf: url) {
            return Image(uiImage: UIImage(data: data)!)
                .resizable()
        }
        return self
            .resizable()
    }
}
