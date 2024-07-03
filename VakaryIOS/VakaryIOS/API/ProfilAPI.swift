//
//  ProfilAPI.swift
//  Vakary
//
//  Created by Thibaut  Humbert on 04/04/2023.
//

import Foundation
import Combine
import SwiftUI
import Alamofire

class Profil: ObservableObject {
    var didChange = PassthroughSubject<Profil, Never>()
    @Published var updateProfil: Bool = false
    @Published var updateProfilError: Bool = false
    @Published var isLoading: Bool = false

    func getMyUser() async throws -> UserInfo {
        self.isLoading = true
        let url = URL(string: "https://eip.vakary.fr/v1/me")!

        var request = URLRequest(url: url)
        let token = UserDefaults.standard.string(forKey: "token")
        print("token profil: " + (token ?? "token null"))
        request.setValue(token, forHTTPHeaderField: "Authorization")
        request.httpMethod = "GET"

        let (data, _) = try await URLSession.shared.data(for: request)

        let decoder = JSONDecoder()
        
        do {
            let response = try decoder.decode(ResponseUserInfo.self, from: data)
            
            self.isLoading = false
            return response.user
        } catch {
            print("Erreur lors du décodage JSON : \(error)")
            self.isLoading = false
            throw error
        }
    }
    
    func changePassword(password: String) async throws {
        guard let url = URL(string: "https://eip.vakary.fr/v1/changePassword") else {
            return
        }
        
        let body: [String: String] = ["password": password]
        guard let finalBody = try? JSONSerialization.data(withJSONObject: body) else {
            return
        }
        
        var request = URLRequest(url: url)
        let token = UserDefaults.standard.string(forKey: "token")
        
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue(token ?? "", forHTTPHeaderField: "Authorization")
        request.httpMethod = "POST"
        request.httpBody = finalBody
        
        URLSession.shared.uploadTask(with: request, from: finalBody) { (responseData, response, error) in
            
            if let error = error {
                    print("Error making PUT request: \(error.localizedDescription)")
                    return
                }
                
            if let responseCode = (response as? HTTPURLResponse)?.statusCode, let responseData = responseData {
                if let responseJSONData = try? JSONSerialization.jsonObject(with: responseData, options: .allowFragments) {
                    print("Response JSON data = \(responseJSONData)")
                }
                guard responseCode == 200 else {
                    print("Invalid response code: \(responseCode)")
                    return
                }
            }
        }.resume()
    }
    
    func forgotPassword(email: String) async throws {
        guard let url = URL(string: "https://eip.vakary.fr/v1/forgotPassword") else {
            return
        }
        
        let body: [String: String] = ["email": email]
        guard let finalBody = try? JSONSerialization.data(withJSONObject: body) else {
            return
        }
        
        var request = URLRequest(url: url)
//        let token = UserDefaults.standard.string(forKey: "token")
        
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
//        request.setValue(token ?? "", forHTTPHeaderField: "Authorization")
        request.httpMethod = "POST"
        request.httpBody = finalBody
        
        URLSession.shared.uploadTask(with: request, from: finalBody) { (responseData, response, error) in
            
            if let error = error {
                    print("Error making PUT request: \(error.localizedDescription)")
                    return
                }
                
            if let responseCode = (response as? HTTPURLResponse)?.statusCode, let responseData = responseData {
                if let responseJSONData = try? JSONSerialization.jsonObject(with: responseData, options: .allowFragments) {
                    print("Response JSON data = \(responseJSONData)")
                }
                guard responseCode == 200 else {
                    print("Invalid response code: \(responseCode)")
                    return
                }
            }
        }.resume()
    }
    
    func deleteProfil() async throws {
        self.isLoading = true
        guard let url = URL(string: "https://eip.vakary.fr/v1/me") else {
            print("Error: cannot create URL")
            return
        }
        
        var request = URLRequest(url: url)
        let token = UserDefaults.standard.string(forKey: "token")
        request.setValue(token, forHTTPHeaderField: "Authorization")
        request.httpMethod = "DELETE"
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard error == nil else {
                print("Error: error calling DELETE")
                print(error!)
                self.isLoading = false
                return
            }
            guard let data = data else {
                print("Error: Did not receive data")
                self.isLoading = false
                return
            }
            guard let response = response as? HTTPURLResponse, (200 ..< 299) ~= response.statusCode else {
                print("Error: HTTP request failed")
                self.isLoading = false
                return
            }
            if response.statusCode == 200 {
                self.isLoading = false
            }
            do {
                guard let jsonObject = try JSONSerialization.jsonObject(with: data) as? [String: Any] else {
                    print("Error: Cannot convert data to JSON")
                    self.isLoading = false
                    return
                }
                guard let prettyJsonData = try? JSONSerialization.data(withJSONObject: jsonObject, options: .prettyPrinted) else {
                    print("Error: Cannot convert JSON object to Pretty JSON data")
                    self.isLoading = false
                    return
                }
                guard let prettyPrintedJson = String(data: prettyJsonData, encoding: .utf8) else {
                    print("Error: Could print JSON in String")
                    self.isLoading = false
                    return
                }
                
                print(prettyPrintedJson)
            } catch {
                print("Error: Trying to convert JSON data to string")
                self.isLoading = false
                return
            }
        }.resume()
    }
    
    func updateProfil(userInfo: UpdateProfil) async throws {
        self.isLoading = true
        guard let url = URL(string: "https://eip.vakary.fr/v1/me") else {
            return
        }
        
        let body: UpdateProfil = userInfo
        let encoder = JSONEncoder()
        guard let finalBody = try? encoder.encode(body) else {
            return
        }
        
        var request = URLRequest(url: url)
        let token = UserDefaults.standard.string(forKey: "token")
        request.setValue(token ?? "", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "PATCH"
        request.httpBody = finalBody
        
        URLSession.shared.uploadTask(with: request, from: finalBody) {
            (responseData, response, error) in
            
            if let error = error {
                print("Error making PATCH request: \(error.localizedDescription)")
                return
            }
            
            if let responseCode = (response as? HTTPURLResponse)?.statusCode, let responseData = responseData {
                if let responseJSONData = try? JSONSerialization.jsonObject(with: responseData, options: .allowFragments) {
                    print("Response JSON data = \(responseJSONData)")
                }
                print("Before updateProfil: \(self.updateProfil)")
                if responseCode == 200 {
                    DispatchQueue.main.async {
                        self.updateProfil = true
                        self.isLoading = false
                        print("updateProfil: ", self.updateProfil)
                    }
                } else {
                    DispatchQueue.main.async {
                        print("Invalid response code: \(responseCode)")
                        self.updateProfilError = true
                        self.isLoading = false
                        print("updateProfilError: ", self.updateProfilError)
                    }
                }
            }
        }.resume()
    }
    
    func updateProfilPicture(profilPicture: UIImage) async throws {
        if let url = URL(string: "https://eip.vakary.fr/v1/me") {
            let filedata = profilPicture.jpegData(compressionQuality: 0.8)!
            
            AF.upload(multipartFormData: { multipartFormData in
                multipartFormData.append(filedata, withName: "profilPicture", fileName: "image.jpeg", mimeType: "image/jpeg")
            },
            to: url,
            method: .patch,
            headers: HTTPHeaders(["Authorization": UserDefaults.standard.string(forKey: "token") ?? ""])
            ).responseData { response in
                guard let statusCode = response.response?.statusCode else {
                    print("c nulle")
                    print(response.response?.statusCode as Any)
                    return
                }
                if statusCode == 200 {
                    debugPrint(response)
                } else {
                    debugPrint(statusCode)
                    debugPrint(response)
                }
            }
        } else {
            throw NSError(domain: "InvalidURL", code: 0, userInfo: nil)
        }
    }
}

struct ResponseUserInfo: Decodable {
    let message: String
    let user: UserInfo
}

struct UserInfo: Decodable, Encodable {
    let username: String?
    let id: String?
    let number: String?
    let firstname: String?
    let lastname: String?
    let description: String?
    let likes: Int?
    let comments: Int?
    let milesTraveled: Int?
    let lastMonument: String?
    let lastEvent: String?
    let email: String?
    let verified: String?
    let createdAt: String?
    let updatedAt: String?
    let picture: String?
}

struct UpdateProfil: Decodable, Encodable {
    let username: String?
    let description: String?
}
