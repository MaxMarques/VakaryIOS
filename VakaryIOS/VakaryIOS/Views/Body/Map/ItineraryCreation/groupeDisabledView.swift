//
//  groupeDisabledView.swift
//  VakaryIOS
//
//  Created by Marques on 11/21/23.
//

import SwiftUI

struct groupeDisabledView: View {
    @ObservedObject var group = GroupAPI()
    @EnvironmentObject var itineraryCreation: ItineraryCreation
    @EnvironmentObject var dataStore: DataStore
    @EnvironmentObject var map: MapModel
    @EnvironmentObject var mapAPI: MapAPI
    @State private var selectedGroup: Group?
    @State var arrayGroup: [Group] = []
    @State private var colorBlack = Color.black
    @State var itID: String {
        didSet {
            DispatchQueue.main.async {
                dataStore.itineraryID = itID
            }
        }
    }
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Color("Color3")
                    .ignoresSafeArea()
                VStack {
                    VStack {
                        HStack {
                            Button(action:
                                    itineraryCreation.poi
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
                        Text(LocalizedStringKey("ItineraryV80"))
                            .font(.system(size: geometry.size.height/30, weight: .bold))
                            .foregroundColor(Color("Color5"))
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.horizontal, 50)
                    }.padding(.top, 10)
                    VStack {
                        VStack {
                            Text(LocalizedStringKey("ItineraryV8"))
                                .font(.system(size: geometry.size.height/40))
                                .foregroundColor(colorBlack)
                                .bold()
                                .frame(maxWidth: .infinity, alignment: .center)
                                .padding(.horizontal, 20)
                            Picker("Choisissez un groupe", selection: $selectedGroup) {
                                if selectedGroup == nil {
                                    Text(LocalizedStringKey("ItineraryV9"))
                                        .tag(nil as Group?)
                                }
                                ForEach(arrayGroup) { group in
                                    Text(group.name)
                                        .tag(group as Group?)
                                }
                            }.accentColor(Color("Color5"))
                                .onChange(of: selectedGroup) { newSelectedGroup in
                                if let group = newSelectedGroup {
                                    itineraryCreation.groupId = group.id
                                } else {
                                    itineraryCreation.groupId = ""
                                }
                            }
                        }.padding(.horizontal, 30)
                            .padding(.vertical, 20)
                    }.background(Color("Color1"))
                        .cornerRadius(10)
                        .padding(.horizontal, 40)
                        .padding(.top, 10)

                    VStack {
                        VStack {
                            Toggle(LocalizedStringKey("ItineraryV11"), isOn: $itineraryCreation.handicapAccess)
                                .font(.system(size: geometry.size.height/45))
                                .foregroundColor(colorBlack)
                        }.padding(.horizontal, 30)
                            .padding(.vertical, 20)
                    }.background(Color("Color1"))
                        .cornerRadius(10)
                        .padding(.horizontal, 40)
                        .padding(.top, 10)

                    VStack {
                        VStack {
                            Toggle(LocalizedStringKey("ItineraryV70"), isOn: $itineraryCreation.favoris)
                                .font(.system(size: geometry.size.height/45))
                                .foregroundColor(colorBlack)
                            if itineraryCreation.favoris {
                                TextField(LocalizedStringKey("ItineraryV73"), text: $itineraryCreation.favorisName)
                                    .textFieldStyle(RoundedBorderTextFieldStyle())
                                    .padding(.horizontal, 40)
                                    .padding(.top, 20)
                            }
                        }.padding(.horizontal, 30)
                            .padding(.vertical, 20)
                    }.background(Color("Color1"))
                        .cornerRadius(10)
                        .padding(.horizontal, 40)
                        .padding(.top, 10)
                    VStack {
                        Spacer()
                        Button(action: {
                            Task {
                                do {
                                    if itineraryCreation.favoris {
                                        let paramTravel = getOptions(profilFields: ProfileFields(name: itineraryCreation.favorisName, adultCount: itineraryCreation.numberAdults, childCount: itineraryCreation.numberKids, babyCount: 0), typeOfPoi: itineraryCreation.selectedItems)
                                        try await self.mapAPI.createTravelProfil(options: paramTravel)
                                    }
                                    let minutes = calculateTimeDifferenceInMinutes(startDate: itineraryCreation.startDate, endDate: itineraryCreation.endDate)
                                    let param = getItinerary(userId: 0, nbPeople: itineraryCreation.numberAdults, nbChild: itineraryCreation.numberKids, budget: Int(itineraryCreation.price), availableTime: minutes, typeResearchLocations: itineraryCreation.selectedItems, handicapAccess: itineraryCreation.handicapAccess, city: itineraryCreation.cityName)
                                    let result = try await self.mapAPI.getWayPoint(itinerary: param)
                                    itineraryCreation.tinderArray = result.0
                                    itID = result.1
                                    if itineraryCreation.tinderArray.count == 0 {
                                        itineraryCreation.error = true
                                    } else {
                                        itineraryCreation.swip()
                                    }
                                } catch {
                                    print(error)
                                }
                            }
                        }) {
                            Text(LocalizedStringKey("SignUpV3"))
                                .font(.title3.bold())
                                .foregroundColor(Color("Color3"))
                                .padding(.vertical, 22)
                                .frame(width: geometry.size.width/1.5, height: 70)
                                .background(Color("Color5"))
                                .cornerRadius(100)
                        }
                        .padding(.bottom, 15)
                        Spacer()
                        Spacer()
                    }
                }
                if mapAPI.isLoading {
                    LoaderComponent()
                }
            }
            .task {
                do {
                    arrayGroup = try await group.getMyAllGroup()
                }
                catch {
                    print(error)
                }
            }
            .edgesIgnoringSafeArea(.top)
        }.overlay(overlayView: BannerComponent.init(data: BannerComponent.BannerDataModel(title: "Erreur", detail: LocalizedStringKey("ItineraryV81"), type: .error), show: $itineraryCreation.error), show: $itineraryCreation.error)
    }
    private func calculateTimeDifferenceInMinutes(startDate: Date, endDate: Date) -> Int {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.minute], from: startDate, to: endDate)

        if let minutes = components.minute {
            return abs(minutes)
        }

        return 0
    }
}

#Preview {
    groupeDisabledView(itID: DataStore().itineraryID)
}
