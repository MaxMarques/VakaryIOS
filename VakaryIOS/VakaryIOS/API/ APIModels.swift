//
//   APIModels.swift
//  Vakary
//
//  Created by Marques on 20/06/2023.
//

import Foundation

struct CreatedItinerary: Codable {
    let id: String
    let data: String
}

struct ItineraryData: Codable {
    let createdItinerary: CreatedItinerary
}

struct ResponseModel: Decodable {
    let message: String
    let itinerary: [listItinerary]
}

struct listItinerary: Codable {
    let id: String?
    let data: String
    let userId: String?
    let createdAt: String?
    let updatedAt: String?
}

struct InterestPoint: Codable {
    let id: String?
    let name: String?
    let likes: Int?
    let averageTime: Int?
    let averagePrice: String?
    let covidRestriction: Bool?
    let handicapAccess: Bool?
    let image: String?
    let createdAt: String?
    let updatedAt: String?
    let descriptionId: String?
    let localisationId: String?
    let contactId: String?
    let City: City?
    let Localisation: Localisation?
    let Contact: Contact?
    let Description: Description?
    let InterestPointWithType: [InterestPointWithType]?
}

struct City: Codable {
    let id: String?
    let name: String?
    let code: Int?
    let localisation: Localisation?
}

struct Localisation: Codable {
    let id: String?
    let longitude: Double?
    let latitude: Double?
}

struct Contact: Codable {
    let id: String?
    let email: String?
    let phone: String?
    let websiteLink: String?
}

struct Description: Codable {
    let id: String?
    let fr: String?
    let en: String?
    let de: String?
    let es: String?
}

struct Chat: Codable {
    let id: String
    let name: String
}

struct InterestPointWithType: Codable {
    let id: String?
    let name: String?
    let group: String?
    let interestPointWithType: InterestPointWithTypeDetail?
}

struct InterestPointWithTypeDetail: Codable {
    let id: String?
    let createdAt: String?
    let updatedAt: String?
    let interestPointId: Int?
    let interestPointTypeId: Int?
}
