//
//  LostPasswordView.swift
//  Vakary
//
//  Created by Marques on 07/11/2022.
//

import SwiftUI

struct LostPasswordView: View {
    @State private var colorGray = Color.gray
    @State private var colorBlack = Color.black
    @State private var colorWhite = Color.white
    @ObservedObject var password = Profil()
    @State private var goodMail: Bool = false
    
    @State var mail: String = ""

    var body: some View {
        GeometryReader { geometry in
            NavigationStack {
                ZStack {
                    Color.white
                        .ignoresSafeArea()
                    VStack {
                        VStack {
                            HStack {
                                Button(action: {
                                }) {
                                    NavigationLink(
                                        destination: SignInView().environmentObject(SignIn()).navigationBarHidden(true),
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
                            Text(LocalizedStringKey("LostP1"))
                                .font(.system(size: geometry.size.height/22, weight: .bold))
                                .foregroundColor(Color("Color5"))
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(.horizontal, 50)
                                .padding(.bottom, 5)
                        }
                        VStack {
                            Text(LocalizedStringKey("LostP2"))
                                .font(.system(size: geometry.size.height/45))
                                .foregroundColor(Color("Color2"))
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(.horizontal, 50)
                                .padding(.bottom, 30)
                        }
                        ZStack(alignment: .leading) {
                            if mail.isEmpty {
                                Text(LocalizedStringKey("LostP3"))
                                    .foregroundColor(colorBlack.opacity(0.3))
                                    .padding(.horizontal)
                            }
                            VStack {
                                TextField("", text: $mail)
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
                        
                        if MailVerification(str: mail) {
                            VStack {
                                Spacer()
                                Button(action: {
                                    print("null ta mere")
                                    Task {
                                        do {
                                            print("ok le mail =", mail)
                                            try await self.password.forgotPassword(email: mail)
                                            goodMail = true
                                        } catch {
                                        }
                                    }
                                }) {
                                    Text(LocalizedStringKey("LostP4"))
                                        .font(.system(size: geometry.size.height/40, weight: .bold))
                                        .foregroundColor(Color("Color3"))
                                        .padding(.vertical, 22)
                                        .frame(width: geometry.size.height/2.5, height: 70)
                                        .background(Color("Color5"))
                                        .cornerRadius(100)
                                }.padding(.bottom, 15)
                                Spacer()
                                Spacer()
                                Spacer()
                            }.navigationDestination(isPresented: $goodMail) {
                                OpenMailView(mail: mail).navigationBarHidden(true)
                            }
                        } else {
                            VStack {
                                Spacer()
                                Button {
                                    print("non le mail =", mail)
                                } label: {
                                    Text(LocalizedStringKey("LostP4"))
                                        .font(.system(size: geometry.size.height/40, weight: .bold))
                                        .foregroundColor(Color("DarkGrey"))
                                        .padding(.vertical, 22)
                                        .frame(width: geometry.size.height/2.5, height: 70)
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
        }.edgesIgnoringSafeArea(.bottom)
    }
    func MailVerification(str: String) -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailPredicate.evaluate(with: str)
    }
}

struct LostPasswordView_Previews: PreviewProvider {
    static var previews: some View {
        LostPasswordView()
    }
}
