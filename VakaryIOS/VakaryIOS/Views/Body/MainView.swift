//
//  MainView.swift
//  Vakary
//
//  Created by Marques on 17/10/2022.
//

import SwiftUIFontIcon
import SwiftUI
import CoreLocation

struct MainView: View {
    @StateObject var routerModels: Router
    @EnvironmentObject var dataStore: DataStore
    @EnvironmentObject var map: MapModel
    @State private var isLoggingOut = false
    @StateObject var signIn = SignIn()
    let soundManager = SoundManager.shared
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                switch routerModels.currentPage {
                case .group:
                    GroupView(routerModels: routerModels)
                        .environmentObject(map)
                        .environmentObject(GroupAPI())
                        .environmentObject(Profil())
                case .map:
                    MapView()
                        .environmentObject(map)
                        .environmentObject(dataStore)
                case .profil:
                    ProfilView()
                        .environmentObject(Profil())
                case .settings:
                    SettingsView(dataStore: dataStore)
                        .environmentObject(signIn)
                        .environmentObject(map)
                }
                MainItineraryPageView(dataStore: dataStore)
                    .environmentObject(map)
                TabBar()
                    .environmentObject(map)
                    .environmentObject(routerModels)
            }
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView(routerModels: Router())
    }
}
