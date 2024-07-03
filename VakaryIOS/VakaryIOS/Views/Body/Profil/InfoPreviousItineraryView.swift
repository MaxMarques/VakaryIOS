//
//  InfoPreviousItineraryView.swift
//  Vakary
//
//  Created by Thibaut  Humbert on 26/06/2023.
//

import SwiftUI

struct Itinerary: Identifiable {
    let id = UUID()
    let city: String
    let pointsOfInterest: [String]
}

struct ItineraryHistoryView: View {
    @State var itineraryList: [listItinerary]
    @EnvironmentObject var mapAPI: MapAPI
    @State private var detailsInterestPoints: [InterestPoint] = []
    @State private var imageItinerary = UIImage(named: "map")!
    
    var body: some View {
        ZStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 16) {
                    ForEach(itineraryList, id: \.id) { itinerary in
                        NavigationLink(
                            destination: DetailsItineraryView(itinerary: itinerary, interestPoint: detailsInterestPoints)
                                .environmentObject(mapAPI)
                        ) {
                            VStack(alignment: .leading) {
                                HStack {
                                    Image(uiImage: imageItinerary)
                                        .resizable()
                                        .frame(width: 100, height: 100)
                                        .cornerRadius(5)
                                    VStack(alignment: .leading) {
                                        Spacer()
                                        Text(itinerary.id ?? "")
                                            .font(.headline)
                                            .foregroundColor(.black)
                                        Spacer()
                                        if let createdAt = convertToDate(itinerary.createdAt ?? "") {
                                            Text(formatDate(createdAt))
                                                .font(.subheadline)
                                                .foregroundColor(.black)
                                        } else {
                                            Text(LocalizedStringKey("infoPreviousItinV1"))
                                                .font(.subheadline)
                                                .foregroundColor(.black)
                                        }
                                    }
                                    Spacer()
                                }
                            }
                            .padding()
                            .background(Color.white)
                            .cornerRadius(10)
                            .shadow(radius: 10)
                        }
                        .onTapGesture {
                            Task {
                                do {
                                    detailsInterestPoints = try await mapAPI.getItineraryById(itineraryId: itinerary.id ?? "")
                                    print("detail: ", detailsInterestPoints)
                                } catch {
                                    print("Error getting itinerary details: \(error)")
                                }
                            }
                        }
                    }
                    Spacer()
                }
                .padding()
            }
            
        }
        .task {
            do {
                itineraryList = try await mapAPI.getMyItinerary()
            }
            catch {
                print(error)
            }
        }
        .onAppear() {
            SoundManager.shared.playSound()
        }
    }
    
    func convertToDate(_ dateString: String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ" // Utilisez le format réel de votre chaîne
        return dateFormatter.date(from: dateString)
    }

    func formatDate(_ date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd:MM:yyyy"
        return dateFormatter.string(from: date)
    }
}

struct InfoPreviousItineraryView: View {
    let itineraryList = [
            Itinerary(city: "Paris", pointsOfInterest: ["Tour Eiffel", "Louvre", "Notre-Dame", "Opera Garnier"]),
            Itinerary(city: "Nancy", pointsOfInterest: ["Place stanislas", "Cathédrale", "Picot"])
        ]

    var body: some View {
        ItineraryHistoryView(itineraryList: [])
    }
}

