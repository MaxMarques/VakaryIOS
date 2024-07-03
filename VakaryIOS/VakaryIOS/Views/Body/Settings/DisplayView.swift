//
//  DisplayView.swift
//  Vakary
//
//  Created by Marques on 13/12/2022.
//

import SwiftUI

struct DisplayView: View {
    @EnvironmentObject var appTheme: AppTheme
        
        var body: some View {
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
            .padding()
        }
        
        func toggleAppTheme() {
            appTheme.colorScheme = appTheme.colorScheme == .dark ? .light : .dark
        }
}

struct DisplayView_Previews: PreviewProvider {
    static var previews: some View {
        DisplayView()
    }
}
