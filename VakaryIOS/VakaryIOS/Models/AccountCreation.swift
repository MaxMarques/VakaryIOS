//
//  AccountCreation.swift
//  Vakary
//
//  Created by Marques on 27/01/2023.
//

import Foundation

class AccountCreation: ObservableObject {
    @Published var phNumber = ""
    @Published var countryCode = "+33"
    @Published var email = ""
    @Published var OTPCode: String = ""
    @Published var passWord: String = ""
    @Published var repeatPassWord: String = ""
    @Published var pseudo: String = ""
    @Published var pageNumber = 0
    
    func phoneNb() {
        pageNumber = 0
    }
    
    func mail() {
        pageNumber = 1
    }

    func start() {
        pageNumber = 2
    }
    
//    func verifCode() {
//        pageNumber = 3
//    }
    
    func password() {
        pageNumber = 3
    }
    
    func profil() {
        pageNumber = 4
    }
}
