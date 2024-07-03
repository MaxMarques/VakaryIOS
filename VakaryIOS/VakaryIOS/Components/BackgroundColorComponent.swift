//
//  BackgroundColorComponent.swift
//  Vakary
//
//  Created by Marques on 25/01/2023.
//

import SwiftUI

struct BackgroundColorComponent: View {
    var body: some View {
        ZStack {
            LinearGradient(colors: [Color("BG1"), Color("BG2")], startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea ()
            GeometryReader{proxy in
                let size = proxy.size
                Color.black
                    .opacity(0.7)
                    .blur(radius: 200)
                    .ignoresSafeArea()
                Circle()
                    .fill(Color("Purple"))
                    .padding(50)
                    .blur(radius: 120)
                    .offset(x: -size.width / 1.8, y: -size.height / 5)
                Circle()
                    .fill(Color("LightBlue"))
                    .padding(50)
                    .blur(radius: 100)
                    .offset(x: size.width / 1.8, y: -size.height / 2)
                Circle()
                    .fill(Color("Purple"))
                    .padding(100)
                    .blur(radius: 110)
                    .offset(x: size.width / 1.8, y: size.height / 2)
                Circle()
                    .fill(Color("Purple"))
                    .padding(100)
                    .blur(radius: 110)
                    .offset(x: -size.width / 1.8, y: size.height / 2)
            }
        }
    }
}

struct BackgroundColorComponent_Previews: PreviewProvider {
    static var previews: some View {
        BackgroundColorComponent()
    }
}
