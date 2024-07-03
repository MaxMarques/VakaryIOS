//
//  ConfidentialityView.swift
//  VakaryIOS
//
//  Created by Thibaut  Humbert on 21/11/2023.
//

import SwiftUI

struct ConfidentialityView: View {
    @State private var activeSon = true
    @State private var activeAlertItinerary = true
    var body: some View {
        List {
            VStack {
                Toggle(isOn: $activeSon) {
                    VStack(alignment: .leading, spacing: 15) {
                        Text(LocalizedStringKey("confidentalityV1"))
                            .bold()
                        Text(LocalizedStringKey("confidentalityV2"))
                            .font(.system(size: 10))
                            .foregroundStyle(.gray)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading) // Aligner à gauche
                    .padding(.leading, 10)
                }
                if activeSon {
                }
                Divider()
                    .padding(.leading, 25)
                Toggle(isOn: $activeAlertItinerary) {
                    VStack(alignment: .leading, spacing: 15) {
                        Text(LocalizedStringKey("confidentalityV3"))
                            .bold()
                        Text(LocalizedStringKey("confidentalityV4"))
                            .font(.system(size: 10))
                            .foregroundStyle(.gray)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading) // Aligner à gauche
                    .padding(.leading, 10)
                }
                if activeAlertItinerary {
                }
            }
            .navigationBarTitle(LocalizedStringKey("confidentalityV5"))
        }
    }
}

#Preview {
    ConfidentialityView()
}
