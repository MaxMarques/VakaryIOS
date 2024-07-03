//
//  Map.swift
//  Vakary
//
//  Created by Marques on 04/08/2023.
//

import Foundation
import CoreLocation

class MapModel: ObservableObject {
    @Published var annimCreateItineraryButton: Bool = false
    @Published var itineraryChoice: Bool = false
    @Published var interestPointChoice: CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: 0, longitude: 0)
    @Published var showCreateItineraryPage: Bool = false
    @Published var changeCreateItineraryButton: Bool = false
    @Published var showPointInterestDetail: Bool = false
    @Published var closePointInterest: Bool = false
    @Published var centerUserLoclisation: Bool = false
}
