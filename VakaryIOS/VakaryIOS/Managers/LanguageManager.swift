//
//  LanguageManager.swift
//  VakaryIOS
//
//  Created by Thibaut  Humbert on 30/12/2023.
//

import Foundation
import SwiftUI

class LanguageManager: ObservableObject {
    static let shared = LanguageManager()

        @Published var selectedLanguage: String {
            didSet {
                UserDefaults.standard.set([selectedLanguage], forKey: "AppleLanguages")
                Bundle.main.loadLanguage(selectedLanguage)
            }
        }

        init() {
            self.selectedLanguage = UserDefaults.standard.string(forKey: "AppleLanguages") ?? "fr"
            Bundle.main.loadLanguage(selectedLanguage)
        }
}

extension Bundle {
    func loadLanguage(_ language: String) {
        guard let path = self.path(forResource: language, ofType: "lproj") else {
            return
        }
        guard let bundle = Bundle(path: path) else {
            return
        }
        object_setClass(self, type(of: bundle))
    }
}

//extension LocalizedStringKey {
//    func localized(using languageManager: LanguageManager) -> String {
//        return NSLocalizedString(String(describing: self), comment: "")
//    }
//}
