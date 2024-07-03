//
//  RouterComponent.swift
//  Vakary
//
//  Created by Marques on 19/10/2022.
//

import SwiftUI

class Router: ObservableObject {
    @Published var currentPage: Page = .map
}

enum Page {
    case group
    case map
    case profil
    case settings
}
