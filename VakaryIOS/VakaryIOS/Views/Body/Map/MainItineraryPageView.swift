//
//  MainItineraryPageView.swift
//  Vakary
//
//  Created by Marques on 12/08/2023.
//

import SwiftUI

struct MainItineraryPageView: View {
    @EnvironmentObject var map: MapModel
    @StateObject var dataStore: DataStore
    var body: some View {
        VStack {
            Spacer()
            if map.itineraryChoice {
                ItinerarySummaryView(location: dataStore.itineraryArray)
                    .environmentObject(map)
                    .offset(y: map.showCreateItineraryPage ? -10 : UIScreen.main.bounds.height)
                    .onAppear {
                        withAnimation {
                            map.annimCreateItineraryButton = false
                            map.showCreateItineraryPage = false
                            map.changeCreateItineraryButton = false
                        }
                    }
            } else {
                ItineraryView()
                    .environmentObject(map)
                    .environmentObject(dataStore)
                    .environmentObject(MapAPI(dataStore: dataStore))
                    .offset(y: map.showCreateItineraryPage ? -10 : UIScreen.main.bounds.height)
                    .onAppear {
                        withAnimation {
                            map.annimCreateItineraryButton = false
                            map.showCreateItineraryPage = false
                            map.changeCreateItineraryButton = false
                        }
                    }
            }
        }.background((map.showCreateItineraryPage ? Color.black.opacity(0.1) : Color.clear).edgesIgnoringSafeArea(.all).onTapGesture {
            withAnimation() {
                map.showCreateItineraryPage.toggle()
            }
        }).edgesIgnoringSafeArea(.bottom)
    }
}
