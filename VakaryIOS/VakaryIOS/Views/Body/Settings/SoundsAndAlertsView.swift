//
//  SoundsAndAlertsView.swift
//  Vakary
//
//  Created by Marques on 13/12/2022.
//

import SwiftUI

struct SoundsAndAlertsView: View {
    
    @StateObject private var settingManager = SettingsManager()
    @State private var isEditingItinerary = false
    @State private var speedMessage = 50.0
    @State private var isEditingMessage = false
    @State private var speedNotification = 50.0
    @State private var isEditingNotification = false
    @State private var activeSon = true
    @State private var activeAlertItinerary = true
    @StateObject private var soundManager = SoundManager()
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                VStack {
                    Form {
                        Section(header: Text(LocalizedStringKey("soundAndAlertV1"))) {
                            Slider(
                                value: $settingManager.speedItinerary,
                                in: 0...100,
                                onEditingChanged: { editing in
                                    if !editing {
                                        SoundManager.shared.volume = Float(settingManager.speedItinerary / 100)
                                    }
                                }
                            )
                            Text("\(settingManager.speedItinerary, specifier: "%.0f")")
                                .foregroundColor(.blue)
                                .frame(maxWidth: .infinity, alignment: .center)
                        }
                        List {
                            VStack {
                                Toggle(isOn: $activeSon) {
                                    Text(LocalizedStringKey("soundAndAlertV2"))
                                        .bold()
                                }
                                if activeSon {
                                }

                                Toggle(isOn: $activeAlertItinerary) {
                                    Text(LocalizedStringKey("soundAndAlertV3"))
                                        .bold()
                                }
                                if activeAlertItinerary {
                                }
                            }
                        }
                    }
                    .navigationBarTitle(LocalizedStringKey("SettingsS&A4"))
                    .onAppear() {
                        SoundManager.shared.volume = Float(settingManager.speedItinerary / 100)
                    }
                }
            }
        }
    }
}

struct SoundsAndAlertsView_Previews: PreviewProvider {
    static var previews: some View {
        SoundsAndAlertsView()
    }
}
