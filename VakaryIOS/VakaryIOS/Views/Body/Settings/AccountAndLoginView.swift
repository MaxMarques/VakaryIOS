//
//  AccountAndLoginView.swift
//  Vakary
//
//  Created by Marques on 13/12/2022.
//

import SwiftUI
import SwiftUIFontIcon

struct ParentSettings : Identifiable  {
    let name: LocalizedStringKey
    let id = UUID()
    let children : [ChildrenSettings]
}

struct ChildrenSettings : Identifiable {
    let name: LocalizedStringKey
    var dest : AnyView?
    let icon : Icon
    let colorText : Color
    let id = UUID()
}

struct Icon {
    let iconCode : MaterialIconCode
    let iconColor : Color
}

private let list = [
    ParentSettings(name: LocalizedStringKey("SettingsA&LV1"), children: [
        ChildrenSettings(name: LocalizedStringKey("SettingsA&LV2"),  dest : AnyView(AccountInformationsView().environmentObject(Profil())), icon: Icon(iconCode: .account_circle, iconColor: .blue), colorText: .black),
        ChildrenSettings(name: LocalizedStringKey("SettingsA&LV3"),  dest : AnyView(NewPasswordView().environmentObject(Profil())), icon: Icon(iconCode: .vpn_key, iconColor: .gray), colorText: .black),
        ChildrenSettings(name: LocalizedStringKey("SettingsA&LV4"),  dest : AnyView(DeleteAccountView().environmentObject(Profil())), icon: Icon(iconCode: .lock, iconColor: .red), colorText: .black)
    ])
]

struct AccountAndLoginView: View {
    @State private var mailAccount = "thibaut.humbert@epitech.eu"
    @State private var singleSelection: UUID?
    @EnvironmentObject var profil: Profil
    @State var user: UserInfo? = nil
    @EnvironmentObject var appTheme: AppTheme

    var body: some View {
        VStack {
            List(selection: $singleSelection) {
                VStack {
                    Text(LocalizedStringKey("SettingsA&LV5"))
                        .font(.system(size: 18, weight: .bold))
                        .frame(maxWidth: .infinity, alignment: .center)
                    Text(user?.email ?? "")
                    Spacer()
                    Text(LocalizedStringKey("SettingsA&LV6"))
                        .foregroundColor(.gray)
                }
                ForEach(list) { list in
                    Section(header: Text(list.name)) {
                        ForEach(list.children) { list in
                            HStack {
                                FontIcon.text(.materialIcon(code: list.icon.iconCode), fontsize: 30, color: list.icon.iconColor)
                                NavigationLink {
                                    list.dest
                                } label: {
                                    Text(list.name)
                                        .foregroundColor(appTheme.colorScheme == .dark ? .white : .black)
                                }
                            }
                        }
                    }
                }
            }
        }
        .navigationTitle(LocalizedStringKey("SettingsA&LV7"))
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

struct AccountAndLoginView_Previews: PreviewProvider {
    static var previews: some View {
        AccountAndLoginView()
    }
}
