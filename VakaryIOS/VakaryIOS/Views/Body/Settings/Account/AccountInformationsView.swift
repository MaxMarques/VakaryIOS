//
//  AccountInformationsView.swift
//  Vakary
//
//  Created by Marques on 13/12/2022.
//

import SwiftUI

struct AccountInformationsView: View {
    
    @State var userName: String = "BouleLymphe"
    @State var phoneNumber: String = "+33 6 62 36 36 26"
    @State var Country: String = "France"
    @State private var mailAccount = "thibaut.humbert@epitech.eu"
    @EnvironmentObject var profil: Profil
    @State var user: UserInfo? = nil
    
    var body: some View {
        List {
            VStack {
                Text(LocalizedStringKey("SettingsAccountInfV1"))
                    .font(.system(size: 18, weight: .bold))
                    .frame(maxWidth: .infinity, alignment: .center)
                Text(user?.email ?? "")
                Spacer()
                Text(LocalizedStringKey("SettingsAccountInfV2"))
                    .foregroundColor(.gray)
            }
            Spacer()
            HStack {
                Text(LocalizedStringKey("SettingsAccountInfV3"))
                Text(user?.username ?? "")
                    .frame(maxWidth: .infinity, alignment: .trailing)
                    .foregroundColor(.gray)
            }
            HStack {
                Text(LocalizedStringKey("SettingsAccountInfV4"))
                Text(user?.number ?? "-")
                    .frame(maxWidth: .infinity, alignment: .trailing)
                    .foregroundColor(.gray)
            }
            HStack {
                Text(LocalizedStringKey("SettingsAccountInfV5"))
                Text(user?.email ?? "")
                    .frame(maxWidth: .infinity, alignment: .trailing)
                    .foregroundColor(.gray)
            }
        }
        .navigationTitle(LocalizedStringKey("SettingsAccountInfV6"))
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

struct AccountInformationsView_Previews: PreviewProvider {
    static var previews: some View {
        AccountInformationsView()
    }
}
