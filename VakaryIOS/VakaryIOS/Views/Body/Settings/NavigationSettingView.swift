//
//  NavigationSettingView.swift
//  Vakary
//
//  Created by Marques on 13/12/2022.
//

import SwiftUI
import SwiftUIFontIcon

struct NavigationSettingView: View {
    
    @State private var activeAlertItinerary = true
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                VStack {
                    Divider()
                    VStack(alignment: .leading, spacing: 15) {
                        Text(LocalizedStringKey("navigationSettingsV1"))
                            .font(.system(size: 20))
                            .bold()
                        Button {
                            // Action à exécuter lorsque le bouton est appuyé
                        } label: {
                            HStack {
                                Text(LocalizedStringKey("navigationSettingsV2"))
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
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.leading, 20)
                    Divider()
                    Toggle(isOn: $activeAlertItinerary) {
                        VStack(alignment: .leading, spacing: 17) {
                            Text(LocalizedStringKey("navigationSettingsV3"))
                                .font(.system(size: 20))
                                .bold()
                            Text(LocalizedStringKey("navigationSettingsV4"))
                                .font(.system(size: 10))
                                .foregroundStyle(.gray)
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.leading, 10)
                    }
                    .frame(maxWidth: .infinity, alignment: .trailing)
                    .padding(.trailing, 10)
                    if activeAlertItinerary {
                    }
                }
                .navigationTitle(LocalizedStringKey("SettingsNavV6"))
            }
        }
    }
}

struct NavigationSettingView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationSettingView()
    }
}
