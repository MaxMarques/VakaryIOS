//
//  AppTheme.swift
//  Vakary
//
//  Created by Thibaut  Humbert on 29/05/2023.
//

import SwiftUI

class AppTheme: ObservableObject {
    @Published var colorScheme: UIUserInterfaceStyle = .light {
        didSet {
            UserDefaults.standard.set(colorScheme.rawValue, forKey: "AppColorScheme")
        }
    }
    
    init() {
        let storedColorScheme = UserDefaults.standard.integer(forKey: "AppColorScheme")
        if let loadedColorScheme = UIUserInterfaceStyle(rawValue: storedColorScheme) {
            colorScheme = loadedColorScheme
        }
    }
}

