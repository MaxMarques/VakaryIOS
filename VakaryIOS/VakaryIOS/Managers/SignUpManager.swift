//
//  SignUpManager.swift
//  Vakary
//
//  Created by Marques on 27/03/2023.
//

import Foundation
import SwiftUI

struct SignUpManager: Codable {
    let message: String?
    let user: UserRegister
}

struct UserRegister: Codable {
    let id: String?
    let username: String?
    let number: Int?
    let firstname: String?
    let lastname: String?
    let description: String?
    let likes: Int?
    let comments: Int?
    let milesTraveled: Int?
    let lastMonument: String?
    let lastEvent: String?
    let email: String?
    let password: String?
    let faceIdConnection: String?
    let verified: String?
    let createdAt: String?
    let updatedAt: String?
    let token: String?
}
