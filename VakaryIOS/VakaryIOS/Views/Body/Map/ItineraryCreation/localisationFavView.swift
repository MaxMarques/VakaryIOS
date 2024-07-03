//
//  localisationFavView.swift
//  VakaryIOS
//
//  Created by Marques on 11/19/23.
//

import SwiftUI

struct localisationFavView: View {
    @EnvironmentObject var mapAPI: MapAPI
    @EnvironmentObject var itineraryCreation: ItineraryCreation
    @State private var colorBlack = Color.black
    @State private var colorGold = Color(red: 0.927, green: 0.713, blue: 0.104)
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Color("Color3")
                    .ignoresSafeArea()
                VStack {
                    ZStack {
                        Image("world")
                            .resizable()
                            .frame(width: geometry.size.width, height:  geometry.size.height/3.5)
                        Text(UserDefaults.standard.string(forKey: "city") ?? "")
                            .font(.system(size: geometry.size.height/14, weight: .light, design: .serif))
                            .foregroundColor(Color("Color4"))
                    }
                    VStack {
                        Text(LocalizedStringKey("ItineraryV74"))
                            .font(.system(size: geometry.size.height/30, weight: .bold))
                            .foregroundColor(Color("Color5"))
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.horizontal, 50)
                    }
                    VStack {
                        VStack{
                            Picker("Options", selection: $itineraryCreation.selectedOption) {
                                Text(LocalizedStringKey("ItineraryV71")).tag(0)
                                Text(LocalizedStringKey("ItineraryV72")).tag(1)
                            }
                            .pickerStyle(SegmentedPickerStyle())
                            if itineraryCreation.selectedOption == 1 {
                                TextField(LocalizedStringKey("ItineraryV72"), text: $itineraryCreation.cityName)
                                    .textFieldStyle(RoundedBorderTextFieldStyle())
                                    .padding(.horizontal, 30)
                                    .padding(.top, 20)
                            }
                        }.onAppear {
                            if itineraryCreation.selectedOption == 0 {
                                itineraryCreation.cityName = UserDefaults.standard.string(forKey: "city") ?? ""
                            }
                        }
                        .padding(.vertical, 20)
                        .padding(.horizontal, 10)
                    }.background(Color("Color1"))
                        .cornerRadius(10)
                        .padding(.horizontal, 40)
                        .padding(.top, 10)
                    VStack {
                        Text(LocalizedStringKey("ItineraryV75"))
                            .font(.system(size: geometry.size.height/30, weight: .bold))
                            .foregroundColor(Color("Color5"))
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.horizontal, 50)
                    }
                    VStack {
                        VStack {
                            Text(LocalizedStringKey("ItineraryV69"))
                                .font(.system(size: geometry.size.height/40))
                                .foregroundColor(colorBlack)
                                .bold()
                                .frame(maxWidth: .infinity, alignment: .center)
                                .padding(.horizontal, 20)
                            if itineraryCreation.profilOption.isEmpty {
                                Text(LocalizedStringKey("Ancun"))
                                    .font(.system(size: geometry.size.height/40))
                                    .foregroundColor(colorBlack)
                                    .frame(maxWidth: .infinity, alignment: .center)
                                    .padding(.horizontal, 50)
                            } else {
                                ScrollView(.horizontal, showsIndicators: false) {
                                    HStack(spacing: 10) {
                                        ForEach(itineraryCreation.profilOption, id: \.id) { option in
                                            createButtonProfil(item: option)
                                        }
                                    }
                                }
                            }
                        }.padding(.horizontal, 30)
                            .padding(.vertical, 20)
                    }.background(Color("Color1"))
                        .cornerRadius(10)
                        .padding(.horizontal, 40)
                        .padding(.top, 10)
                    VStack {
                        Spacer()
                        Button(action:
                                itineraryCreation.timeBudget
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
                }
            }.task {
                do {
                    itineraryCreation.profilOption = try await self.mapAPI.getAllTravelProfil()
                }
                catch {
                    print(error)
                }
            }
            .edgesIgnoringSafeArea(.top)
        }
    }
    func createButtonProfil(item: ResponseProfilOption) -> some View {
        Button(action: {
            if itineraryCreation.selectedProfilID == item.id {
                itineraryCreation.selectedProfilID = nil
                itineraryCreation.numberAdults = 0
                itineraryCreation.numberKids = 0
                itineraryCreation.selectedItems = []
            } else {
                itineraryCreation.selectedProfilID = item.id
                itineraryCreation.numberAdults = item.adultCount
                itineraryCreation.numberKids = item.childCount
                itineraryCreation.selectedItems = item.InterestPointTypes.map { $0.name }
            }
        }) {
            HStack {
                Text(item.name)
                    .foregroundColor(itineraryCreation.selectedProfilID == item.id ? colorGold : Color("Color5"))
                    .font(.system(size: 16))
                if itineraryCreation.selectedProfilID == item.id {
                    Image(systemName: "checkmark")
                        .foregroundColor(colorGold)
                }
            }
            .padding(10)
            .background(itineraryCreation.selectedProfilID == item.id ? Color("Color5") : Color("Color3"))
            .cornerRadius(10)
        }
    }
}

#Preview {
    localisationFavView()
}
