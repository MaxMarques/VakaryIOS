//
//  NewPasswordView.swift
//  Vakary
//
//  Created by Marques on 13/12/2022.
//

import SwiftUI

struct NewPasswordView: View {
    
    @State var actualPassword: String = ""
    @State var newPassword: String = ""
    @State var confirmPassword: String = ""
    @State private var mailAccount = "thibaut.humbert@epitech.eu"
    @ObservedObject var password = Profil()
    @EnvironmentObject var profil: Profil
    @State var user: UserInfo? = nil
    
    var body: some View {
        VStack {
            List {
                VStack {
                    Text(LocalizedStringKey("SettingsNewPassV1"))
                        .font(.system(size: 18, weight: .bold))
                        .frame(maxWidth: .infinity, alignment: .center)
                    Text(user?.email ?? "")
                    Spacer()
                    Text(LocalizedStringKey("SettingsNewPassV2"))
                        .foregroundColor(.gray)
                        .multilineTextAlignment(.center)
                    
                    Button(action: {
                        Task {
                            do {
                                try await self.password.forgotPassword(email: user?.email ?? "")
                            } catch {
                                
                            }
                        }
                    }) {
                        Text(LocalizedStringKey("SettingsNewPassV3"))
                            .padding(22)
                            .frame(width: 222, height: 44)
                            .background(Color.blue)
                            .foregroundColor(Color.white)
                    }
                    .background(Color.blue).cornerRadius(10)
                }
            }
        }
        .navigationTitle(LocalizedStringKey("SettingsNewPassV4"))
        .task {
            do {
                user = try await profil.getMyUser()
            }
            catch {
                print(error)
            }
        }
    }
}

struct NewPasswordView_Previews: PreviewProvider {
    static var previews: some View {
        NewPasswordView()
    }
}
