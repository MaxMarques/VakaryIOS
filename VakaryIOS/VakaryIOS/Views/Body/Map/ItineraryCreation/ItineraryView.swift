//
//  ItineraryView.swift
//  Vakary
//
//  Created by Marques on 19/10/2022.
//
import SwiftUI


struct ItineraryView: View {
    @StateObject var itineraryCreation = ItineraryCreation()
    @EnvironmentObject var mapAPI: MapAPI
    @EnvironmentObject var map: MapModel
    @EnvironmentObject var dataStore: DataStore
    
    var body: some View {
        ZStack {
            if itineraryCreation.pageNumber == 0 {
                localisationFavView()
                    .environmentObject(itineraryCreation)
                    .environmentObject(MapAPI(dataStore: dataStore))
            } else if itineraryCreation.pageNumber == 1 {
                timeBudgetView()
                    .environmentObject(itineraryCreation)
            } else if itineraryCreation.pageNumber == 2 {
                adultChildrenView()
                    .environmentObject(itineraryCreation)
            } else if itineraryCreation.pageNumber == 3 {
                poiView()
                    .environmentObject(itineraryCreation)
            } else if itineraryCreation.pageNumber == 4 {
                groupeDisabledView(itID: dataStore.itineraryID)
                    .environmentObject(itineraryCreation)
                    .environmentObject(map)
                    .environmentObject(MapAPI(dataStore: dataStore))
                    .environmentObject(dataStore)
            } else if itineraryCreation.pageNumber == 5 {
                SwipeComponent(array: DataStore().itineraryArray)
                    .environmentObject(itineraryCreation)
                    .environmentObject(map)
                    .environmentObject(MapAPI(dataStore: dataStore))
                    .environmentObject(dataStore)
            }
        }
    }
}

#Preview {
    ItineraryView()
}

//enum IPTTour: CaseIterable {
//    case CYCLING_TOUR
//    case ROAD_TOUR
//    case WALKING_TOUR
//    case TOUR
//    case TOURIST_TRAIN
//
//    static let associatedValues: [IPTTour: (LocalizedStringKey, String)] = [
//        .CYCLING_TOUR: (LocalizedStringKey("ItineraryV20"), "CyclingTour"),
//        .ROAD_TOUR: (LocalizedStringKey("ItineraryV21"), "RoadTour"),
//        .WALKING_TOUR: (LocalizedStringKey("ItineraryV22"), "WalkingTour"),
//        .TOUR: (LocalizedStringKey("ItineraryV23"), "Tour"),
//        .TOURIST_TRAIN: (LocalizedStringKey("ItineraryV24"), "TouristTrain")
//    ]
//    
//    var values: (LocalizedStringKey, String) {
//        return IPTTour.associatedValues[self] ?? (LocalizedStringKey(""), "")
//    }
//}
//
//enum IPTEvent: CaseIterable {
//    case SHOW_EVENT
//    case SOCIAL_EVENT
//    case SPORTS_EVENT
//    case ENTERTAINMENT_EVENT
//    case EXHIBITION_EVENT
//    case CULTURAL_EVENT
//    
//    static let associatedValues: [IPTEvent: (LocalizedStringKey, String)] = [
//        .SHOW_EVENT: (LocalizedStringKey("ItineraryV25"), "ShowEvent"),
//        .SOCIAL_EVENT: (LocalizedStringKey("ItineraryV26"), "SocialEvent"),
//        .SPORTS_EVENT: (LocalizedStringKey("ItineraryV27"), "SportsEvent"),
//        .ENTERTAINMENT_EVENT: (LocalizedStringKey("ItineraryV28"), "EntertainmentAndEvent"),
//        .EXHIBITION_EVENT: (LocalizedStringKey("ItineraryV29"), "ExhibitionEvent"),
//        .CULTURAL_EVENT: (LocalizedStringKey("ItineraryV30"), "CulturalEvent")
//    ]
//    
//    var values: (LocalizedStringKey, String) {
//        return IPTEvent.associatedValues[self] ?? (LocalizedStringKey(""), "")
//    }
//}
//
//enum IPTNatural: CaseIterable {
//    case LANDFORM
//    case PARK
//    case PARK_GARDEN
//    case RIVER
//    case RIVER_PORT
//    
//    static let associatedValues: [IPTNatural: (LocalizedStringKey, String)] = [
//        .LANDFORM: (LocalizedStringKey("ItineraryV31"), "Landform"),
//        .PARK: (LocalizedStringKey("ItineraryV32"), "Park"),
//        .PARK_GARDEN: (LocalizedStringKey("ItineraryV33"), "ParkAndGarden"),
//        .RIVER: (LocalizedStringKey("ItineraryV34"), "River"),
//        .RIVER_PORT: (LocalizedStringKey("ItineraryV35"), "RiverPort")
//    ]
//    
//    var values: (LocalizedStringKey, String) {
//        return IPTNatural.associatedValues[self] ?? (LocalizedStringKey(""), "")
//    }
//}
//
//enum IPTActivity: CaseIterable {
//    case BOWLING
//    case CINEMA
//    case GAME
//    case MINIGOLF
//    case MOVIE_THEATER
//    case THEATER
//    case AMUSEMENT_PARK
//    case THEME_PARK
//    case EXHIBITION
//    case LEISURE_COMPLEX
//    case MARINE
//    
//    static let associatedValues: [IPTActivity: (LocalizedStringKey, String)] = [
//        .BOWLING: (LocalizedStringKey("ItineraryV36"), "BowlingAlley"),
//        .CINEMA: (LocalizedStringKey("ItineraryV37"), "Cinema"),
//        .GAME: (LocalizedStringKey("ItineraryV38"), "Game"),
//        .MINIGOLF: (LocalizedStringKey("ItineraryV39"), "Minigolf"),
//        .MOVIE_THEATER: (LocalizedStringKey("ItineraryV40"), "MovieTheater"),
//        .THEATER: (LocalizedStringKey("ItineraryV41"), "Theater"),
//        .AMUSEMENT_PARK: (LocalizedStringKey("ItineraryV42"), "AmusementPark"),
//        .THEME_PARK: (LocalizedStringKey("ItineraryV43"), "ThemePark"),
//        .EXHIBITION: (LocalizedStringKey("ItineraryV44"), "Exhibition"),
//        .LEISURE_COMPLEX: (LocalizedStringKey("ItineraryV45"), "LeisureComplex"),
//        .MARINE: (LocalizedStringKey("ItineraryV46"), "Marine")
//    ]
//    
//    var values: (LocalizedStringKey, String) {
//        return IPTActivity.associatedValues[self] ?? (LocalizedStringKey(""), "")
//    }
//}
//
//
//enum IPTDrinking: CaseIterable {
//    case BAR_PUB
//    case BISTRO_WINE_BAR
//    case NIGHT_CLUB
//    case WINERY
//    case TASTING_PROVIDER
//    
//    static let associatedValues: [IPTDrinking: (LocalizedStringKey, String)] = [
//        .BAR_PUB: (LocalizedStringKey("ItineraryV47"), "BarOrPub"),
//        .BISTRO_WINE_BAR: (LocalizedStringKey("ItineraryV48"), "BistroOrWineBar"),
//        .NIGHT_CLUB: (LocalizedStringKey("ItineraryV49"), "NightClub"),
//        .WINERY: (LocalizedStringKey("ItineraryV50"), "Winery"),
//        .TASTING_PROVIDER: (LocalizedStringKey("ItineraryV51"), "TastingProvider")
//    ]
//    
//    var values: (LocalizedStringKey, String) {
//        return IPTDrinking.associatedValues[self] ?? (LocalizedStringKey(""), "")
//    }
//}
//
//enum IPTCultural: CaseIterable {
//    case CASTLE
//    case CHURCH
//    case CITY_HERITAGE
//    case MILITARY_CEMETERY
//    case MUSEUM
//    case NATURAL_HERITAGE
//    case RELIGIOUS_SITE
//    case REMEMBRANCE_SITE
//    case REMARKABLE_BUILDING
//    case CULTURAL_SITE
//    
//    static let associatedValues: [IPTCultural: (LocalizedStringKey, String)] = [
//        .CASTLE: (LocalizedStringKey("ItineraryV52"), "Castle"),
//        .CHURCH: (LocalizedStringKey("ItineraryV53"), "Church"),
//        .CITY_HERITAGE: (LocalizedStringKey("ItineraryV54"), "CityHeritage"),
//        .MILITARY_CEMETERY: (LocalizedStringKey("ItineraryV55"), "MilitaryCemetery"),
//        .MUSEUM: (LocalizedStringKey("ItineraryV56"), "Museum"),
//        .NATURAL_HERITAGE: (LocalizedStringKey("ItineraryV57"), "NaturalHeritage"),
//        .RELIGIOUS_SITE: (LocalizedStringKey("ItineraryV58"), "ReligiousSite"),
//        .REMEMBRANCE_SITE: (LocalizedStringKey("ItineraryV59"), "RemembranceSite"),
//        .REMARKABLE_BUILDING: (LocalizedStringKey("ItineraryV60"), "RemarkableBuilding"),
//        .CULTURAL_SITE: (LocalizedStringKey("ItineraryV61"), "CulturalSite")
//    ]
//    
//    var values: (LocalizedStringKey, String) {
//        return IPTCultural.associatedValues[self] ?? (LocalizedStringKey(""), "")
//    }
//}
//
//
//enum IPTEating: CaseIterable {
//    case FAST_FOOD
//    case FOOD_ESTABLISHMENT
//    case RESTAURANT
//    case SELF_CATERING
//    case SELF_SERVICE
//    case CAFE_COFFE_SHOP
//    case CAFE_TEAHOUSE
//    
//    static let associatedValues: [IPTEating: (LocalizedStringKey, String)] = [
//        .FAST_FOOD: (LocalizedStringKey("ItineraryV62"), "FastFoodRestaurant"),
//        .FOOD_ESTABLISHMENT: (LocalizedStringKey("ItineraryV63"), "FoodEstablishment"),
//        .RESTAURANT: (LocalizedStringKey("ItineraryV64"), "Restaurant"),
//        .SELF_CATERING: (LocalizedStringKey("ItineraryV65"), "SelfCateringAccommodation"),
//        .SELF_SERVICE: (LocalizedStringKey("ItineraryV66"), "SelfServiceCafeteria"),
//        .CAFE_COFFE_SHOP: (LocalizedStringKey("ItineraryV67"), "CafeOrCoffeeShop"),
//        .CAFE_TEAHOUSE: (LocalizedStringKey("ItineraryV68"), "CafeOrTeahouse")
//    ]
//    
//    var values: (LocalizedStringKey, String) {
//        return IPTEating.associatedValues[self] ?? (LocalizedStringKey(""), "")
//    }
//}
//
//struct ItineraryView: View {
//    @StateObject var watch = Watch()
//    @EnvironmentObject var mapAPI: MapAPI
//    @EnvironmentObject var map: MapModel
//    @State private var colorWhite = Color.white
//    @State private var colorBlack = Color.black
//    @State private var colorGold = Color(red: 0.927, green: 0.713, blue: 0.104)
//    @ObservedObject var group = GroupAPI()
//    @State var arrayGroup: [Group] = []
//    @State var profilOption: [ResponseProfilOption] = []
//    @EnvironmentObject var dataStore: DataStore
//    @State var array: [InterestPoint] {
//        didSet {
//            dataStore.itineraryArray = array
//        }
//    }
//    @State var itID: String {
//        didSet {
//            dataStore.itineraryID = itID
//        }
//    }
//    @State private var startDate = Date()
//    @State private var endDate = Date()
//    @State private var price = 0.0
//    @State private var numberAdults: Int = 0
//    @State private var numberKids: Int = 0
//    @State private var handicapAccess: Bool = false
//    @State private var favoris: Bool = false
//    @State private var favorisName = ""
//    @State private var selectedGroup: Group?
//    @State private var groupId: String = ""
//    @State private var error: Bool = false
//    @State private var selectedItems: [String] = []
//    @State private var isIPTourExpanded = false
//    @State private var isIPTEventExpanded = false
//    @State private var isIPTNaturalExpanded = false
//    @State private var isIPTActivityExpanded = false
//    @State private var isIPTDrinkingExpanded = false
//    @State private var isIPTCulturalExpanded = false
//    @State private var isIPTEatingExpanded = false
//    @State private var selectedOption = 0
//    @State private var cityName = ""
//    @State private var swipeFonctionnality = false
//    @State private var selectedProfilID: String?
//    
//    var body: some View {
//        GeometryReader { geometry in
//            ScrollView {
//                VStack {
//                    ZStack {
//                        Image("world")
//                            .resizable()
//                            .frame(width: geometry.size.width, height:  geometry.size.height/3.5)
//                        Text(UserDefaults.standard.string(forKey: "city") ?? "")
//                            .font(.system(size: geometry.size.height/14, weight: .light, design: .serif))
//                            .foregroundColor(colorGold)
//                    }
//                    VStack {
//                        VStack{
//                            Picker("Options", selection: $selectedOption) {
//                                Text(LocalizedStringKey("ItineraryV71")).tag(0)
//                                Text(LocalizedStringKey("ItineraryV72")).tag(1)
//                            }
//                            .pickerStyle(SegmentedPickerStyle())
//                            if selectedOption == 1 {
//                                TextField(LocalizedStringKey("ItineraryV72"), text: $cityName)
//                                    .textFieldStyle(RoundedBorderTextFieldStyle())
//                                    .padding(.horizontal, 40)
//                                    .padding(.top, 20)
//                            }
//                        }.onAppear {
//                            if selectedOption == 0 {
//                                cityName = UserDefaults.standard.string(forKey: "city") ?? ""
//                            }
//                        }
//                        .padding(.vertical, 20)
//                            .padding(.horizontal, 10)
//                    }.background(colorWhite)
//                        .cornerRadius(10)
//                        .padding(.horizontal, 40)
//                        .padding(.top, 20)
//                    VStack {
//                        VStack {
//                            Text(LocalizedStringKey("ItineraryV69"))
//                                .font(.system(size: geometry.size.height/40))
//                                .foregroundColor(colorBlack)
//                                .bold()
//                                .frame(maxWidth: .infinity, alignment: .center)
//                                .padding(.horizontal, 20)
//                            if profilOption.isEmpty {
//                                Text(LocalizedStringKey("Ancun"))
//                                    .font(.system(size: geometry.size.height/40))
//                                    .foregroundColor(colorBlack)
//                                    .frame(maxWidth: .infinity, alignment: .center)
//                                    .padding(.horizontal, 50)
//                            } else {
//                                ScrollView(.horizontal, showsIndicators: false) {
//                                    HStack(spacing: 10) {
//                                        ForEach(profilOption, id: \.id) { option in
//                                            createButtonProfil(item: option)
//                                        }
//                                    }
//                                }
//                            }
//                        }.padding(.horizontal, 30)
//                            .padding(.vertical, 20)
//                    }.background(colorWhite)
//                        .cornerRadius(10)
//                        .padding(.horizontal, 40)
//                        .padding(.top, 20)
//                    VStack {
//                        VStack{
//                            VStack {
//                                HStack {
//                                    Text(LocalizedStringKey("ItineraryV2"))
//                                        .foregroundColor(colorBlack)
//                                        .font(.system(size: geometry.size.height/40))
//                                        .bold()
//                                    DatePicker("", selection: $startDate, displayedComponents: .hourAndMinute)
//                                        .environment(\.locale, Locale.init(identifier: "fr"))
//                                        .font(.system(size: geometry.size.height/40))
//                                        .foregroundColor(colorBlack)
//                                }
//                            }
//                            VStack {
//                                HStack {
//                                    Text(LocalizedStringKey("ItineraryV3"))
//                                        .foregroundColor(colorBlack)
//                                        .font(.system(size: geometry.size.height/40))
//                                        .bold()
//                                    DatePicker("", selection: $endDate, displayedComponents: .hourAndMinute)
//                                        .environment(\.locale, Locale.init(identifier: "fr"))
//                                        .font(.system(size: geometry.size.height/40))
//                                        .foregroundColor(colorBlack)
//                                }
//                            }
//                        }.padding(.vertical, 20)
//                            .padding(.horizontal, 10)
//                    }.background(colorWhite)
//                        .cornerRadius(10)
//                        .padding(.horizontal, 40)
//                        .padding(.top, 20)
//                    VStack {
//                        VStack {
//                            Text(LocalizedStringKey("ItineraryV4"))
//                                .font(.system(size: geometry.size.height/40))
//                                .foregroundColor(colorBlack)
//                                .bold()
//                                .frame(maxWidth: .infinity, alignment: .center)
//                                .padding(.horizontal, 20)
//                            Slider(
//                                value: $price,
//                                in: 0...1000
//                            ).accentColor(Color("BG1"))
//                            Text(String(format: "%.0f €", price))
//                                .foregroundColor(colorBlack)
//                                .font(.system(size: geometry.size.height/40))
//                                .bold()
//                        }.padding(.horizontal, 30)
//                            .padding(.vertical, 20)
//                    }.background(colorWhite)
//                        .cornerRadius(10)
//                        .padding(.horizontal, 40)
//                        .padding(.top, 20)
//                    VStack {
//                        HStack {
//                            VStack {
//                                Text(LocalizedStringKey("ItineraryV6"))
//                                    .foregroundColor(colorBlack)
//                                    .font(.system(size: geometry.size.height/40))
//                                    .bold()
//                                Picker("Adults", selection: $numberAdults) {
//                                    ForEach(0...20, id: \.self) { number in
//                                        Text("\(number)")
//                                    }
//                                }.pickerStyle(.wheel)
//                            }
//                            VStack {
//                                Text(LocalizedStringKey("ItineraryV7"))
//                                    .foregroundColor(colorBlack)
//                                    .font(.system(size: geometry.size.height/40))
//                                    .bold()
//                                Picker("Kids", selection: $numberKids) {
//                                    ForEach(0...20, id: \.self) { number in
//                                        Text("\(number)")
//                                    }
//                                }.pickerStyle(.wheel)
//                            }
//                        }.padding(.vertical, 20)
//                    }.background(colorWhite)
//                        .cornerRadius(10)
//                        .padding(.horizontal, 40)
//                        .padding(.top, 20)
//                    VStack {
//                        VStack {
//                            Text(LocalizedStringKey("ItineraryV10"))
//                                .font(.system(size: geometry.size.height/40))
//                                .foregroundColor(colorBlack)
//                                .bold()
//                                .frame(maxWidth: .infinity, alignment: .center)
//                                .padding(.horizontal, 20)
//                                .padding(.bottom, 20)
//                            ScrollView {
//                                HStack {
//                                    VStack {
//                                        createButton(title: LocalizedStringKey("ItineraryV13"), isExpanded: $isIPTourExpanded, size: geometry.size.height/7, picture: "Tour")
//                                        
//                                        if isIPTourExpanded {
//                                            ForEach(IPTTour.allCases, id: \.self) { tour in
//                                                createSubButton(item: tour.values)
//                                            }
//                                            .padding(.horizontal)
//                                        }
//                                    }
//                                    VStack {
//                                        createButton(title: LocalizedStringKey("ItineraryV14"), isExpanded: $isIPTEventExpanded, size: geometry.size.height/7, picture: "Event")
//
//                                        if isIPTEventExpanded {
//                                            ForEach(IPTEvent.allCases, id: \.self) { event in
//                                                createSubButton(item: event.values)
//                                            }
//                                            .padding(.horizontal)
//                                        }
//                                    }
//                                }
//                                HStack {
//                                    VStack {
//                                        createButton(title: LocalizedStringKey("ItineraryV15"), isExpanded: $isIPTNaturalExpanded, size: geometry.size.height/7, picture: "Natural")
//
//                                        if isIPTNaturalExpanded {
//                                            ForEach(IPTNatural.allCases, id: \.self) { natural in
//                                                createSubButton(item: natural.values)
//                                            }
//                                            .padding(.horizontal)
//                                        }
//                                    }
//                                    VStack {
//                                        createButton(title: LocalizedStringKey("ItineraryV16"), isExpanded: $isIPTActivityExpanded, size: geometry.size.height/7, picture: "Activity")
//
//                                        if isIPTActivityExpanded {
//                                            ForEach(IPTActivity.allCases, id: \.self) { activity in
//                                                createSubButton(item: activity.values)
//                                            }
//                                            .padding(.horizontal)
//                                        }
//                                    }
//                                }
//                                HStack {
//                                    VStack {
//                                        createButton(title: LocalizedStringKey("ItineraryV17"), isExpanded: $isIPTDrinkingExpanded, size: geometry.size.height/7, picture: "Drinking")
//
//                                        if isIPTDrinkingExpanded {
//                                            ForEach(IPTDrinking.allCases, id: \.self) { drinking in
//                                                createSubButton(item: drinking.values)
//                                            }
//                                            .padding(.horizontal)
//                                        }
//                                    }
//                                    VStack {
//                                        createButton(title: LocalizedStringKey("ItineraryV18"), isExpanded: $isIPTCulturalExpanded, size: geometry.size.height/7, picture: "Cultural")
//
//                                        if isIPTCulturalExpanded {
//                                            ForEach(IPTCultural.allCases, id: \.self) { cultural in
//                                                createSubButton(item: cultural.values)
//                                            }
//                                            .padding(.horizontal)
//                                        }
//                                    }
//                                }
//                                HStack {
//                                    VStack {
//                                        createButton(title: LocalizedStringKey("ItineraryV19"), isExpanded: $isIPTEatingExpanded, size: geometry.size.height/7, picture: "Eating")
//
//                                        if isIPTEatingExpanded {
//                                            ForEach(IPTEating.allCases, id: \.self) { eating in
//                                                createSubButton(item: eating.values)
//                                            }
//                                            .padding(.horizontal)
//                                        }
//                                    }
//                                }
//                            }.frame(height: 400)
//                        }.padding(.horizontal, 30)
//                            .padding(.vertical, 20)
//                    }.background(colorWhite)
//                        .cornerRadius(10)
//                        .padding(.horizontal, 40)
//                        .padding(.top, 20)
//
//                    VStack {
//                        VStack {
//                            Text(LocalizedStringKey("ItineraryV8"))
//                                .font(.system(size: geometry.size.height/40))
//                                .foregroundColor(colorBlack)
//                                .bold()
//                                .frame(maxWidth: .infinity, alignment: .center)
//                                .padding(.horizontal, 20)
//                            Picker("Choisissez un groupe", selection: $selectedGroup) {
//                                if selectedGroup == nil {
//                                    Text(LocalizedStringKey("ItineraryV9"))
//                                        .tag(nil as Group?)
//                                }
//                                ForEach(arrayGroup) { group in
//                                    Text(group.name)
//                                        .tag(group as Group?)
//                                }
//                            }.accentColor(Color("BG1"))
//                            .onChange(of: selectedGroup) { newSelectedGroup in
//                                if let group = newSelectedGroup {
//                                    groupId = group.id
//                                } else {
//                                    groupId = ""
//                                }
//                            }
//                        }.padding(.horizontal, 30)
//                            .padding(.vertical, 20)
//                    }.background(colorWhite)
//                        .cornerRadius(10)
//                        .padding(.horizontal, 40)
//                        .padding(.top, 20)
//                    
//                    VStack {
//                        VStack {
//                            Toggle(LocalizedStringKey("ItineraryV11"), isOn: $handicapAccess)
//                                .font(.system(size: geometry.size.height/45))
//                                .foregroundColor(colorBlack)
//                        }.padding(.horizontal, 30)
//                            .padding(.vertical, 20)
//                    }.background(colorWhite)
//                        .cornerRadius(10)
//                        .padding(.horizontal, 40)
//                        .padding(.top, 20)
//                    
//                    VStack {
//                        VStack {
//                            Toggle(LocalizedStringKey("ItineraryV70"), isOn: $favoris)
//                                .font(.system(size: geometry.size.height/45))
//                                .foregroundColor(colorBlack)
//                            if favoris {
//                                TextField(LocalizedStringKey("ItineraryV73"), text: $favorisName)
//                                    .textFieldStyle(RoundedBorderTextFieldStyle())
//                                    .padding(.horizontal, 40)
//                                    .padding(.top, 20)
//                            }
//                        }.padding(.horizontal, 30)
//                            .padding(.vertical, 20)
//                    }.background(colorWhite)
//                        .cornerRadius(10)
//                        .padding(.horizontal, 40)
//                        .padding(.top, 20)
//                    
//                    VStack {
//                        Button(action: {
//                            Task {
//                                do {
//                                    if favoris {
//                                        let paramTravel = getOptions(profilFields: ProfileFields(name: favorisName, adultCount: numberAdults, childCount: numberKids, babyCount: 0), typeOfPoi: selectedItems)
//                                        try await self.mapAPI.createTravelProfil(options: paramTravel)
//                                    }
//                                    let minutes = calculateTimeDifferenceInMinutes(startDate: startDate, endDate: endDate)
//                                    let param = getItinerary(userId: 0, nbPeople: numberAdults, nbChild: numberKids, budget: Int(price), availableTime: minutes, typeResearchLocations: selectedItems, handicapAccess: handicapAccess, city: cityName)
//                                    let result = try await self.mapAPI.getWayPoint(itinerary: param)
//                                    array = result.0
//                                    itID = result.1
//                                    if array.count == 0 {
//                                        error = true
//                                        swipeFonctionnality = false
//                                    } else {
//                                        swipeFonctionnality = true
//                                    }
//                                } catch {
//                                    print(error)
//                                }
//                            }
//                        }) {
//                            Text(LocalizedStringKey("ItineraryV12"))
//                                .font(.system(size: geometry.size.width/20, weight: .bold))
//                                .foregroundColor(colorWhite)
//                                .padding(.vertical, 22)
//                                .frame(width: geometry.size.height/4, height: geometry.size.width/5.5)
//                                .background(
//                                    .linearGradient(.init(colors: [
//                                        Color("Button1"),
//                                        Color("Button2"),
//                                    ]), startPoint: .leading, endPoint: .trailing), in: RoundedRectangle(cornerRadius: 20)
//                                )
//                        }
//                        .background(Color.clear)
//                        .cornerRadius(25)
//                        .padding(.bottom, 10)
//                        .navigationDestination(isPresented: $swipeFonctionnality) {
//                            SwipeComponent(array: DataStore().itineraryArray, routerModels: Router()).environmentObject(map).environmentObject(dataStore).environmentObject(MapAPI(dataStore: dataStore)).navigationBarHidden(true)
//                        }
//                    }.padding(.vertical, 100)
//                    
//                }
//                .task {
//                    do {
//                        arrayGroup = try await group.getMyAllGroup()
//                        profilOption = try await self.mapAPI.getAllTravelProfil()
//                    }
//                    catch {
//                        print(error)
//                    }
//                }
//            }.edgesIgnoringSafeArea(.top)
//                .background(Color("BG1"))
//        }.overlay(overlayView: BannerComponent.init(data: BannerComponent.BannerDataModel(title: "Erreur", detail: "Aucun itinéraire ne peut être généré", type: .error), show: $error), show: $error)
//    }
//
//    private func calculateTimeDifferenceInMinutes(startDate: Date, endDate: Date) -> Int {
//        let calendar = Calendar.current
//        let components = calendar.dateComponents([.minute], from: startDate, to: endDate)
//        
//        if let minutes = components.minute {
//            return abs(minutes)
//        }
//        
//        return 0
//    }
//    
//    func createButton(title: LocalizedStringKey, isExpanded: Binding<Bool>, size: CGFloat, picture: String) -> some View {
//        Button(action: {
//            withAnimation {
//                isExpanded.wrappedValue.toggle()
//            }
//        }) {
//            VStack {
//                Image(picture)
//                    .resizable()
//                    .frame(width: size, height:  size)
//                    .padding()
//                HStack {
//                    Text(title)
//                        .foregroundColor(Color("BG1"))
//                        .font(.headline)
//                    Spacer()
//                    Image(systemName: isExpanded.wrappedValue ? "chevron.up.circle.fill" : "chevron.down.circle.fill")
//                        .foregroundColor(colorWhite)
//                }
//            }.padding(.bottom, 10)
//                .frame(width: size)
//                .foregroundColor(.white)
//                .background(
//                    RoundedRectangle(cornerRadius: 10)
//                        .fill(colorGold)
//                )
//        }
//    }
//        
//    func createSubButton(item: (LocalizedStringKey, String)) -> some View {
//        Button(action: {
//            if selectedItems.contains(item.1) {
//                selectedItems.removeAll { $0 == item.1 }
//            } else {
//                selectedItems.append(item.1)
//            }
//        }) {
//            HStack {
//                Text(item.0)
//                    .foregroundColor(selectedItems.contains(item.1) ? colorGold : Color("BG1"))
//                Spacer()
//                if selectedItems.contains(item.1) {
//                    Image(systemName: "checkmark")
//                        .foregroundColor(colorGold)
//                }
//            }
//            .padding()
//            .background(selectedItems.contains(item.1) ? Color("BG1") : Color.secondary.opacity(0.1))
//            .cornerRadius(8)
//        }
//    }
//    
//    func createButtonProfil(item: ResponseProfilOption) -> some View {
//        Button(action: {
//            if selectedProfilID == item.id {
//                selectedProfilID = nil
//                numberAdults = 0
//                numberKids = 0
//                selectedItems = []
//            } else {
//                selectedProfilID = item.id
//                numberAdults = item.adultCount
//                numberKids = item.childCount
//                selectedItems = item.InterestPointTypes.map { $0.name }
//            }
//        }) {
//            HStack {
//                Text(item.name)
//                    .foregroundColor(selectedProfilID == item.id ? colorGold : Color("BG1"))
//                    .font(.system(size: 16))
//                if selectedProfilID == item.id {
//                    Image(systemName: "checkmark")
//                        .foregroundColor(colorGold)
//                }
//            }
//            .padding(10)
//            .background(selectedProfilID == item.id ? Color("BG1") : Color.secondary.opacity(0.1))
//            .cornerRadius(10)
//        }
//    }
//}
//
//struct ItineraryView_Previews: PreviewProvider {
//    static var previews: some View {
//        ItineraryView(array: DataStore().itineraryArray, itID: DataStore().itineraryID)
//            .environmentObject(MapModel())
//            .environmentObject(MapAPI(dataStore: DataStore()))
//    }
//}
