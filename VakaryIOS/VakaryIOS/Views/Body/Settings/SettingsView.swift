//
//  SettingsView.swift
//  Vakary
//
//  Created by Marques on 12/08/2023.
//

import SwiftUI
import SwiftUIFontIcon

struct SettingsView: View {
    
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
    
    private var list: [ParentSettings] = []
    
    let dataStore: DataStore
    
    
    init(dataStore: DataStore) {
        self.dataStore = dataStore
        list = [
            ParentSettings(name: LocalizedStringKey("SettingsV1"), children: [
                ChildrenSettings(name: LocalizedStringKey("SettingsV2"),  dest : AnyView(GeneralSettingView()), icon: Icon(iconCode: .settings, iconColor: .gray), colorText: .black),
//                ChildrenSettings(name: LocalizedStringKey("SettingsV10"), dest:  AnyView(SoundsAndAlertsView()), icon: Icon(iconCode: .volume_up, iconColor: .gray), colorText: .black),
                    ChildrenSettings(name: LocalizedStringKey("SettingsV5"), dest:  AnyView(NavigationSettingView()), icon: Icon(iconCode: .navigation, iconColor: .blue), colorText: .black),
//                ChildrenSettings(name: LocalizedStringKey("SettingsV4"),  dest : AnyView(MapDisplayView()), icon: Icon(iconCode: .map, iconColor: .green), colorText: .black)
            ]),
            
            ParentSettings(name: LocalizedStringKey("SettingsV20"), children: [
                ChildrenSettings(name: LocalizedStringKey("SettingsV21"), dest:  AnyView(ConfidentialityView()), icon: Icon(iconCode: .navigation, iconColor: .blue), colorText: .black),
//                ChildrenSettings(name: LocalizedStringKey("SettingsV17"), dest:  AnyView(InfoPreviousItineraryView()
//                    .environmentObject(Profil()).environmentObject(MapAPI(dataStore: dataStore))), icon: Icon(iconCode: .map, iconColor: .green), colorText: .black),
                ChildrenSettings(name: LocalizedStringKey("SettingsV8"), dest:  AnyView(AccountAndLoginView()
                    .environmentObject(Profil())), icon: Icon(iconCode: .account_circle, iconColor: .blue), colorText: .black)
            ]),
            
//            ParentSettings(name: LocalizedStringKey("SettingsV6"), children: [
////                ChildrenSettings(name: LocalizedStringKey("SettingsV7"), dest:  AnyView(PrivacyView()), icon: Icon(iconCode: .security, iconColor: .yellow), colorText: .black),
//                ChildrenSettings(name: LocalizedStringKey("SettingsV8"), dest:  AnyView(AccountAndLoginView()
//                    .environmentObject(Profil())), icon: Icon(iconCode: .account_circle, iconColor: .blue), colorText: .black)
//            ]),
            
            ParentSettings(name: LocalizedStringKey("SettingsV9"), children: [
                ChildrenSettings(name: LocalizedStringKey("SettingsV9"), dest:  AnyView(NotificationView()), icon: Icon(iconCode: .notifications, iconColor: Color(red: 1.002, green: 0.545, blue: 0.138)), colorText: .black),
                ChildrenSettings(name: LocalizedStringKey("SettingsV10"), dest:  AnyView(SoundsAndAlertsView()), icon: Icon(iconCode: .volume_up, iconColor: .gray), colorText: .black)
            ]),
            
            ParentSettings(name: LocalizedStringKey("SettingsV11"), children: [
                ChildrenSettings(name: LocalizedStringKey("SettingsV12"), dest:  AnyView(HelpView()), icon: Icon(iconCode: .flag, iconColor: .red), colorText: .black),
                ChildrenSettings(name: LocalizedStringKey("SettingsV13"), dest:  AnyView(AboutView()), icon: Icon(iconCode: .help, iconColor: .green), colorText: .black),
                ChildrenSettings(name: LocalizedStringKey("SettingsV14"), dest:  AnyView(ContactAndSupportView()), icon: Icon(iconCode: .contacts, iconColor: .brown), colorText: .black),
                ChildrenSettings(name: LocalizedStringKey("SettingsV15"), icon: Icon(iconCode: .exit_to_app, iconColor: .red), colorText: .red)
            ])
        ]
    }
        
    
    @State private var singleSelection: UUID?
    @State private var showingAlertGroupName = false
    @State private var showingAlertLeaveGroup = false
    @State private var showingAlertGroupPicture = false
    @State private var showActionSheet = false
    @State private var showingSheet = false
    @State private var isLoggingOut = false
    @EnvironmentObject var signIn: SignIn
    @EnvironmentObject var appTheme: AppTheme
    
    var body: some View {
        NavigationView {
            List(selection: $singleSelection) {
                ForEach(list) { list in
                    Section(header: Text(list.name)) {
                        ForEach(list.children) { list in
                            HStack {
//                                FontIcon.text(.materialIcon(code: list.icon.iconCode), fontsize: 30, color: list.icon.iconColor)
                                if ((list.dest) != nil) {
                                    NavigationLink {
                                        list.dest
                                    } label: {
                                        Text(list.name)
                                            .foregroundColor(appTheme.colorScheme == .dark ? .white : .black)
                                    }
                                } else {
                                    Button(action: {
                                        isLoggingOut = true
                                        signIn.isLoggedin = false
//                                        signIn.logout()
                                    }) {
                                        Text(LocalizedStringKey("SettingsV16"))
                                            .foregroundColor(.red)
                                    }
                                }
                            }
                        }
                    }
                }
            }
            //                .navigationTitle("Settings")
            .navigationViewStyle(StackNavigationViewStyle())
            .navigationDestination(isPresented: $isLoggingOut) {
                SignInView()
                    .environmentObject(signIn)
                    .navigationBarHidden(true)
            }
            .onAppear {
                SoundManager.shared.playSound()
            }
        }
        Spacer()
            .frame(height: 130)
    }
}

//struct SettingsView_Previews: PreviewProvider {
//    static var previews: some View {
//        SettingsView(dataStore: DataStore)
//    }
//}
