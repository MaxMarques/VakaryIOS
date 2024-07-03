//
//  ItineraryCreation.swift
//  VakaryIOS
//
//  Created by Marques on 11/19/23.
//

import Foundation

class ItineraryCreation: ObservableObject {
    @Published var pageNumber = 0
    @Published var cityName = ""
    @Published var selectedOption = 0
    @Published var selectedProfilID: String?
    @Published var numberAdults: Int = 0
    @Published var numberKids: Int = 0
    @Published var selectedItems: [String] = []
    @Published var startDate = Date()
    @Published var endDate = Date()
    @Published var price = 0.0
    @Published var isIPTourExpanded = false
    @Published var isIPTEventExpanded = false
    @Published var isIPTNaturalExpanded = false
    @Published var isIPTActivityExpanded = false
    @Published var isIPTDrinkingExpanded = false
    @Published var isIPTCulturalExpanded = false
    @Published var isIPTEatingExpanded = false
    @Published var handicapAccess: Bool = false
    @Published var favoris: Bool = false
    @Published var favorisName = ""
    @Published var groupId: String = ""
    @Published var swipeFonctionnality = false
    @Published var error: Bool = false
    @Published var profilOption: [ResponseProfilOption] = []
    @Published var tinderArray: [InterestPoint] = []
   
    func localisationFav() {
        pageNumber = 0
    }
    
    func timeBudget() {
        pageNumber = 1
    }
    
    func adultChild() {
        pageNumber = 2
    }

    func poi() {
        pageNumber = 3
    }
    
    func groupeDisabled() {
        pageNumber = 4
    }

    func swip() {
        pageNumber = 5
    }
}
