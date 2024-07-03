//
//  DeleteAccountView.swift
//  Vakary
//
//  Created by Marques on 13/12/2022.
//

import SwiftUI

struct DeleteAccountView: View {
    
    @State var profilGroup = "noprofil"
    @State var userName: String = "BouleLymphe"
    @State private var mailAccount = "thibaut.humbert@epitech.eu"
    @ObservedObject var deleteProfil = Profil()
    @EnvironmentObject var profil: Profil
    @EnvironmentObject var signIn: SignIn
    @State var user: UserInfo? = nil
    @State private var showAlert = false
    
    var body: some View {
        ScrollView {
            VStack {
                HStack {
                    Image(profilGroup)
                        .resizable()
                        .frame(width: 30, height: 30)
                        .clipShape(Circle())
                        .shadow(radius: 10)
                    VStack {
                        Text(user?.username ?? "")
                            .font(.system(size: 18, weight: .bold))
                            .frame(maxWidth: .infinity, alignment: .leading)
                        Text(user?.email ?? "")
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                }
                .padding()
                Text(LocalizedStringKey("SettingsDeleteAccV1"))
                    .font(.system(size: 22, weight: .bold))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()
                Text(LocalizedStringKey("SettingsDeleteAccV2"))
                    .foregroundColor(.gray)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()
                Text(LocalizedStringKey("SettingsDeleteAccV3"))
                    .font(.system(size: 22, weight: .bold))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()
                //                Text("Vous pouvez restaurer votre compte VAKARY jusqu'à 30 jours après sa désactivation.")
                //                    .foregroundColor(.gray)
                //                    .frame(maxWidth: .infinity, alignment: .leading)
                //                    .padding()
                Text(LocalizedStringKey("SettingsDeleteAccV4"))
                    .foregroundColor(.gray)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()
                Button(action: {
                    showAlert = true
                }) {
                    Text(LocalizedStringKey("deletedAccountV1"))
                        .frame(width: 120, height: 40)
                        .background(Color.red)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .alert(isPresented: $showAlert) {
                    Alert(
                        title: Text(LocalizedStringKey("deletedAccountV2")),
                        message: Text(LocalizedStringKey("deletedAccountV3")),
                        primaryButton: .destructive(Text(LocalizedStringKey("deletedAccountV4"))) {
                            Task {
                                do {
                                    try await self.deleteProfil.deleteProfil()
                                    exit(0)
                                } catch {
                                    // Gérer les erreurs
                                }
                            }
                        },
                        secondaryButton: .cancel(Text(LocalizedStringKey("deletedAccountV5")))
                    )
                }
            }
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
}

struct DeleteAccountView_Previews: PreviewProvider {
    static var previews: some View {
        DeleteAccountView()
    }
}
