//
 //  MapAPI.swift
 //  Vakary
 //
 //  Created by Marques on 15/05/2023.
 //

 import Foundation
 import Combine
 import SwiftUI

class DataStore: ObservableObject {
    @Published var itineraryArray: [InterestPoint] = []
    @Published var listItineraryArray: [InterestPoint] = []
    @Published var sharedItineraryArray: [InterestPoint] = []
    @Published var itineraryID: String = ""
    @Published var sharedItineraryID: String = ""
    @Published var idListitinerary: String = ""
}

class MapAPI: ObservableObject {
    var didChange = PassthroughSubject<MapAPI, Never>()
    @Published var dataStore: DataStore
    @State var storedItineraryId: Int = 0
    @State var idListitinerary: String = ""
    @Published var isLoading: Bool = false
    
    init(dataStore: DataStore) {
        self.dataStore = dataStore
    }
    
    func getWayPoint(itinerary: getItinerary) async throws -> ([InterestPoint], String)  {
         self.isLoading = true
         let url = URL(string: "https://eip.vakary.fr/v1/itinerary/me")!
         var request = URLRequest(url: url)
         
         request.setValue("application/json", forHTTPHeaderField: "Content-Type")
         request.setValue(UserDefaults.standard.string(forKey: "token"), forHTTPHeaderField: "Authorization")
         request.httpMethod = "PUT"
         
         request.httpBody = try JSONEncoder().encode(itinerary)
         
         let (data, _) = try await URLSession.shared.data(for: request)
         do {
             let decodedData = try JSONDecoder().decode(ItineraryData.self, from: data)
             let decodedDataArray = try JSONDecoder().decode([InterestPoint].self, from: Data(decodedData.createdItinerary.data.utf8))
             
             Task.detached {
                 DispatchQueue.main.async {
                     self.isLoading = false
                     self.dataStore.itineraryArray = decodedDataArray
                     self.dataStore.itineraryID = decodedData.createdItinerary.id
                 }
             }
             return (decodedDataArray, decodedData.createdItinerary.id);
            
         } catch {
             print("Erreur lors du décodage JSON : \(error)")
             
             return ([], "");
         }
    }
    
    func getTinderItinerary(id: String) async throws -> [InterestPoint]  {
         self.isLoading = true
         let url = URL(string: "https://eip.vakary.fr/v1/itinerary/\(id)")!
         var request = URLRequest(url: url)
         
         request.setValue("application/json", forHTTPHeaderField: "Content-Type")
         request.setValue(UserDefaults.standard.string(forKey: "token"), forHTTPHeaderField: "Authorization")
         request.httpMethod = "GET"
         
         let (data, _) = try await URLSession.shared.data(for: request)
         do {
             let decodedData = try JSONDecoder().decode(tinderIninerary.self, from: data)
             let decodedDataArray = try JSONDecoder().decode([InterestPoint].self, from: Data(decodedData.itinerary.data.utf8))
             DispatchQueue.main.async {
                 self.isLoading = false
                 self.dataStore.itineraryArray = decodedDataArray
             }
             return decodedDataArray;
            
         } catch {
             print("Erreur lors du décodage JSON : \(error)")
             
             return [];
         }
    }
    
    func removePOI(itineraireID: String, POIId: String) {
        guard let url = URL(string: "https://eip.vakary.fr/v1/itinerary/removePOI") else {
            return
        }

        let body: [String : String] = ["itineraryId": itineraireID, "POIId": POIId]

        guard let finalBody = try? JSONEncoder().encode(body) else {
            return
        }

        var request = URLRequest(url: url)

        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue(UserDefaults.standard.string(forKey: "token"), forHTTPHeaderField: "Authorization")
        request.httpMethod = "POST"
        request.httpBody = finalBody

        URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let response = response as? HTTPURLResponse else { return }

            DispatchQueue.main.async {
                if response.statusCode == 200 {
                } else {
                    print("failed to deleted the POI")
                }
            }
        }.resume()
    }
    
    func getSharedItinerary(itineraryId: String) async throws -> [InterestPoint] {
        let url = URL(string: "https://eip.vakary.fr/v1/itinerary/\(itineraryId)")!
        var request = URLRequest(url: url)
        
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue(UserDefaults.standard.string(forKey: "token"), forHTTPHeaderField: "Authorization")
        request.httpMethod = "GET"
        
        let (data, _) = try await URLSession.shared.data(for: request)
        do {
            let decodedData = try JSONDecoder().decode(responseItineraryGroup.self, from: data)
            let decodedDataArray = try JSONDecoder().decode([InterestPoint].self, from: Data(decodedData.itinerary.data.utf8))
            DispatchQueue.main.async {
                self.dataStore.sharedItineraryArray = decodedDataArray
                print("decodedData.itinerary.id ---->",decodedData.itinerary.id)
                self.dataStore.sharedItineraryID = decodedData.itinerary.id
            }
            print(decodedDataArray)
            return decodedDataArray
            
        } catch {
            print("Erreur lors du décodage JSON : \(error)")
            return []
        }
    }
    
    func createTravelProfil(options: getOptions) async throws {
        self.isLoading = true
         let url = URL(string: "https://eip.vakary.fr/v1/me/profil")!
         var request = URLRequest(url: url)
         
         request.setValue("application/json", forHTTPHeaderField: "Content-Type")
         request.setValue(UserDefaults.standard.string(forKey: "token"), forHTTPHeaderField: "Authorization")
         request.httpMethod = "POST"
         request.httpBody = try JSONEncoder().encode(options)
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let response = response as? HTTPURLResponse else { return }

            DispatchQueue.main.async {
                if response.statusCode == 200 {
                    self.isLoading = false
                } else {
                    print("failed")
                }
            }
        }.resume()
    }
    
    func getAllTravelProfil() async throws -> [ResponseProfilOption] {
        let url = URL(string: "https://eip.vakary.fr/v1/me/profil")!
        var request = URLRequest(url: url)
        
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue(UserDefaults.standard.string(forKey: "token"), forHTTPHeaderField: "Authorization")
        request.httpMethod = "GET"
        
        let (data, _) = try await URLSession.shared.data(for: request)
        
//        do {
//            let decodedData = try JSONDecoder().decode(ResponseModel.self, from: data)
//            let itineraryArray = decodedData.itinerary
//            var decodedDataArray: [InterestPoint] = []
//            
//            for listItinerary in itineraryArray {
//                idListitinerary = listItinerary.id
//                if let jsonData = listItinerary.data.data(using: .utf8) {
//                    let interestPoints = try JSONDecoder().decode([InterestPoint].self, from: jsonData)
//                    decodedDataArray.append(contentsOf: interestPoints)
//                }
//            }
//            let localDataArray = decodedDataArray
//            
//            self.dataStore.itineraryArray = localDataArray
//            return decodedDataArray
        do {
            let decodedData = try JSONDecoder().decode(ResponseProfilOptionContainer.self, from: data)
            return decodedData.profils
            
        } catch {
            print("Erreur lors du décodage JSON : \(error)")
            return []
        }
    }
    
    func getMyItinerary() async throws -> [listItinerary] {
        let url = URL(string: "https://eip.vakary.fr/v1/itinerary/getAll/me")!

        var request = URLRequest(url: url)
        let token = UserDefaults.standard.string(forKey: "token")
        print("token profil: " + (token ?? "token null"))
        request.setValue(token, forHTTPHeaderField: "Authorization")
        request.httpMethod = "GET"
//        print(token as Any)

        let (data, _) = try await URLSession.shared.data(for: request)

        let decoder = JSONDecoder()
        let response = try decoder.decode(ResponseModel.self, from: data)
        var itinerary = response.itinerary
        return itinerary
    }
    
    func decodeInterestPoints(from itineraryDetails: ItineraryDetails) -> [InterestPoint] {
        guard let jsonData = itineraryDetails.itinerary.data.data(using: .utf8) else {
            print("Error converting data to UTF-8")
            return []
        }

        do {
            let interestPoints = try JSONDecoder().decode([InterestPoint].self, from: jsonData)
            return interestPoints
        } catch {
            print("Error decoding JSON: \(error)")
            return []
        }
    }

    func getItineraryById(itineraryId: String) async throws -> [InterestPoint] {
        let url = URL(string: "https://eip.vakary.fr/v1/itinerary/\(itineraryId)")!
        var request = URLRequest(url: url)
        
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue(UserDefaults.standard.string(forKey: "token"), forHTTPHeaderField: "Authorization")
        request.httpMethod = "GET"
        
        do {
            let (data, _) = try await URLSession.shared.data(for: request)
            let decodedData = try JSONDecoder().decode(ItineraryDetails.self, from: data)
            return decodeInterestPoints(from: decodedData)
        } catch {
            print("Erreur lors de la récupération de l'itinéraire par ID : \(error)")
            return []
        }
    }

    
    func getMyAllItinerary() async throws -> [InterestPoint] {
        let url = URL(string: "https://eip.vakary.fr/v1/itinerary/getAll/me")!
        var request = URLRequest(url: url)
        
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue(UserDefaults.standard.string(forKey: "token"), forHTTPHeaderField: "Authorization")
        request.httpMethod = "GET"
        
        let (data, _) = try await URLSession.shared.data(for: request)
        
        do {
            let decodedData = try JSONDecoder().decode(ResponseModel.self, from: data)
            let itineraryArray = decodedData.itinerary
            var decodedDataArray: [InterestPoint] = []
            for listItinerary in itineraryArray {
//                self.dataStore.idListitinerary = listItinerary.id ?? ""
                //                    print(self.dataStore.idListitinerary)
                //                    print(listItinerary.id)
                if let jsonData = listItinerary.data.data(using: .utf8) {
                    let interestPoints = try JSONDecoder().decode([InterestPoint].self, from: jsonData)
                    decodedDataArray.append(contentsOf: interestPoints)
                }
            }
            let localDataArray = decodedDataArray
            
            self.dataStore.itineraryArray = localDataArray
            return decodedDataArray
        } catch {
            print("Erreur lors du décodage JSON : \(error)")
            return []
        }
    }
    
    func deleteMyItinerary(itineraryId: String) async throws {
        guard let url = URL(string: "https://eip.vakary.fr/v1/itinerary/\(itineraryId)") else {
            print("Error: cannot create URL")
            return
        }
        
        var request = URLRequest(url: url)
        let token = UserDefaults.standard.string(forKey: "token")
        request.setValue(token, forHTTPHeaderField: "Authorization")
        request.httpMethod = "DELETE"
        
        print("Envoi de la requête DELETE")
        URLSession.shared.dataTask(with: request) { data, response, error in
            print("Code de gestion des erreurs atteint")
            guard error == nil else {
                print("Error: error calling DELETE")
                print(error!)
                return
            }
            guard let httpResponse = response as? HTTPURLResponse else {
                    print("Error: No HTTP response")
                    return
                }
                print("HTTP Status Code: \(httpResponse.statusCode)")
            guard let data = data else {
                print("Error: Did not receive data")
                return
            }
            guard let response = response as? HTTPURLResponse, (200 ..< 299) ~= response.statusCode else {
                print("Error: HTTP request failed")
                return
            }
            print("HTTP Status Code: \(response.statusCode)")
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
}

struct getOptions: Codable {
    let profilFields: ProfileFields
    let typeOfPoi: [String]
}

struct ProfileFields: Codable {
    let name: String
    let adultCount: Int
    let childCount: Int
    let babyCount: Int
}

struct getItinerary: Decodable, Encodable {
    let userId: Int
    let nbPeople: Int
    let nbChild: Int
    let budget: Int
    let availableTime: Int
    let typeResearchLocations: [String]
    let handicapAccess: Bool
    let city: String
}

struct responseItineraryGroup: Codable {
    let message: String
    let itinerary: CreatedItinerary
}

struct tinderIninerary: Codable {
    let message: String
    let itinerary: CreatedItinerary
}

struct updateItinerary: Codable {
    let array: [InterestPoint]
    let itineraryId: Int
}

struct ResponseProfilOptionContainer: Codable {
    let profils: [ResponseProfilOption]
}

struct ResponseProfilOption: Codable {
    let id: String
    let name: String
    let description: String
    let adultCount: Int
    let childCount: Int
    let createdAt: String
    let updatedAt: String
    let InterestPointTypes: [InterestPointType]
}

struct InterestPointType: Codable {
    let name: String
}

struct ItineraryDetails: Decodable {
    let message: String
    let itinerary: Itinerary
    
    struct Itinerary: Decodable {
        let id: String
        let data: String
        let userId: String
        let createdAt: String
        let updatedAt: String
    }
}
