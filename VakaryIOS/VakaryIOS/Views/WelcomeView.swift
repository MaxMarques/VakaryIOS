//
//  WelcomeView.swift
//  VakaryIOS
//
//  Created by Marques on 14/08/2023.
//

import SwiftUI

struct WelcomeView: View {
    @State private var isActive = false
    @State private var isActiveCircle = false
    @State private var size = 0.8
    @State private var opacity = 0.5
    @State private var colorBlue = Color(red: 0.112, green: 0.098, blue: 0.22)

    var body: some View {
        GeometryReader { geometry in
            if isActive {
                StartView()
            } else {
                ZStack {
                    Color.white
                        .ignoresSafeArea()
                    VStack {
                        Spacer()
                        VStack {
                            Image("LogoVakary")
                                .resizable()
                                .frame(width: geometry.size.width/2.5, height:  geometry.size.width/2.5)
                            Text("VAKARY")
                                .font(.system(size: geometry.size.height/14, weight: .light, design: .serif))
                                .foregroundColor(colorBlue)
                        }
                        .scaleEffect(size)
                        .opacity(opacity)
                        .onAppear {
                            withAnimation(.easeIn(duration: 1.2)) {
                                self.size = 0.9
                                self.opacity = 1.0
                            }
                        }
                        Spacer()
                        Spacer()
                    }
                    VStack {
                        Spacer()
                        Spacer()
                        Spacer()
                        Spacer()
                        Spacer()
                        if isActiveCircle {
                            LoaderComponent()
                        }
                        Spacer()
                    }
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                            self.isActiveCircle = true
                        }
                        DispatchQueue.main.asyncAfter(deadline: .now() + 5.0) {
                            withAnimation {
                                self.isActive = true
                            }
                        }
                    }
                }
            }
        }
    }
}

struct WelcomeView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeView()
    }
}
