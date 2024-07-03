//
//  VerificationCodeView.swift
//  Vakary
//
//  Created by Marques on 27/01/2023.
//

import SwiftUI

struct VerificationCodeView: View {
    @EnvironmentObject var accountCreation: AccountCreation
    @State private var colorGray = Color.gray
    @State private var colorBlack = Color.black
    @State private var colorWhite = Color.white
    @FocusState private var isKeyboardShowing: Bool

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
                        Text("Mon code est")
                            .font(.system(size: geometry.size.height/22, weight: .bold))
                            .foregroundColor(colorBlack)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.horizontal, 50)
                            .padding(.bottom, 5)
                    }
                    VStack {
                        Text(accountCreation.email)
                            .font(.system(size: geometry.size.height/45))
                            .foregroundColor(colorGray)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.horizontal, 50)
                            .padding(.bottom, 30)
                    }
                    HStack(spacing: 0) {
                        ForEach(0..<6, id: \.self){ index in
                            OTPTextBox(index)
                        }
                    }
                    .background(content: {
                        TextField("", text: $accountCreation.OTPCode.limit(6))
                            .keyboardType(.numberPad)
                            .textContentType(.oneTimeCode)
                            .frame(width: 1, height: 1)
                            .opacity(0.001)
                            .blendMode(.screen)
                            .focused($isKeyboardShowing)
                    })
                    .contentShape(Rectangle())
                    .onTapGesture {
                        isKeyboardShowing.toggle()
                    }
                    .padding(.top, 40)
                    .padding(.horizontal, 30)
                    
                    if accountCreation.OTPCode.count == 6 {
                        VStack {
                            Spacer()
                            Button(action:
                                    accountCreation.password
                            ,label: {
                                Text("Continuer")
                                    .font(.title3.bold())
                                    .foregroundColor(colorWhite)
                                    .padding(.vertical, 22)
                                    .frame(width: geometry.size.width/1.5, height: 70)
                                    .background(
                                        .linearGradient(.init(colors: [
                                            Color("Button1"),
                                            Color("Button2"),
                                        ]), startPoint: .leading, endPoint: .trailing), in: RoundedRectangle(cornerRadius: 35)
                                    )
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
                                Text("Continuer")
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
    @ViewBuilder
    func OTPTextBox(_ index: Int)-> some View {
        ZStack {
            if accountCreation.OTPCode.count > index {
                let startIndex = accountCreation.OTPCode.startIndex
                let charIndex = accountCreation.OTPCode.index(startIndex, offsetBy: index)
                let charToString = String(accountCreation.OTPCode[charIndex])
                Text(charToString)
                    .foregroundColor(colorBlack)
            } else {
                Text("")
            }
        }
        .frame(width: 45, height: 45)
        .background {
            RoundedRectangle(cornerRadius: 6, style: .continuous)
                .stroke(.gray, lineWidth: 0.5)
        }.frame(maxWidth: .infinity)
    }
}

struct VerificationCodeView_Previews: PreviewProvider {
    static var previews: some View {
        VerificationCodeView()
            .environmentObject(AccountCreation())
    }
}

extension Binding where Value == String {
    func limit(_ length: Int)->Self {
        if self.wrappedValue.count > length {
            DispatchQueue.main.async {
                self.wrappedValue = String(self.wrappedValue.prefix(length))
            }
        }
        return self
    }
}
