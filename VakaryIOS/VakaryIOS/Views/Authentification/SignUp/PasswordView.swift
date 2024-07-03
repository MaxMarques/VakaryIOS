//
//  PasswordView.swift
//  Vakary
//
//  Created by Marques on 29/01/2023.
//

import SwiftUI

struct PasswordView: View {
    @EnvironmentObject var accountCreation: AccountCreation
    @State private var colorGray = Color.gray
    @State private var colorBlack = Color.black
    @State private var colorWhite = Color.white
    @State private var showTextPassword = false
    @State private var showTextRepeatPassword = false

    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Color.white
                    .ignoresSafeArea()
                VStack {
                    VStack {
                        HStack {
                            Button(action:
                                accountCreation.mail
                            ,label: {
                                Image(systemName: "chevron.backward")
                                    .font(.system(size: geometry.size.height/26, weight: .bold))
                                    .foregroundColor(colorGray)
                            }).padding()
                            Spacer()
                        }
                    }
                    VStack {
                        Text(LocalizedStringKey("SignUpV8"))
                            .font(.system(size: geometry.size.height/22, weight: .bold))
                            .foregroundColor(Color("Color5"))
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.horizontal, 50)
                            .padding(.bottom, 20)
                    }
                    VStack {
                        Text(LocalizedStringKey("SignUpV9"))
                            .font(.system(size: geometry.size.height/45))
                            .foregroundColor(Color("Color2"))
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.horizontal, 50)
                            .padding(.bottom, 30)
                    }
                    VStack(alignment: .leading) {
                        Text(LocalizedStringKey("SignUpV10"))
                            .font(.system(size: geometry.size.height/60))
                            .foregroundColor(colorGray)
                        HStack {
                            if showTextPassword {
                                TextField("", text: $accountCreation.passWord)
                                    .foregroundColor(colorBlack)
                                    .padding(.horizontal)
                                    .frame(width: geometry.size.height/2.8)
                                    .keyboardType(.default)
                                    .disableAutocorrection(true)
                                    .autocapitalization(.none)
                            } else {
                                SecureField("", text: $accountCreation.passWord)
                                    .foregroundColor(colorBlack)
                                    .padding(.horizontal)
                                    .frame(width: geometry.size.height/2.8)
                                    .keyboardType(.default)
                                    .disableAutocorrection(true)
                                    .autocapitalization(.none)
                            }
                            Button(action: {
                                showTextPassword.toggle()
                            }, label: {
                                Image(systemName: showTextPassword ? "eye.slash.fill" : "eye.fill")
                                    .foregroundColor(colorBlack)
                            })
                        }
                        Divider()
                            .frame(width: geometry.size.height/2.4)
                    }.padding(.top, 30)
                    VStack(alignment: .leading) {
                        Text(LocalizedStringKey("SignUpV11"))
                            .font(.system(size: geometry.size.height/60))
                            .foregroundColor(colorGray)
                        HStack {
                            if showTextRepeatPassword {
                                TextField("", text: $accountCreation.repeatPassWord)
                                    .foregroundColor(colorBlack)
                                    .padding(.horizontal)
                                    .frame(width: geometry.size.height/2.8)
                                    .keyboardType(.default)
                                    .disableAutocorrection(true)
                                    .autocapitalization(.none)
                            } else {
                                SecureField("", text: $accountCreation.repeatPassWord)
                                    .foregroundColor(colorBlack)
                                    .padding(.horizontal)
                                    .frame(width: geometry.size.height/2.8)
                                    .keyboardType(.default)
                                    .disableAutocorrection(true)
                                    .autocapitalization(.none)
                            }
                            Button(action: {
                                showTextRepeatPassword.toggle()
                            }, label: {
                                Image(systemName: showTextRepeatPassword ? "eye.slash.fill" : "eye.fill")
                                    .foregroundColor(colorBlack)
                            })
                        }
                        Divider()
                            .frame(width: geometry.size.height/2.4)
                    }.padding(.top, 30)
                    if PasswordVerification(str: accountCreation.passWord) && accountCreation.repeatPassWord == accountCreation.passWord {
                        VStack {
                            Spacer()
                            Button(action:
                                    accountCreation.profil
                            ,label: {
                                Text(LocalizedStringKey("SignUpV12"))
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
                                Text(LocalizedStringKey("SignUpV12"))
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
    func PasswordVerification(str: String) -> Bool {
        let passwordRegex = "(?=.*[A-Z])(?=.*[a-z])(?=.*\\d)(?=.*[@$!%*?&#])[A-Za-z\\d@$!%*?&#]{8,}"
        let passwordPredicate = NSPredicate(format: "SELF MATCHES %@", passwordRegex)
        return passwordPredicate.evaluate(with: str)
    }
}

struct PasswordView_Previews: PreviewProvider {
    static var previews: some View {
        PasswordView()
            .environmentObject(AccountCreation())
    }
}
