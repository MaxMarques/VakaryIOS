//
//  ContactAndSupportView.swift
//  Vakary
//
//  Created by Marques on 13/12/2022.
//

import SwiftUI
import SwiftUIFontIcon

struct ContactAndSupportView: View {
    
    @State var groupName: String = ""
    @State var groupMembers: String = ""
    @State private var isShowPhotoLibrary = false
    @State private var image = UIImage()
    @State private var changeView: Bool = false
    @State private var showSheet = false
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                VStack {
                    Divider()
                        .padding(.leading, 25)
                    Text(LocalizedStringKey("contactSupportV1"))
                        .font(.system(size: 20))
                        .bold()
                        .multilineTextAlignment(.center)
                    Text("https://vakary.com/contact-support")
                        .foregroundStyle(.blue)
                        .multilineTextAlignment(.center)
                }
                .navigationBarTitle(LocalizedStringKey("SettingsC&S9"))
            }
        }
    }
}

struct ContactAndSupportView_Previews: PreviewProvider {
    static var previews: some View {
        ContactAndSupportView()
    }
}
