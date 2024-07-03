//
//  PhoneNumberView.swift
//  Vakary
//
//  Created by Marques on 27/01/2023.
//

import SwiftUI

struct PhoneNumberView: View {
    @EnvironmentObject var accountCreation: AccountCreation
    @State private var colorGray = Color.gray
    @State private var colorBlack = Color.black
    @State private var colorWhite = Color.white

    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Color.white
                    .ignoresSafeArea()
                VStack {
                    VStack {
                        HStack {
                            Button(action:
                                    accountCreation.start
                            ,label: {
                                Image(systemName: "chevron.backward")
                                    .font(.system(size: geometry.size.height/26, weight: .bold))
                                    .foregroundColor(colorGray)
                            }).padding()
                            Spacer()
                        }
                    }
                    VStack {
                        Text(LocalizedStringKey("SignUpV1"))
                            .font(.system(size: geometry.size.height/22, weight: .bold))
                            .foregroundColor(Color("Color5"))
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.horizontal, 50)
                    }
                    HStack {
                        VStack {
                            TextField("", text: $accountCreation.countryCode)
                                .foregroundColor(Color("Color5"))
                                .padding(.horizontal)
                                .frame(width: geometry.size.height/10)
                                .keyboardType(.numberPad)
                                .disabled(true)
                            Divider()
                                .frame(width: geometry.size.height/13)
                        }
                        VStack {
                            TextField("", text: $accountCreation.phNumber)
                                .foregroundColor(colorBlack)
                                .padding(.horizontal)
                                .frame(width: geometry.size.height/3)
                                .keyboardType(.numberPad)
                            Divider()
                                .frame(width: geometry.size.height/3.3)
                        }
                    }.padding()
                    VStack {
                        Text(LocalizedStringKey("SignUpV2"))
                            .font(.system(size: geometry.size.height/60))
                            .foregroundColor(Color("Color2"))
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.top, 30)
                            .padding(.horizontal, 50)
                    }
                    if PHVerification(str: accountCreation.phNumber) {
                        VStack {
                            Spacer()
                            Button(action:
                                    accountCreation.mail
                            ,label: {
                                Text(LocalizedStringKey("SignUpV3"))
                                    .font(.title3.bold())
                                    .foregroundColor(Color("Color3"))
                                    .padding(.vertical, 22)
                                    .frame(width: geometry.size.width/1.5, height: 70)
                                    .background(Color("Color5"))
                                    .cornerRadius(100)
//                                    .background(
//                                        .linearGradient(.init(colors: [
//                                            Color("Button1"),
//                                            Color("Button2"),
//                                        ]), startPoint: .leading, endPoint: .trailing), in: RoundedRectangle(cornerRadius: 35)
//                                    )
                            }).padding(.bottom, 15)
                            Spacer()
                            Spacer()
                            Spacer()
                        }
                    } else {
                        VStack {
                            Spacer()
                            Button {
                            } label: {
                                Text(LocalizedStringKey("SignUpV3"))
                                    .font(.title3.bold())
                                    .foregroundColor(Color("DarkGrey"))
                                    .padding(.vertical, 22)
                                    .frame(width: geometry.size.width/1.5, height: 70)
                                    .background(
                                        .linearGradient(.init(colors: [
                                            Color("Grey"),
                                            Color("Grey"),
                                        ]), startPoint: .leading, endPoint: .trailing), in: RoundedRectangle(cornerRadius: 35)
                                    )
                            }.padding(.bottom, 15)
                                .disabled(true)
                            Spacer()
                            Spacer()
                            Spacer()
                        }
                    }
                }
            }
        }
        .edgesIgnoringSafeArea(.bottom)
    }
    
    func PHVerification(str: String) -> Bool {
        let phoneRegex = "^(6|7)[0-9]{8}$"
        let phonePredicate = NSPredicate(format: "SELF MATCHES %@", phoneRegex)
        return phonePredicate.evaluate(with: str)
    }
}

struct PhoneNumberView_Previews: PreviewProvider {
    static var previews: some View {
        PhoneNumberView()
            .environmentObject(AccountCreation())
    }
}
