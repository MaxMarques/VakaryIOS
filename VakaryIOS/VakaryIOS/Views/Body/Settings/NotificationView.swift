//
//  NotificationView.swift
//  Vakary
//
//  Created by Marques on 13/12/2022.
//

import SwiftUI

struct NotificationView: View {
    @State private var showGreeting = true

    var body: some View {
        GeometryReader { geometry in
            ZStack {
                VStack {
                    List {
                        VStack {
                            Toggle(LocalizedStringKey("notificationSettingsV1"), isOn: $showGreeting)
                            if showGreeting {
                            }
                            Toggle(LocalizedStringKey("notificationSettingsV2"), isOn: $showGreeting)
                            if showGreeting {
                            }
                            Toggle(LocalizedStringKey("notificationSettingsV3"), isOn: $showGreeting)
                            if showGreeting {
                            }
                        }
                    }
                    .navigationBarTitle(LocalizedStringKey("SettingsNotif4"))
                }
            }
        }
    }
}

struct NotificationView_Previews: PreviewProvider {
    static var previews: some View {
        NotificationView()
    }
}
