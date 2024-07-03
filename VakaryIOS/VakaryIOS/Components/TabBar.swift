//
//  TabBar.swift
//  Vakary
//
//  Created by Marques on 12/08/2023.
//

import SwiftUI

struct TabBar: View {
    @EnvironmentObject var routerModels: Router
    @EnvironmentObject var map: MapModel
    var body: some View {
        GeometryReader { geometry in
            VStack {
                Spacer()
                HStack {
                    TabBarIcon(routerModels:routerModels, assignedPage: .map, width: geometry.size.width/5.60, height: geometry.size.height/28, systemIconName: "map", tabName: LocalizedStringKey("MainV2"))
                    TabBarIcon(routerModels:routerModels, assignedPage: .group, width: geometry.size.width/5.60, height: geometry.size.height/28, systemIconName: "person.2.fill", tabName: LocalizedStringKey("MainV1"))
                    ZStack {
                        if !map.changeCreateItineraryButton {
                            Image("LogoVakary")
                                .resizable()
                                .frame(width: geometry.size.width/6, height: geometry.size.width/6)
                                .shadow(radius: 4)
                                .rotationEffect(Angle(degrees: map.annimCreateItineraryButton ? 360 : 0))
                        } else {
                            Image(systemName: "xmark.circle")
                                .resizable()
                                .frame(width: geometry.size.width/6, height: geometry.size.width/6)
                                .shadow(radius: 4)
                                .rotationEffect(Angle(degrees: map.annimCreateItineraryButton ? 360 : 0))
                                .foregroundColor(Color(red: 0.927, green: 0.713, blue: 0.104))
                        }
                    }
                    .offset(y: -geometry.size.height/18/2)
                    .onTapGesture {
                        withAnimation {
                            map.annimCreateItineraryButton.toggle()
                            map.showCreateItineraryPage.toggle()
                            routerModels.currentPage = .map
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                                map.changeCreateItineraryButton.toggle()
                            }
                            map.showPointInterestDetail = false
                        }
                    }
                    TabBarIcon(routerModels:routerModels, assignedPage: .profil, width: geometry.size.width/5.60, height: geometry.size.height/28, systemIconName: "person", tabName: LocalizedStringKey("MainV3"))
                    TabBarIcon(routerModels:routerModels, assignedPage: .settings, width: geometry.size.width/5.60, height: geometry.size.height/28, systemIconName: "gear", tabName: LocalizedStringKey("MainV4"))
                }.frame(width: geometry.size.width/1, height: geometry.size.height/9)
                    .background(Color("Color3"))
                    .shadow(radius: 2)
            }.edgesIgnoringSafeArea(.bottom)
        }
    }
}

struct TabBar_Previews: PreviewProvider {
    static var previews: some View {
        let router = Router()
        let map = MapModel()

        TabBar()
            .environmentObject(map)
            .environmentObject(router)
    }
}
