//
//  DetailsItineraryView.swift
//  VakaryIOS
//
//  Created by Thibaut  Humbert on 12/12/2023.
//

import SwiftUI

struct DetailsItineraryView: View {
    var itinerary: listItinerary
    @EnvironmentObject var mapAPI: MapAPI
    @State var interestPoint: [InterestPoint]

    var body: some View {
        ZStack {
            ScrollView {
                VStack {
                    ForEach(interestPoint, id: \.id) { interestPoints in
                        VStack(alignment: .leading) {
                            HStack {
                                HStack {
                                    AsyncImage(url: URL(string: interestPoints.image ?? "ld"))
                                        .frame(width: 100, height: 100)
                                        .cornerRadius(5)
                                    VStack(alignment: .leading) {
                                        Text(interestPoints.name ?? "-----")
                                            .font(.title)
                                            .foregroundColor(.black)
                                    }
                                    Spacer()
                                }
                            }
                            .padding()
                            .background(Color.white)
                            .cornerRadius(10)
                            .shadow(radius: 10)
                        }
                    }
                }
            }
        }
        .task {
            do {
                interestPoint = try await mapAPI.getItineraryById(itineraryId: itinerary.id ?? "")
            }
            catch {
                print(error)
            }
        }
        .onAppear {
            SoundManager.shared.playSound()
        }
    }
}
