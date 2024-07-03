//
//  OpenMailView.swift
//  Vakary
//
//  Created by Marques on 12/08/2023.
//

import SwiftUI

struct OpenMailView: View {
    @State private var colorGray = Color.gray
    @State private var colorBlack = Color.black
    @State private var colorWhite = Color.white
    
    @State var mail: String
    
    var body: some View {
        GeometryReader { geometry in
            NavigationView {
                ZStack {
                    Color.white
                        .ignoresSafeArea()
                    VStack {
                        VStack {
                            HStack {
                                Button(action: {
                                }) {
                                    NavigationLink(
                                        destination: LostPasswordView().navigationBarHidden(true),
                                        label: {
                                            Image(systemName: "chevron.backward")
                                                .font(.system(size: geometry.size.height/26, weight: .bold))
                                                .foregroundColor(colorGray)
                                        }).navigationBarHidden(true)
                                }.padding()
                                Spacer()
                            }
                        }
                        VStack {
                            Spacer()
                            VStack {
                                Image("e-mail")
                                    .resizable()
                                    .frame(width: geometry.size.height/10, height:  geometry.size.height/10)
                            }
                            VStack {
                                HStack {
                                    Text(LocalizedStringKey("OpenMail1"))
                                        .font(.system(size: geometry.size.height/45, weight: .bold))
                                        .foregroundColor(Color("Color5"))
                                        .multilineTextAlignment(.center)
                                        .padding(.horizontal, 50)
                                        .padding(.bottom, 5)
                                }
                            }
                            VStack {
                                Text(LocalizedStringKey("OpenMail2"))
                                    .font(.system(size: geometry.size.height/45))
                                    .foregroundColor(Color("Color2"))
                                    .multilineTextAlignment(.center)
                                    .padding(.horizontal, 50)
                                    .padding(.bottom, 30)
                            }
                            VStack {
                                Button {
                                    let url = URL(string: "message://")
                                    if let url = url {
                                        if UIApplication.shared.canOpenURL(url) {
                                            UIApplication.shared.open(url, options: [:], completionHandler: nil)
                                        }
                                    }
                                } label: {
                                    Text(LocalizedStringKey("OpenMail3"))
                                        .font(.system(size: geometry.size.width/20, weight: .bold))
                                        .foregroundColor(Color("Color3"))
                                        .padding(.vertical, 22)
                                        .frame(width: geometry.size.height/4, height: geometry.size.width/5.5)
                                        .background(Color("Color5"))
                                        .cornerRadius(100)
//                                        .background(
//                                            .linearGradient(.init(colors: [
//                                                Color("Button1"),
//                                                Color("Button2"),
//                                            ]), startPoint: .leading, endPoint: .trailing), in: RoundedRectangle(cornerRadius: 20)
//                                        )
                                }
                            }
                            Spacer()
                        }
                    }
                }
            }
        }.edgesIgnoringSafeArea(.bottom)
    }
}

struct OpenMailView_Previews: PreviewProvider {
    static var previews: some View {
        let mail = "salut"
        OpenMailView(mail: mail)
    }
}
