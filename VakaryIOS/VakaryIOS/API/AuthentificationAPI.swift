//
//  AuthentificationManager.swift
//  Vakary
//
//  Created by Marques on 11/02/2023.
//
import Foundation
import Combine
import SwiftUI

class SignIn: ObservableObject {
    var didChange = PassthroughSubject<SignIn, Never>()
    @Published var isLoggedin: Bool = false
    @Published var isWrong: Bool = false
    @Published var isLoading: Bool = false

    init() {
        checkIfUserIsLoggedIn()
    }

    func checkIfUserIsLoggedIn() {
        if let token = UserDefaults.standard.string(forKey: "token"), !token.isEmpty {
            self.isLoggedin = true
        }
    }
    
    func checkAndAutoLogin() {
        if let token = UserDefaults.standard.string(forKey: "token"), !token.isEmpty {
            // L'utilisateur est déjà connecté
            self.isLoggedin = true
        }
    }
    
    func logout() {
        self.isLoggedin = false
        UserDefaults.standard.removeObject(forKey: "token")
        
        // Réinitialiser d'autres états liés à l'authentification si nécessaire
        self.isWrong = false
        self.isLoading = false
        
        // Réinitialiser la session (à adapter en fonction de votre implémentation exacte)
        URLSession.shared.reset {
            // Optionnel : Effectuer d'autres actions après la réinitialisation de la session
        }
    }

    func cekLogin(password: String, email: String, faceIdConnection: String) {
        self.isLoading = true
        guard let url = URL(string: "https://eip.vakary.fr/v1/login") else {
            return
        }

        let body: [String : String] = ["username": email, "password": password, "faceIdConnection": faceIdConnection]

        guard let finalBody = try? JSONEncoder().encode(body) else {
            return
        }

        var request = URLRequest(url: url)

        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        request.httpBody = finalBody

        URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let data = data, error == nil else { return }

            let decodedResponse = try? JSONDecoder().decode(SignInManager.self, from: data)

            guard let response = response as? HTTPURLResponse else { return }

            DispatchQueue.main.async {
                if response.statusCode == 200 {
                    self.isLoading = false
                    self.isLoggedin = true
                    UserDefaults.standard.set(decodedResponse?.user.token ?? "", forKey: "token")
                    print(decodedResponse?.user.token ?? "pas de token")
                } else {
                    self.isLoading = false
                    self.isWrong = true
                }
            }
        }.resume()
    }
    
    func cekLoginGoogle(completion: @escaping (URL?) -> Void) {
        guard let url = URL(string: "https://eip.vakary.fr/v1/auth/google") else {
            print("URL invalide")
            completion(nil)
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let session = URLSession.shared
        let task = session.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Erreur de requête : \(error.localizedDescription)")
                completion(nil)
                return
            }
            guard let httpResponse = response as? HTTPURLResponse else {
                print("Réponse invalide")
                completion(nil)
                return
            }
            
            guard (200...299).contains(httpResponse.statusCode) else {
                print("Code de statut HTTP invalide : \(httpResponse.statusCode)")
                completion(nil)
                return
            }
            
            DispatchQueue.main.async {
                if let googleURL = httpResponse.url {
                    completion(googleURL)
                } else {
                    print("La réponse n'est pas une HTTPURLResponse")
                    completion(nil)
                }
            }
        }
        task.resume()
    }
}


class SignUp: ObservableObject {
    var didChange = PassthroughSubject<SignUp, Never>()
    @Published var isCreate: Bool = false
    @Published var isWrong: Bool = false
    @Published var isLoading: Bool = false
    
    func cekRegister(phone: String, email: String, password: String, username: String, faceIdConnection: String) {
        self.isLoading = true
        guard let url = URL(string: "https://eip.vakary.fr/v1/register") else {
            return
        }
        
        let body: [String : String] = ["email": email, "password": password, "username": username, "faceIdConnection": faceIdConnection]
        
        guard let finalBody = try? JSONEncoder().encode(body) else {
            return
        }
        
        var request = URLRequest(url: url)
        
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "PUT"
        request.httpBody = finalBody
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let data = data, error == nil else {return}
            
            let decodedResponse = try? JSONDecoder().decode(SignUpManager.self, from: data)
            
            guard let response = response as? HTTPURLResponse else { return }

            DispatchQueue.main.async {
                if response.statusCode == 200 {
                    self.isLoading = false
                    self.isCreate = true
                    UserDefaults.standard.set(decodedResponse?.user.token ?? "", forKey: "token")
                } else {
                    self.isLoading = false
                    self.isWrong = true
                }
            }
        }.resume()
    }
}
