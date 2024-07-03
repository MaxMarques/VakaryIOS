//
//  GroupAPI.swift
//  Vakary
//
//  Created by Thibaut  Humbert on 30/04/2023.
//

import Foundation
import Combine
import SwiftUI
import Alamofire

class GroupAPI: ObservableObject {
    var didChange = PassthroughSubject<GroupAPI, Never>()
    var groupIdToDelete: Int?
    @Published var allMessages: [AllMessages] = []
    @Published var groupNotCreated: Bool = false
    @Published var missingArguments: Bool = false
    @Published var emailsFalse: Bool = false
    @Published var groupCreated: Bool = false
    @Published var groupDeleted: Bool = false
    @Published var memberAdded: Bool = false
    @Published var memberNotAdded: Bool = false
    @Published var memberDeleted: Bool = false
    @Published var memberNotDeleted: Bool = false
    @Published var isLoading: Bool = false
    
    func createGroup(groupname: String, emails: String, groupPicture: UIImage) async throws {
        self.isLoading = true
        if let url = URL(string: "https://eip.vakary.fr/v1/group") {
            let filedata = groupPicture.jpegData(compressionQuality: 0.8)!
            
            AF.upload(multipartFormData: { multipartFormData in
                multipartFormData.append(filedata, withName: "groupPicture", fileName: "image.jpeg", mimeType: "image/jpeg")
                multipartFormData.append(groupname.data(using: .utf8)!, withName: "groupname")
                multipartFormData.append(emails.data(using: .utf8)!, withName: "emails")
            },
                      to: url,
                      method: .put,
                      headers: HTTPHeaders(["Authorization": UserDefaults.standard.string(forKey: "token") ?? ""])
            ).responseData { response in
                guard let statusCode = response.response?.statusCode else {
                    print("c nulle")
                    print(response.response?.statusCode as Any)
                    return
                }
                if statusCode == 200 {
                    debugPrint(response)
                    self.isLoading = false
                    self.groupCreated = true
                } else {
                    print("error")
                    self.isLoading = false
                    self.groupNotCreated = true
                }
            }
        } else {
            throw NSError(domain: "InvalidURL", code: 0, userInfo: nil)
        }
    }
    
    func updateGroupPicture(groupeId: String, groupPicture: UIImage) async throws {
        if let url = URL(string: "https://eip.vakary.fr/v1/group/\(groupeId)") {
            let filedata = groupPicture.jpegData(compressionQuality: 0.8)!
            
            AF.upload(multipartFormData: { multipartFormData in
                multipartFormData.append(filedata, withName: "groupPicture", fileName: "image.jpeg", mimeType: "image/jpeg")
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
    
    func getMyAllGroup() async throws -> [Group] {
        let url = URL(string: "https://eip.vakary.fr/v1/group/getAll/me")!
        
        var request = URLRequest(url: url)
        let token = UserDefaults.standard.string(forKey: "token")
        request.setValue(token, forHTTPHeaderField: "Authorization")
        request.httpMethod = "GET"
        
        let (data, _) = try await URLSession.shared.data(for: request)
        let decoder = JSONDecoder()
        let response = try decoder.decode(getGroupResponse.self, from: data)
        var groups = response.groups
        var index = 0
        for group in groups {
            let url = URL(string: "https://eip.vakary.fr/v1/group_user/getAll/\(group.id)")!
            
            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            
            let (data, _) = try await URLSession.shared.data(for: request)
            let decoder = JSONDecoder()
            let response = try decoder.decode(responseGroupStatus.self, from: data)
            let statut = response.groupUser
            if groups[index].picture == nil {
                groups[index].picture = "https://cpworldgroup.com/wp-content/uploads/2021/01/placeholder.png"
            }
            //            print(groups[index].picture as Any)
            groups[index].status = statut
            index += 1
        }
        return groups
    }
    
    func getChat(chatId: String) async throws {
        let url = URL(string: "https://eip.vakary.fr/v1/chat/\(chatId)")!

        var request = URLRequest(url: url)
        let token = UserDefaults.standard.string(forKey: "token")
        request.setValue(token, forHTTPHeaderField: "Authorization")
        request.httpMethod = "GET"

        let (data, _) = try await URLSession.shared.data(for: request)
        let decoder = JSONDecoder()
        
        do {                  
            let response = try decoder.decode(ResponseAllMessage.self, from: data)
            Task.detached {
                DispatchQueue.main.async {
                    print("************* -> ", response.allMessages)
                    self.allMessages = response.allMessages
                }
            }
        } catch {
            // Gérer les erreurs de décodage JSON ici
            print("Erreur lors du décodage JSON : \(error)")
        }
    }

    func sendChat(chatId: String, messageBody: String) async throws {
        guard let url = URL(string: "https://eip.vakary.fr/v1/chat/send/\(chatId)") else {
            return
        }
        
        print("messagebody = ", messageBody)
        let body: [String: Any] = ["chatId": chatId, "messageBody": messageBody]
        guard let finalBody = try? JSONSerialization.data(withJSONObject: body) else {
            return
        }
        
        var request = URLRequest(url: url)
        let token = UserDefaults.standard.string(forKey: "token")
        print("Token: \(token ?? "")")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue(token ?? "", forHTTPHeaderField: "Authorization")
        request.httpMethod = "PUT"
        request.httpBody = finalBody
        
        URLSession.shared.uploadTask(with: request, from: finalBody) { (responseData, response, error) in
            
            if let error = error {
                print("Error making PUT request: \(error.localizedDescription)")
                return
            }
            
            if let responseCode = (response as? HTTPURLResponse)?.statusCode, let responseData = responseData {
                if let responseJSONData = try? JSONSerialization.jsonObject(with: responseData, options: .allowFragments) {
                    print("$$$$$$$$$$$$$$ -> \(responseJSONData)")
                }
            }
        }.resume()
    }
    
    func updateGroupItinerary(groupId: String, itineraryId: Int) async throws {
        print("groupeId ", groupId)
        print("l'itinerarie ", itineraryId)
        guard let url = URL(string: "https://eip.vakary.fr/v1/group/\(groupId)") else {
            return
        }
        
        let body: [String: Any] = ["itineraryId": itineraryId]
        guard let finalBody = try? JSONSerialization.data(withJSONObject: body) else {
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
                guard responseCode == 200 else {
                    print("Invalid response code: \(responseCode)")
                    if let errorData = try? JSONSerialization.jsonObject(with: responseData, options: .allowFragments) {
                        print("Server error data: \(errorData)")
                    }
                    return
                }
            }
        }.resume()
    }
    
    func deleteGroup(groupId: String) async throws {
        guard let url = URL(string: "https://eip.vakary.fr/v1/group/\(groupId)") else {
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
                return
            }
            guard let data = data else {
                print("Error: Did not receive data")
                return
            }
            guard let response = response as? HTTPURLResponse, (200 ..< 299) ~= response.statusCode else {
                print("Error: HTTP request failed")
                return
            }
            if response.statusCode == 200 {
                self.groupDeleted = true
            }
            print(response.statusCode)
            do {
                guard let jsonObject = try JSONSerialization.jsonObject(with: data) as? [String: Any] else {
                    print("Error: Cannot convert data to JSON")
                    return
                }
                guard let prettyJsonData = try? JSONSerialization.data(withJSONObject: jsonObject, options: .prettyPrinted) else {
                    print("Error: Cannot convert JSON object to Pretty JSON data")
                    return
                }
                guard let prettyPrintedJson = String(data: prettyJsonData, encoding: .utf8) else {
                    print("Error: Could print JSON in String")
                    return
                }
                
                print(prettyPrintedJson)
            } catch {
                print("Error: Trying to convert JSON data to string")
                return
            }
        }.resume()
    }
    
    func acceptGroup(groupId: String, email: String, status: Bool) async throws {
        guard let url = URL(string: "https://eip.vakary.fr/v1/group_user/\(groupId)") else {
            return
        }
        
        let body: [String: Any] = ["email": email, "status": status]
        guard let finalBody = try? JSONSerialization.data(withJSONObject: body) else {
            return
        }
        
        var request = URLRequest(url: url)
        let token = UserDefaults.standard.string(forKey: "token")
//        print("Token: \(token ?? "")")
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
                guard responseCode == 200 else {
                    print("Invalid response code: \(responseCode)")
                    return
                }
            }
        }.resume()
    }
    
    func updateGroup(groupId: String, groupUpdate: GroupUpdate) async throws {
        guard let url = URL(string: "https://eip.vakary.fr/v1/group/\(groupId)") else {
            return
        }
        
        let encoder = JSONEncoder()
        let finalBody = try encoder.encode(groupUpdate)
        
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
                guard responseCode == 200 else {
                    print("Invalid response code: \(responseCode)")
                    if let errorData = try? JSONSerialization.jsonObject(with: responseData, options: .allowFragments) {
                        print("Server error data: \(errorData)")
                    }
                    return
                }
            }
        }.resume()
    }
    
    func deleteMember(groupId: String, email: String) async throws {
        guard let url = URL(string: "https://eip.vakary.fr/v1/group_user/deleteUserFromGroup") else {
            return
        }
        
        let body: [String: Any] = ["groupId": groupId, "email": email]
        guard let finalBody = try? JSONSerialization.data(withJSONObject: body) else {
            return
        }
        
        var request = URLRequest(url: url)
        let token = UserDefaults.standard.string(forKey: "token")
//        print("Token: \(token ?? "")")
        request.setValue(token ?? "", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "PATCH"
        request.httpBody = finalBody
        
        URLSession.shared.uploadTask(with: request, from: finalBody) {
            (responseData, response, error) in
            
            print("1: ", self.memberNotAdded)
            if let error = error {
                print("Error making PATCH request: \(error.localizedDescription)")
                self.memberNotDeleted = true
                return
            }
            
            if let responseCode = (response as? HTTPURLResponse)?.statusCode, let responseData = responseData {
                if let responseJSONData = try? JSONSerialization.jsonObject(with: responseData, options: .allowFragments) {
                    print("Response JSON data = \(responseJSONData)")
                }
                if (responseCode == 200 || responseCode == 502) {
                    self.memberDeleted = true
                } else {
                    print("Invalid response code: \(responseCode)")
                    self.memberNotDeleted = true
                }
            }

        }.resume()
    }
    
    func addMember(groupId: String, email: String) async throws {
        guard let url = URL(string: "https://eip.vakary.fr/v1/group/invitation/\(groupId)") else {
            return
        }
        
        let body: [String: Any] = ["groupId": groupId, "email": email]
        guard let finalBody = try? JSONSerialization.data(withJSONObject: body) else {
            return
        }
        
        var request = URLRequest(url: url)
        let token = UserDefaults.standard.string(forKey: "token")
//        print("Token: \(token ?? "")")
        request.setValue(token ?? "", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "PATCH"
        request.httpBody = finalBody
        
        URLSession.shared.uploadTask(with: request, from: finalBody) {
            (responseData, response, error) in
            print("1: ", self.memberAdded as Any)
            if let error = error {
                print("Error making PATCH request: \(error.localizedDescription)")
                self.memberNotAdded = true
                return
            }
            
            if let responseCode = (response as? HTTPURLResponse)?.statusCode, let responseData = responseData {
                if let responseJSONData = try? JSONSerialization.jsonObject(with: responseData, options: .allowFragments) {
                    print("Response JSON data = \(responseJSONData)")
                }
                if responseCode == 200 {
                    self.memberAdded = true
                    print(responseCode)
                } else {
                    print("Invalid response code: \(responseCode)")
                    self.memberNotAdded = true
                }
            }

        }.resume()
    }
    
    func getUserByEmail(email: String) async throws -> UserInfo {
        let url = URL(string: "https://eip.vakary.fr/v1/user/email/\(email)")!
        var request = URLRequest(url: url)
        
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue(UserDefaults.standard.string(forKey: "token"), forHTTPHeaderField: "Authorization")
        request.httpMethod = "GET"
        
        do {
            let (data, _) = try await URLSession.shared.data(for: request)
            let decodedData = try JSONDecoder().decode(ResponseUserInfo.self, from: data)
            return decodedData.user
        } catch {
            print("Erreur lors de la récupération de l'itinéraire par ID : \(error)")
            throw error
        }
    }
    
    func getProfilByEmail(email: String) async throws -> getDetailsInfosUser {
        let url = URL(string: "https://eip.vakary.fr/v1/user/email/\(email)")!
        
        var request = URLRequest(url: url)
        let token = UserDefaults.standard.string(forKey: "token")
        request.setValue(token, forHTTPHeaderField: "Authorization")
        request.httpMethod = "GET"
        
        let (data, _) = try await URLSession.shared.data(for: request)
        let decoder = JSONDecoder()
        
        do {
            let response = try decoder.decode(getInfoUserByEmail.self, from: data)
            
            print("Response Data: \(String(data: data, encoding: .utf8) ?? "")")
            
            return response.user
        } catch {
            // Gérer les erreurs de décodage JSON ici
            print("Erreur lors du décodage JSON : \(error)")
            return getDetailsInfosUser(
                id: "",
                username: "",
                number: "",
                firstname: "",
                lastname: "",
                description: "",
                likes: "",
                comments: "",
                milesTraveled: "",
                lastMonument: "",
                lastEvent: "",
                email: "",
                verified: "",
                createdAt: "",
                updatedAt: "",
                picture: ""
            )
        }
    }
}

struct Group: Decodable, Identifiable, Hashable {
    let id: String
    let name: String
    let emails: [String]
    var picture: String?
    let itinerary: CreatedItinerary?
    let chat: Chat?
    var status: [GroupStatus]?
    var getDetailsInfosUser : getDetailsInfosUser?

    static func ==(lhs: Group, rhs: Group) -> Bool {
        return lhs.id == rhs.id
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

struct ResponseAllMessage: Codable {
    let allMessages: [AllMessages]
}

struct AllMessages: Codable {
    let id: String
    let messageBody: String
    let user: MessageUserInfo
    let updatedAt: String
    let modified: Bool
}

struct MessageUserInfo: Codable {
    let username: String
    let id: String
    let picture: String?
}

struct UpdateGroupResponse: Codable {
    let message: String
}

struct responseGroupStatus: Decodable {
    let message: String
    let groupUser: [GroupStatus]?
}

struct GroupStatus: Decodable {
    let status: String
    let role: String
    let createdAt: String
    let updatedAt: String
    let groupId: String
    let User: Email?
}

struct Email: Decodable {
    let email: String
}

struct GroupUpdate: Codable {
    let groupname: String?
}

struct GroupUpdateItineraryId: Codable {
    let itineraryId: Int?
}

struct GroupUpdatePicture: Codable {
    let file: String?
}

struct getGroupResponse: Decodable {
    let groups: [Group]
}

struct getInfoUserByEmail: Decodable {
    let message: String
    let user: getDetailsInfosUser
}

struct getDetailsInfosUser: Decodable {
    let id: String
    let username: String
    let number: String
    let firstname: String
    let lastname: String
    let description: String
    let likes: String
    let comments: String
    let milesTraveled: String
    let lastMonument: String
    let lastEvent: String
    let email: String
    let verified: String
    let createdAt: String
    let updatedAt: String
    let picture: String
}
