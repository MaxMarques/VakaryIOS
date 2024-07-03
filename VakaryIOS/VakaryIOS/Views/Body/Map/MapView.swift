//
//  MapView.swift
//  Vakary
//
//  Created by Marques on 04/08/2023.
//

import SwiftUI
import CoreLocation

struct MapView: View {
    @EnvironmentObject var dataStore: DataStore
    @EnvironmentObject var map: MapModel

    var body: some View {
        ZStack {
            MapComponent()
                .ignoresSafeArea()
                .environmentObject(map)
                .environmentObject(dataStore)
            if map.itineraryChoice {
                ZStack {
                    VStack {
                        HStack {
                            Button(action: {
                                map.centerUserLoclisation = true
                            }) {
                                Image(systemName: "location.fill")
                                    .foregroundColor(Color("Color3"))
                                    .padding()
                                    .background(Color("Color5"))
                                    .clipShape(RoundedRectangle(cornerRadius: 10))
                                .shadow(radius: 5)                        }
                            .padding()
                            Spacer()
                        }
                        Spacer()
                    }
                }
            }
            ForEach(dataStore.itineraryArray, id: \.id) { location in
                let coordinate = CLLocationCoordinate2D(latitude: (location.Localisation?.latitude)!, longitude: (location.Localisation?.longitude)!)

                if map.interestPointChoice.latitude == coordinate.latitude && map.interestPointChoice.longitude == coordinate.longitude {
                    VStack {
                        Spacer()
                        PointInterestView(location: location).environmentObject(map)
                            .shadow(color: Color.black.opacity (0.3), radius: 20)
                            .padding(.bottom, 55)
                    }
                    VStack {
                        Spacer()
                        PointInterestDetailView(location: location).environmentObject(map)
                            .offset(y: map.showPointInterestDetail ? -10 : UIScreen.main.bounds.height)
                            .onAppear {
                                withAnimation {
                                    map.annimCreateItineraryButton = false
                                    map.showCreateItineraryPage = false
                                    map.changeCreateItineraryButton = false
                                }
                            }
                    }.background((map.showPointInterestDetail ? Color.black.opacity(0.1) : Color.clear).edgesIgnoringSafeArea(.all).onTapGesture {
                        withAnimation() {
                            map.showPointInterestDetail.toggle()
                        }
                    }).edgesIgnoringSafeArea(.bottom)
                }
            }
        }.onTapGesture {
            withAnimation() {
                map.interestPointChoice = CLLocationCoordinate2D(latitude: 0, longitude: 0)
            }
        }
        .onAppear {
            SoundManager.shared.playSound()
        }
    }
}

#Preview {
    MapView()
}
