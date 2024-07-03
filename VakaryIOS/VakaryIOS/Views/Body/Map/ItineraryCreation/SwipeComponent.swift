//
//  SwipeComponent.swift
//  VakaryIOS
//
//  Created by Marques on 10/10/2023.
//

import SwiftUI
import Kingfisher

struct Card {
    var imageName: String
    var text: String
    var id: String
}

struct SwipeComponent: View {
    @State var array: [InterestPoint] {
        didSet {
            DispatchQueue.main.async {
                dataStore.itineraryArray = array
            }
        }
    }
    @EnvironmentObject var map: MapModel
    @EnvironmentObject var dataStore: DataStore
    @EnvironmentObject var mapAPI: MapAPI
    @EnvironmentObject var itineraryCreation: ItineraryCreation
    @State private var cards: [Card] = []
    @State private var allCardsTurned = false
    @State private var colorWhite = Color.white
    @State private var error: Bool = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color("Color1").edgesIgnoringSafeArea(.all)
                ForEach(cards.indices, id: \.self) { index in
                    CardSwipeView(
                        card: cards[index],
                        onSwipeLeft: { swipeLeft(card: cards[index]) },
                        onSwipeRight: { swipeRight() }
                    )
                    .offset(x: 0, y: -CGFloat(index) * 10)
                    .zIndex(Double(cards.count - index))
                }
                Spacer()
                if allCardsTurned {
                    VStack {
                        Button(action: {
                            Task {
                                do {
                                    let newArrayOfInterestPoints = try await self.mapAPI.getTinderItinerary(id: dataStore.itineraryID)
                                    DispatchQueue.main.async {
                                        if newArrayOfInterestPoints.isEmpty {
                                            error = true
                                        } else {
                                            array = newArrayOfInterestPoints
//                                            cards = newArrayOfInterestPoints.map { itinerary in
//                                                return Card(imageName: itinerary.image ?? "PointInterest", text: itinerary.name ?? "Point d'interet", id: itinerary.id ?? "")
//                                            }
                                            map.itineraryChoice = true
                                        }
                                    }
                                } catch {
                                    print(error)
                                }
                            }
                        }) {
                            Text(LocalizedStringKey("ItineraryV12"))
                                .font(.system(size: UIScreen.main.bounds.width/15, weight: .bold))
                                .foregroundColor(Color("Color3"))
                                .padding(.vertical, 22)
                                .frame(width: UIScreen.main.bounds.height/4, height: UIScreen.main.bounds.height/8)
                                .background(Color("Color5"))
                        }
                        .background(Color.clear)
                        .cornerRadius(25)
                        .padding(.bottom, 10)
                    }
                }
                if mapAPI.isLoading {
                    LoaderComponent()
                }
            }
        }.onAppear {
            cards = itineraryCreation.tinderArray.map { itinerary in
                return Card(imageName: itinerary.image ?? "PointInterest", text: itinerary.name ?? "Point d'interet", id: itinerary.id ?? "")
            }
        }
        .overlay(overlayView: BannerComponent.init(data: BannerComponent.BannerDataModel(title: "Erreur", detail: LocalizedStringKey("ItineraryV81"), type: .error), show: $error), show: $error)
    }
    func swipeLeft(card: Card) {
        if cards.first != nil {
            Task {
                self.mapAPI.removePOI(itineraireID: dataStore.itineraryID, POIId: card.id)
            }
            cards.removeFirst()
            if cards.isEmpty {
                allCardsTurned = true
            }
        }
    }
    
    func swipeRight() {
        if cards.first != nil {
            cards.removeFirst()
            if cards.isEmpty {
                allCardsTurned = true
            }
        }
    }
}

struct CardSwipeView: View {
    var card: Card
    var onSwipeLeft: () -> Void
    var onSwipeRight: () -> Void
    
    @State private var translation: CGSize = .zero
    
    var body: some View {
        VStack {
            KFImage(URL(string: card.imageName))
                .placeholder {
                    Image("PointInterest")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: UIScreen.main.bounds.width / 1.1, height: UIScreen.main.bounds.height / 2)
                        .cornerRadius(20)
                        .clipped()
                }
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: UIScreen.main.bounds.width / 1.1, height: UIScreen.main.bounds.height / 2)
                .cornerRadius(20)
                .clipped()
            Text(card.text)
                .font(.title)
                .padding()
            
            HStack(spacing: 40) {
                Button(action: {
                    onSwipeLeft()
                }) {
                    Image(systemName: "xmark.circle.fill")
                        .font(.system(size: 80))
                        .foregroundColor(.red)
                }
                
                Button(action: {
                    onSwipeRight()
                }) {
                    Image(systemName: "heart.circle.fill")
                        .font(.system(size: 80))
                        .foregroundColor(.green)
                }
            }
            .padding(.bottom, 10)
        }
        .background(
            RoundedRectangle(cornerRadius: 20)
                .fill(Color.white)
                .shadow(radius: 5)
        )
        .offset(translation)
        .gesture(
            DragGesture()
                .onChanged { value in
                    translation = value.translation
                }
                .onEnded { value in
                    if translation.width < -100 {
                        onSwipeLeft()
                    } else if translation.width > 100 {
                        onSwipeRight()
                    }
                    translation = .zero
                }
        )
    }
}

#Preview {
    SwipeComponent(array: DataStore().itineraryArray)
}
