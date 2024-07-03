//
//  AboutView.swift
//  Vakary
//
//  Created by Marques on 13/12/2022.
//

import SwiftUI

struct ParentAbout : Identifiable  {
    let name: LocalizedStringKey
    let id = UUID()
    let children : [ChildrenAbout]
}

struct ChildrenAbout : Identifiable {
    let name: LocalizedStringKey
    var dest : AnyView?
    let id = UUID()
}

private let list = [
    ParentAbout(name: "SettingsAbout1", children: [
        ChildrenAbout(name: "SettingsAbout2"),
        ChildrenAbout(name: "SettingsAbout3"),
        ChildrenAbout(name: "SettingsAbout4"),
        ChildrenAbout(name: "SettingsAbout5")
    ])
]

struct AboutView: View {
    
    @State private var singleSelection: UUID?
    @State private var showGreeting = true
    
    let text6: LocalizedStringKey = "SettingsAbout6"
    let text7: LocalizedStringKey = "SettingsAbout7"
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                VStack {
                    Divider()
                        .padding(.leading, 25)
                    VStack(alignment: .leading, spacing: 15) {
                        Text("Vakary")
                            .font(.system(size: 17))
                            .bold()
                        Text("\u{00A9}2022 Vakary")
                            .font(.system(size: 13))
                            .foregroundStyle(.gray)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading) // Aligner à gauche
                    .padding(.leading, 20)
                    Divider()
                        .padding(.leading, 25)
                    
                    VStack(alignment: .leading, spacing: 15) {
                        Text(LocalizedStringKey("aboutV1"))
                            .font(.system(size: 17))
                            .bold()
                        Text("Alpha 1.1.0")
                            .font(.system(size: 13))
                            .foregroundStyle(.gray)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading) // Aligner à gauche
                    .padding(.leading, 20)
                }
                .navigationBarTitle(LocalizedStringKey("aboutV2"))
            }
        }
    }

}

struct AboutView_Previews: PreviewProvider {
    static var previews: some View {
            AboutView()
        }
}

struct CardView: View {
    var title: String
    var imageName: String
    
    var body: some View {
        HStack {
            Image(systemName: imageName)
                .font(.largeTitle)
                .foregroundColor(.gray)
            
            Text(title)
                .font(.headline)
                .foregroundColor(.black)
        }
        .padding()
        .background(Color(.white))
        .cornerRadius(10)
        .shadow(radius: 10)
    }
}
