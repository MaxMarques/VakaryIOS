//
//  Walkthrough.swift
//  Vakary
//
//  Created by Marques on 26/01/2023.
//

import Foundation
import SwiftUI

struct Walkthrough: Identifiable {
    let id = UUID()
    var name: LocalizedStringKey
    var description: LocalizedStringKey
    var imageUrl: String
    var tag: Int
    
    static var samplePage = Walkthrough(name: "Title Example", description: "This is a sample description for the purpose of debugging", imageUrl: "World1", tag: 0)
    
    static var samplePages: [Walkthrough] = [
        Walkthrough(name: LocalizedStringKey("WalkthroughN1"), description: "", imageUrl: "World1", tag: 0),
        Walkthrough(name: LocalizedStringKey("WalkthroughN2"), description: LocalizedStringKey("WalkthroughD2"), imageUrl: "AtPark", tag: 1),
        Walkthrough(name: LocalizedStringKey("WalkthroughN3"), description: LocalizedStringKey("WalkthroughD3"), imageUrl: "Map", tag: 2),
        Walkthrough(name: LocalizedStringKey("WalkthroughN4"), description: LocalizedStringKey("WalkthroughD4"), imageUrl: "Group2", tag: 3),
        Walkthrough(name: LocalizedStringKey("WalkthroughN5"), description: LocalizedStringKey("WalkthroughD5"), imageUrl: "Adventure2", tag: 4)
        ]
}
