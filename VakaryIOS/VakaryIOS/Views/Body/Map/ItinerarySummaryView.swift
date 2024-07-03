//
//  ItinerarySummaryView.swift
//  Vakary
//
//  Created by Marques on 17/11/2022.
//
import SwiftUI

struct ItinerarySummaryView: View {
    @StateObject var watch = Watch()
    @EnvironmentObject var map: MapModel
    @State private var colorWhite = Color.white
    @State private var colorGold = Color(red: 0.927, green: 0.713, blue: 0.104)
    let location: [InterestPoint]

    var body: some View {
        GeometryReader { geometry in
            ScrollView {
                VStack {
                    ZStack {
                        Image("world")
                            .resizable()
                            .frame(width: geometry.size.width, height:  geometry.size.height/3.5)
                        Text(UserDefaults.standard.string(forKey: "city") ?? "")
                            .font(.system(size: geometry.size.height/14, weight: .light, design: .serif))
                            .foregroundColor(colorGold)
                    }
                    VStack {
                        Text(LocalizedStringKey("ItinerarySummV2"))
                            .font(.system(size: geometry.size.height/30))
                            .foregroundColor(Color("Color5"))
                            .bold()
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.horizontal, 50)
                        Text(watch.timeString)
                            .font(.system(size: geometry.size.height/30))
                            .foregroundColor(colorGold)
                            .bold()
                            .frame(maxWidth: .infinity, alignment: .center)
                            .padding(.horizontal, 50)
                            .padding(.top, 20)
                    }.padding(.top, 10)
                    VStack {
                        Text(LocalizedStringKey("ItinerarySummV3"))
                            .font(.system(size: geometry.size.height/30))
                            .foregroundColor(Color("Color5"))
                            .bold()
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.horizontal, 50)
                        if !location.isEmpty {
                            ForEach(location,id: \.id){ loc in
                                Text(loc.name ?? "")
                                    .font(.system(size: geometry.size.height/40))
                                    .foregroundColor(colorGold)
                                    .frame(maxWidth: .infinity, alignment: .center)
                                    .padding(.horizontal, 50)
                                    .padding(.top, 20)
                            }
                        } else {
                            Image(systemName: "eye.slash.fill")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: geometry.size.height/30, height: geometry.size.height/30)
                                .foregroundColor(colorGold)
                                .padding(.horizontal, 50)
                                .padding(.top, 20)
                        }
                    }.padding(.top, 40)
                    VStack {
                        Text(LocalizedStringKey("ItinerarySummV4"))
                            .font(.system(size: geometry.size.height/30))
                            .foregroundColor(Color("Color5"))
                            .bold()
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.horizontal, 50)
                        Image(systemName: "eye.slash.fill")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: geometry.size.height/30, height: geometry.size.height/30)
                            .foregroundColor(colorGold)
                            .padding(.horizontal, 50)
                            .padding(.top, 20)

//                        ForEach(0..<itemSeen.count,id: \.self){ i in
//                            Text(itemSeen[i])
//                                .font(.system(size: geometry.size.height/40))
//                                .foregroundColor(colorGold)
//                                .frame(maxWidth: .infinity, alignment: .center)
//                                .padding(.horizontal, 50)
//                                .padding(.top, 20)
//                        }
                    }.padding(.top, 40)
                        .padding(.bottom, 40)
                    VStack {
                        Button(action: {
                            watch.reset()
                            map.itineraryChoice = false
                        }) {
                            Text(LocalizedStringKey("ItinerarySummV5"))
                                .font(.title3.bold())
                                .foregroundColor(Color("Color3"))
                                .padding(.vertical, 22)
                                .frame(width: geometry.size.width/1.5, height: 70)
                                .background(Color("Color5"))
                                .cornerRadius(100)
                        }.padding(.bottom, 15)
                    }.padding(.bottom, 140)
                }
            }.onAppear {
                watch.start()
            }
            .edgesIgnoringSafeArea(.top)
                .background(Color("Color1"))
        }
    }
}

struct ItinerarySummaryView_Previews: PreviewProvider {
    static var previews: some View {
        ItinerarySummaryView(location: DataStore().itineraryArray)
            .environmentObject(MapModel())
    }
}
