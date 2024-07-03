//
//  poiView.swift
//  VakaryIOS
//
//  Created by Marques on 11/21/23.
//

import SwiftUI

enum IPTTour: CaseIterable {
    case CYCLING_TOUR
    case ROAD_TOUR
    case WALKING_TOUR
    case TOUR
    case TOURIST_TRAIN

    static let associatedValues: [IPTTour: (LocalizedStringKey, String)] = [
        .CYCLING_TOUR: (LocalizedStringKey("ItineraryV20"), "CyclingTour"),
        .ROAD_TOUR: (LocalizedStringKey("ItineraryV21"), "RoadTour"),
        .WALKING_TOUR: (LocalizedStringKey("ItineraryV22"), "WalkingTour"),
        .TOUR: (LocalizedStringKey("ItineraryV23"), "Tour"),
        .TOURIST_TRAIN: (LocalizedStringKey("ItineraryV24"), "TouristTrain")
    ]

    var values: (LocalizedStringKey, String) {
        return IPTTour.associatedValues[self] ?? (LocalizedStringKey(""), "")
    }
}

enum IPTEvent: CaseIterable {
    case SHOW_EVENT
    case SOCIAL_EVENT
    case SPORTS_EVENT
    case ENTERTAINMENT_EVENT
    case EXHIBITION_EVENT
    case CULTURAL_EVENT

    static let associatedValues: [IPTEvent: (LocalizedStringKey, String)] = [
        .SHOW_EVENT: (LocalizedStringKey("ItineraryV25"), "ShowEvent"),
        .SOCIAL_EVENT: (LocalizedStringKey("ItineraryV26"), "SocialEvent"),
        .SPORTS_EVENT: (LocalizedStringKey("ItineraryV27"), "SportsEvent"),
        .ENTERTAINMENT_EVENT: (LocalizedStringKey("ItineraryV28"), "EntertainmentAndEvent"),
        .EXHIBITION_EVENT: (LocalizedStringKey("ItineraryV29"), "ExhibitionEvent"),
        .CULTURAL_EVENT: (LocalizedStringKey("ItineraryV30"), "CulturalEvent")
    ]

    var values: (LocalizedStringKey, String) {
        return IPTEvent.associatedValues[self] ?? (LocalizedStringKey(""), "")
    }
}

enum IPTNatural: CaseIterable {
    case LANDFORM
    case PARK
    case PARK_GARDEN
    case RIVER
    case RIVER_PORT

    static let associatedValues: [IPTNatural: (LocalizedStringKey, String)] = [
        .LANDFORM: (LocalizedStringKey("ItineraryV31"), "Landform"),
        .PARK: (LocalizedStringKey("ItineraryV32"), "Park"),
        .PARK_GARDEN: (LocalizedStringKey("ItineraryV33"), "ParkAndGarden"),
        .RIVER: (LocalizedStringKey("ItineraryV34"), "River"),
        .RIVER_PORT: (LocalizedStringKey("ItineraryV35"), "RiverPort")
    ]

    var values: (LocalizedStringKey, String) {
        return IPTNatural.associatedValues[self] ?? (LocalizedStringKey(""), "")
    }
}

enum IPTActivity: CaseIterable {
    case BOWLING
    case CINEMA
    case GAME
    case MINIGOLF
    case MOVIE_THEATER
    case THEATER
    case AMUSEMENT_PARK
    case THEME_PARK
    case EXHIBITION
    case LEISURE_COMPLEX
    case MARINE

    static let associatedValues: [IPTActivity: (LocalizedStringKey, String)] = [
        .BOWLING: (LocalizedStringKey("ItineraryV36"), "BowlingAlley"),
        .CINEMA: (LocalizedStringKey("ItineraryV37"), "Cinema"),
        .GAME: (LocalizedStringKey("ItineraryV38"), "Game"),
        .MINIGOLF: (LocalizedStringKey("ItineraryV39"), "Minigolf"),
        .MOVIE_THEATER: (LocalizedStringKey("ItineraryV40"), "MovieTheater"),
        .THEATER: (LocalizedStringKey("ItineraryV41"), "Theater"),
        .AMUSEMENT_PARK: (LocalizedStringKey("ItineraryV42"), "AmusementPark"),
        .THEME_PARK: (LocalizedStringKey("ItineraryV43"), "ThemePark"),
        .EXHIBITION: (LocalizedStringKey("ItineraryV44"), "Exhibition"),
        .LEISURE_COMPLEX: (LocalizedStringKey("ItineraryV45"), "LeisureComplex"),
        .MARINE: (LocalizedStringKey("ItineraryV46"), "Marine")
    ]

    var values: (LocalizedStringKey, String) {
        return IPTActivity.associatedValues[self] ?? (LocalizedStringKey(""), "")
    }
}


enum IPTDrinking: CaseIterable {
    case BAR_PUB
    case BISTRO_WINE_BAR
    case NIGHT_CLUB
    case WINERY
    case TASTING_PROVIDER

    static let associatedValues: [IPTDrinking: (LocalizedStringKey, String)] = [
        .BAR_PUB: (LocalizedStringKey("ItineraryV47"), "BarOrPub"),
        .BISTRO_WINE_BAR: (LocalizedStringKey("ItineraryV48"), "BistroOrWineBar"),
        .NIGHT_CLUB: (LocalizedStringKey("ItineraryV49"), "NightClub"),
        .WINERY: (LocalizedStringKey("ItineraryV50"), "Winery"),
        .TASTING_PROVIDER: (LocalizedStringKey("ItineraryV51"), "TastingProvider")
    ]

    var values: (LocalizedStringKey, String) {
        return IPTDrinking.associatedValues[self] ?? (LocalizedStringKey(""), "")
    }
}

enum IPTCultural: CaseIterable {
    case CASTLE
    case CHURCH
    case CITY_HERITAGE
    case MILITARY_CEMETERY
    case MUSEUM
    case NATURAL_HERITAGE
    case RELIGIOUS_SITE
    case REMEMBRANCE_SITE
    case REMARKABLE_BUILDING
    case CULTURAL_SITE

    static let associatedValues: [IPTCultural: (LocalizedStringKey, String)] = [
        .CASTLE: (LocalizedStringKey("ItineraryV52"), "Castle"),
        .CHURCH: (LocalizedStringKey("ItineraryV53"), "Church"),
        .CITY_HERITAGE: (LocalizedStringKey("ItineraryV54"), "CityHeritage"),
        .MILITARY_CEMETERY: (LocalizedStringKey("ItineraryV55"), "MilitaryCemetery"),
        .MUSEUM: (LocalizedStringKey("ItineraryV56"), "Museum"),
        .NATURAL_HERITAGE: (LocalizedStringKey("ItineraryV57"), "NaturalHeritage"),
        .RELIGIOUS_SITE: (LocalizedStringKey("ItineraryV58"), "ReligiousSite"),
        .REMEMBRANCE_SITE: (LocalizedStringKey("ItineraryV59"), "RemembranceSite"),
        .REMARKABLE_BUILDING: (LocalizedStringKey("ItineraryV60"), "RemarkableBuilding"),
        .CULTURAL_SITE: (LocalizedStringKey("ItineraryV61"), "CulturalSite")
    ]

    var values: (LocalizedStringKey, String) {
        return IPTCultural.associatedValues[self] ?? (LocalizedStringKey(""), "")
    }
}


enum IPTEating: CaseIterable {
    case FAST_FOOD
    case FOOD_ESTABLISHMENT
    case RESTAURANT
    case SELF_CATERING
    case SELF_SERVICE
    case CAFE_COFFE_SHOP
    case CAFE_TEAHOUSE

    static let associatedValues: [IPTEating: (LocalizedStringKey, String)] = [
        .FAST_FOOD: (LocalizedStringKey("ItineraryV62"), "FastFoodRestaurant"),
        .FOOD_ESTABLISHMENT: (LocalizedStringKey("ItineraryV63"), "FoodEstablishment"),
        .RESTAURANT: (LocalizedStringKey("ItineraryV64"), "Restaurant"),
        .SELF_CATERING: (LocalizedStringKey("ItineraryV65"), "SelfCateringAccommodation"),
        .SELF_SERVICE: (LocalizedStringKey("ItineraryV66"), "SelfServiceCafeteria"),
        .CAFE_COFFE_SHOP: (LocalizedStringKey("ItineraryV67"), "CafeOrCoffeeShop"),
        .CAFE_TEAHOUSE: (LocalizedStringKey("ItineraryV68"), "CafeOrTeahouse")
    ]

    var values: (LocalizedStringKey, String) {
        return IPTEating.associatedValues[self] ?? (LocalizedStringKey(""), "")
    }
}

struct poiView: View {
    @EnvironmentObject var itineraryCreation: ItineraryCreation
    @State private var colorGold = Color(red: 0.927, green: 0.713, blue: 0.104)
    @State private var colorBlack = Color.black
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Color("Color3")
                    .ignoresSafeArea()
                VStack {
                    VStack {
                        HStack {
                            Button(action:
                                    itineraryCreation.adultChild
                                   ,label: {
                                Image(systemName: "chevron.backward")
                                    .font(.system(size: geometry.size.height/26, weight: .bold))
                                    .foregroundColor(Color("Color2"))
                            }).padding(.top, 50)
                                .padding(.horizontal, 10)
                            Spacer()
                        }
                    }
                    VStack {
                        Text(LocalizedStringKey("ItineraryV79"))
                            .font(.system(size: geometry.size.height/30, weight: .bold))
                            .foregroundColor(Color("Color5"))
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.horizontal, 50)
                    }.padding(.top, 10)
                    VStack {
                        VStack {
                            Text(LocalizedStringKey("ItineraryV10"))
                                .font(.system(size: geometry.size.height/50))
                                .foregroundColor(colorBlack)
                                .bold()
                                .frame(maxWidth: .infinity, alignment: .center)
                                .padding(.horizontal, 20)
                                .padding(.bottom, 10)
                            ScrollView {
                                VStack {
                                    createButton(title: LocalizedStringKey("ItineraryV13"), isExpanded: $itineraryCreation.isIPTourExpanded, size: geometry.size.height/5, picture: "Tour")

                                    if itineraryCreation.isIPTourExpanded {
                                        ForEach(IPTTour.allCases, id: \.self) { tour in
                                            createSubButton(item: tour.values)
                                        }
                                        .padding(.horizontal)
                                    }
                                }
                                VStack {
                                    createButton(title: LocalizedStringKey("ItineraryV14"), isExpanded: $itineraryCreation.isIPTEventExpanded, size: geometry.size.height/5, picture: "Event")

                                    if itineraryCreation.isIPTEventExpanded {
                                        ForEach(IPTEvent.allCases, id: \.self) { event in
                                            createSubButton(item: event.values)
                                        }
                                        .padding(.horizontal)
                                    }
                                }
                                VStack {
                                    createButton(title: LocalizedStringKey("ItineraryV15"), isExpanded: $itineraryCreation.isIPTNaturalExpanded, size: geometry.size.height/5, picture: "Natural")

                                    if itineraryCreation.isIPTNaturalExpanded {
                                        ForEach(IPTNatural.allCases, id: \.self) { natural in
                                            createSubButton(item: natural.values)
                                        }
                                        .padding(.horizontal)
                                    }
                                }
                                VStack {
                                    createButton(title: LocalizedStringKey("ItineraryV16"), isExpanded: $itineraryCreation.isIPTActivityExpanded, size: geometry.size.height/5, picture: "Activity")

                                    if itineraryCreation.isIPTActivityExpanded {
                                        ForEach(IPTActivity.allCases, id: \.self) { activity in
                                            createSubButton(item: activity.values)
                                        }
                                        .padding(.horizontal)
                                    }
                                }
                                VStack {
                                    createButton(title: LocalizedStringKey("ItineraryV17"), isExpanded: $itineraryCreation.isIPTDrinkingExpanded, size: geometry.size.height/5, picture: "Drinking")

                                    if itineraryCreation.isIPTDrinkingExpanded {
                                        ForEach(IPTDrinking.allCases, id: \.self) { drinking in
                                            createSubButton(item: drinking.values)
                                        }
                                        .padding(.horizontal)
                                    }
                                }
                                VStack {
                                    createButton(title: LocalizedStringKey("ItineraryV18"), isExpanded: $itineraryCreation.isIPTCulturalExpanded, size: geometry.size.height/5, picture: "Cultural")

                                    if itineraryCreation.isIPTCulturalExpanded {
                                        ForEach(IPTCultural.allCases, id: \.self) { cultural in
                                            createSubButton(item: cultural.values)
                                        }
                                        .padding(.horizontal)
                                    }
                                }
                                VStack {
                                    createButton(title: LocalizedStringKey("ItineraryV19"), isExpanded: $itineraryCreation.isIPTEatingExpanded, size: geometry.size.height/5, picture: "Eating")

                                    if itineraryCreation.isIPTEatingExpanded {
                                        ForEach(IPTEating.allCases, id: \.self) { eating in
                                            createSubButton(item: eating.values)
                                        }
                                        .padding(.horizontal)
                                    }
                                }
                            }.frame(height: 320)
                        }.padding(.horizontal, 30)
                            .padding(.vertical, 20)
                    }.background(Color("Color1"))
                        .cornerRadius(10)
                        .padding(.horizontal, 40)
                        .padding(.top, 10)
                    if !itineraryCreation.selectedItems.isEmpty {
                        VStack {
                            Spacer()
                            Button(action:
                                    itineraryCreation.groupeDisabled
                            ,label: {
                                Text(LocalizedStringKey("SignUpV3"))
                                    .font(.title3.bold())
                                    .foregroundColor(Color("Color3"))
                                    .padding(.vertical, 22)
                                    .frame(width: geometry.size.width/1.5, height: 70)
                                    .background(Color("Color5"))
                                    .cornerRadius(100)
                            }).padding(.bottom, 15)
                            Spacer()
                            Spacer()
                            Spacer()
                        }
                    } else {
                        VStack {
                            Spacer()
                            Button {
                            } label: {
                                Text(LocalizedStringKey("SignUpV3"))
                                    .font(.title3.bold())
                                    .foregroundColor(Color("DarkGrey"))
                                    .padding(.vertical, 22)
                                    .frame(width: geometry.size.width/1.5, height: 70)
                                    .background(
                                        .linearGradient(.init(colors: [
                                            Color("Grey"),
                                            Color("Grey"),
                                        ]), startPoint: .leading, endPoint: .trailing), in: RoundedRectangle(cornerRadius: 35)
                                    )
                            }.padding(.bottom, 15)
                                .disabled(true)
                            Spacer()
                            Spacer()
                            Spacer()
                        }
                    }
                }
            }.edgesIgnoringSafeArea(.top)
        }
    }
    func createButton(title: LocalizedStringKey, isExpanded: Binding<Bool>, size: CGFloat, picture: String) -> some View {
        Button(action: {
            withAnimation {
                isExpanded.wrappedValue.toggle()
            }
        }) {
            VStack {
                Image(picture)
                    .resizable()
                    .frame(width: size, height:  size)
                    .padding()
                HStack {
                    Text(title)
                        .foregroundColor(Color("Color5"))
                        .font(.headline)
                    Spacer()
                    Image(systemName: isExpanded.wrappedValue ? "chevron.up.circle.fill" : "chevron.down.circle.fill")
                        .foregroundColor(Color("Color1"))
                }
            }.padding(.bottom, 10)
                .frame(width: size)
                .foregroundColor(.white)
                .background(
                    RoundedRectangle(cornerRadius: 10)
                        .fill(colorGold)
                )
        }
    }

    func createSubButton(item: (LocalizedStringKey, String)) -> some View {
        Button(action: {
            if itineraryCreation.selectedItems.contains(item.1) {
                itineraryCreation.selectedItems.removeAll { $0 == item.1 }
            } else {
                itineraryCreation.selectedItems.append(item.1)
            }
        }) {
            HStack {
                Text(item.0)
                    .foregroundColor(itineraryCreation.selectedItems.contains(item.1) ? colorGold : Color("Color5"))
                Spacer()
                if itineraryCreation.selectedItems.contains(item.1) {
                    Image(systemName: "checkmark")
                        .foregroundColor(colorGold)
                }
            }
            .padding()
            .background(itineraryCreation.selectedItems.contains(item.1) ? Color("Color5") : Color.secondary.opacity(0.1))
            .cornerRadius(8)
        }
    }
}

#Preview {
    poiView()
}
