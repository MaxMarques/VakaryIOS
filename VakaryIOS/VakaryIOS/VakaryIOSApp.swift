//
//  VakaryIOSApp.swift
//  VakaryIOS
//
//  Created by Marques on 14/08/2023.
//

import SwiftUI

@main
struct VakaryIOSApp: App {
    @StateObject private var appTheme = AppTheme()
    @StateObject var dataStore = DataStore()
    @StateObject private var languageManager = LanguageManager()
    var body: some Scene {
        WindowGroup {
            WelcomeView()
                .environmentObject(appTheme)
                .environmentObject(dataStore)
                .preferredColorScheme(appTheme.colorScheme == .dark ? .dark : .light)
//                .environmentObject(languageManager)
//                .environment(\.locale, .init(identifier: languageManager.selectedLanguage))
        }
    }
}
