//
//  GeneralSettingView.swift
//  Vakary
//
//  Created by Marques on 13/12/2022.
//

import SwiftUI
import SwiftUIFontIcon

struct GeneralSettingView: View {
//    @StateObject private var languageManager = LanguageManager()
    @State private var darkMode = true
    @EnvironmentObject var appTheme: AppTheme
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                VStack {
                    Divider()
                    
                    //                Picker("Langue", selection: $languageManager.selectedLanguage) {
                    //                    Text("Français").tag("fr")
                    //                    Text("English").tag("en")
                    //                    Text("Espagnol").tag("es")
                    //                    Text("Italian").tag("it")
                    //                    Text("German").tag("de")
                    //                }
                    //                .pickerStyle(.wheel)
                    
                    VStack {
                        Button(action: {
                            toggleAppTheme()
                        }) {
                            Text(appTheme.colorScheme == .dark ? LocalizedStringKey("SettingsDisplayV1") : LocalizedStringKey("SettingsDisplayV2"))
                                .font(.headline)
                                .padding()
                                .background(Color.blue)
                                .foregroundColor(.white)
                                .cornerRadius(10)
                        }
                    }
                    
                    Divider()
                    
                    VStack(alignment: .leading, spacing: 15) {
                        Text(LocalizedStringKey("generalSettingsV10"))
                            .font(.system(size: 20))
                            .bold()
                        Button {
                            //do
                        } label: {
                            HStack {
                                Text(LocalizedStringKey("generalSettingsV10"))
                                    .foregroundColor(Color.white)
                                    .frame(maxWidth: .infinity)
                                    .padding(.leading, 20)
                                Spacer()
                                FontIcon.text(.materialIcon(code: .delete), fontsize: 20, color: .white)
                            }
                            .padding()
                            .background(Color.red)
                            .cornerRadius(10)
                        }
                        .frame(maxWidth: .infinity, alignment: .trailing)
                        .padding(.trailing, 10)
                    }
                }
                .navigationTitle(LocalizedStringKey("SettingsV2"))
                //            .environmentObject(languageManager)
                //            .environment(\.locale, .init(identifier: languageManager.selectedLanguage))
            }
        }
    }
    
    func toggleAppTheme() {
        appTheme.colorScheme = appTheme.colorScheme == .light ? .dark : .light
    }
}


struct GeneralSettingView_Previews: PreviewProvider {
    static var previews: some View {
        GeneralSettingView()
    }
}
