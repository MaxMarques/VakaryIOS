//
//  ContentView.swift
//  Vakary
//
//  Created by Marques on 26/07/2022.
//

import SwiftUI

struct StartView: View {
    init() {
        UINavigationBar.setAnimationsEnabled(false)
    }

    @State private var pageIndex = 0
    private let elements: [Walkthrough] = Walkthrough.samplePages
    @State private var colorWhite = Color.white
    private let dotAppearance = UIPageControl.appearance()
    
    var body: some View {
        GeometryReader { geometry in
            NavigationStack {
                ZStack {
                    Color("Color1")
                        .ignoresSafeArea()
                    VStack {
                        Image("LogoVakary")
                            .resizable()
                            .frame(width: geometry.size.width/2.5, height:  geometry.size.width/2.5)
                            .padding(.top, 20)
                        Text("VAKARY")
                            .font(.system(size: geometry.size.height/14, weight: .light, design: .serif))
                            .foregroundColor(Color("Color4"))
                        Spacer()
                    }
                    VStack {
                        Spacer()
                        Spacer()
                        Spacer()
                        Spacer()
                        TabView(selection: $pageIndex) {
                            ForEach(elements) { walkthrough in
                                VStack {
                                    Image("\(walkthrough.imageUrl)")
                                        .resizable()
                                        .scaledToFit()
                                        .padding()
                                        .cornerRadius(30)
                                        .background(.gray.opacity(0.10))
                                        .cornerRadius(10)
                                        .padding()
                                        .frame(width: geometry.size.width/1.2, height:  geometry.size.width/2)
                                    Text(walkthrough.name)
                                        .font(.system(size: geometry.size.height/30, weight: .light, design: .serif))
                                        .bold()
                                        .foregroundColor(Color("Color4"))
                                    Text(walkthrough.description)
                                        .font(.system(size: geometry.size.height/60, weight: .light, design: .serif))
                                        .foregroundColor(Color("Color4"))
                                        .padding(.horizontal, 20)
                                }.tag(walkthrough.tag)
                            }
                        }.frame(height:  geometry.size.height/2)
                            .animation(.easeInOut, value: pageIndex)
                            .tabViewStyle(.page)
                        Spacer()
                        Spacer()
                        Spacer()
                    }
                    VStack {
                        Spacer(minLength: 10)
                        Button(action: {
                            }) {
                                NavigationLink(
                                    destination: SignUpView().navigationBarHidden(true),
                                    label: {
                                        Text(LocalizedStringKey("startV1"))
                                            .font(.system(size: geometry.size.width/20, weight: .bold))
                                            .foregroundColor(Color("Color3"))
                                            .padding(.vertical, 22)
                                            .frame(width: geometry.size.height/2.8, height: geometry.size.width/5.5)
                                            .background(Color("Color5"))
                                            .cornerRadius(100)
//                                            .background(
//                                                .linearGradient(.init(colors: [
//                                                    Color("Button1"),
//                                                    Color("Button2"),
//                                                ]), startPoint: .leading, endPoint: .trailing), in: RoundedRectangle(cornerRadius: 20)
//                                            )
                                    }).navigationBarHidden(true)
                            }
                            .padding(.bottom, 15)
                        Button(action: {
                        }) {
                            NavigationLink(
                                destination: SignInView().navigationBarHidden(true)
                                    .environmentObject(SignIn()),
                                label: {
                                    Text(LocalizedStringKey("startV2"))
                                        .font(.system(size: geometry.size.width/25))
                                        .fontWeight(.semibold)
                                        .foregroundColor(Color("Color4"))
                                        .padding(.bottom)
                                }).navigationBarHidden(true)
                        }.padding(.bottom)
                    }
                }
            }
        }
    }

    func incrementWalkthrough() {
        pageIndex += 1
    }

    func goToZero() {
        pageIndex = 0
    }
}

struct StartView_Previews: PreviewProvider {
    static var previews: some View {
        StartView()
    }
}
