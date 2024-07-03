//
//  SettingManager.swift
//  VakaryIOS
//
//  Created by Thibaut  Humbert on 28/12/2023.
//

import Foundation

class SettingsManager: ObservableObject {
    @Published var speedItinerary: Double {
        didSet {
            UserDefaults.standard.set(speedItinerary, forKey: "SpeedItinerary")
        }
    }

    init() {
        self.speedItinerary = UserDefaults.standard.double(forKey: "SpeedItinerary")
    }
}
