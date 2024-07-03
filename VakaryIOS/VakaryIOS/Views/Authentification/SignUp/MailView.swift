//
//  MailView.swift
//  Vakary
//
//  Created by Marques on 27/01/2023.
//

import SwiftUI

struct MailView: View {
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
                                accountCreation.phoneNb
                            ,label: {
                                Image(systemName: "chevron.backward")
                                    .font(.system(size: geometry.size.height/26, weight: .bold))
                                    .foregroundColor(colorGray)
                            }).padding()
                            Spacer()
                        }
                    }
                    VStack {
                        Text(LocalizedStringKey("SignUpV4"))
                            .font(.system(size: geometry.size.height/22, weight: .bold))
                            .foregroundColor(Color("Color5"))
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.horizontal, 50)
                            .padding(.bottom, 5)
                    }
                    VStack {
                        Text(LocalizedStringKey("SignUpV5"))
                            .font(.system(size: geometry.size.height/45))
                            .foregroundColor(Color("Color2"))
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.horizontal, 50)
                            .padding(.bottom, 30)
                    }
                    ZStack(alignment: .leading) {
                        if accountCreation.email.isEmpty {
                            Text(LocalizedStringKey("SignUpV6"))
                                .foregroundColor(colorBlack.opacity(0.3))
                                .padding(.horizontal)
                        }
                        VStack {
                            TextField("", text: $accountCreation.email)
                                .foregroundColor(colorBlack)
                                .padding(.horizontal)
                                .frame(width: geometry.size.height/2.5)
                                .keyboardType(.emailAddress)
                                .disableAutocorrection(true)
                                .autocapitalization(.none)
                            Divider()
                                .frame(width: geometry.size.height/2.8)
                        }
                    }
                    if MailVerification(str: accountCreation.email) {
                        VStack {
                            Spacer()
                            Button(action:
                                    accountCreation.password
                            ,label: {
                                Text(LocalizedStringKey("SignUpV7"))
                                    .font(.title3.bold())
                                    .foregroundColor(colorWhite)
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
                                Text(LocalizedStringKey("SignUpV7"))
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
    func MailVerification(str: String) -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailPredicate.evaluate(with: str)
    }
}

struct MailView_Previews: PreviewProvider {
    static var previews: some View {
        MailView()
            .environmentObject(AccountCreation())
    }
}
