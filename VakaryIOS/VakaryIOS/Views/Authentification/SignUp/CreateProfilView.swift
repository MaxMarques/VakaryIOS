//
//  CreateProfilView.swift
//  Vakary
//
//  Created by Marques on 29/01/2023.
//

import SwiftUI

struct CreateProfilView: View {
    @StateObject var  routerModels = Router()
    @StateObject var map = MapModel()
    @EnvironmentObject var accountCreation: AccountCreation
    @EnvironmentObject var signUp: SignUp
    @State private var colorGray = Color.gray
    @State private var colorBlack = Color.black
    @State private var colorWhite = Color.white
    @State private var colorGold = Color(red: 0.927, green: 0.713, blue: 0.104)
    @State private var colorBleuRoy = Color(red: 0.112, green: 0.098, blue: 0.22)
    @State private var isShowingPhotoPickerAvatar = false
    @State private var isShowingPhotoPickerBaniere = false
    @State private var baniereImage = UIImage(named: "baniere")!
    @State private var avatarImage = UIImage(named: "avatar")!

    var body: some View {
        GeometryReader { geometry in
            NavigationStack {
                ZStack {
                    Color.white
                        .ignoresSafeArea()
                    VStack {
                        VStack {
                            HStack {
                                Button(action:
                                        accountCreation.password
                                       ,label: {
                                    Image(systemName: "chevron.backward")
                                        .font(.system(size: geometry.size.height/26, weight: .bold))
                                        .foregroundColor(colorGray)
                                }).padding()
                                Spacer()
                            }
                        }
                        VStack {
                            Text(LocalizedStringKey("SignUpV13"))
                                .font(.system(size: geometry.size.height/22, weight: .bold))
                                .foregroundColor(Color("Color5"))
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(.horizontal, 50)
                        }
                        VStack {
                            Text(LocalizedStringKey("SignUpV14"))
                                .font(.system(size: geometry.size.height/60))
                                .foregroundColor(Color("Color2"))
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(.top, 5)
                                .padding(.horizontal, 50)
                        }
                        VStack {
                            ZStack {
                                Image(uiImage: baniereImage)
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: geometry.size.height/5, height: geometry.size.height/5)
                                    .padding()
                                    .onTapGesture {
                                        isShowingPhotoPickerBaniere = true
                                    }
                                Image(uiImage: avatarImage)
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: geometry.size.height/8, height: geometry.size.height/8)
                                    .clipShape(Circle())
                                    .padding(.top, 100)
                                    .onTapGesture {
                                        isShowingPhotoPickerAvatar = true
                                    }
                            }.sheet(isPresented: $isShowingPhotoPickerAvatar, content: {
                                PhotoPicker(profilImages: $avatarImage)
                            })
                            .sheet(isPresented: $isShowingPhotoPickerBaniere, content: {
                                PhotoPicker(profilImages: $baniereImage)
                            })
                        }
                        VStack(alignment: .leading) {
                            Text(LocalizedStringKey("SignUpV15"))
                                .font(.system(size: geometry.size.height/60))
                                .foregroundColor(colorGray)
                            TextField("", text: $accountCreation.pseudo)
                                .foregroundColor(colorBlack)
                                .padding(.horizontal)
                                .frame(width: geometry.size.height/2.8)
                                .keyboardType(.default)
                                .disableAutocorrection(true)
                                .autocapitalization(.none)
                            Divider()
                                .frame(width: geometry.size.height/3.5)
                        }
                        VStack {
                            Text(LocalizedStringKey("SignUpV16"))
                                .font(.system(size: geometry.size.height/60))
                                .foregroundColor(Color("Color2"))
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(.top, 10)
                                .padding(.horizontal, 50)
                        }
                        if accountCreation.pseudo != "" {
                            VStack {
                                Spacer()
                                VStack {
                                    Button(action: {
                                        let randomData = random(count: 16)
                                        let token = randomData.base64EncodedString()
                                        UserDefaults.standard.set(token, forKey: "faceID")
                                        self.signUp.cekRegister(phone: accountCreation.phNumber, email: accountCreation.email, password: accountCreation.repeatPassWord, username: accountCreation.pseudo, faceIdConnection: token)
                                    }, label: {
                                        Text(LocalizedStringKey("SignUpV17"))
                                            .font(.title3.bold())
                                            .foregroundColor(colorWhite)
                                            .padding(.vertical, 22)
                                            .frame(width: geometry.size.width/1.5, height: 70)
                                            .background(Color("Color5"))
                                            .cornerRadius(100)
//                                            .background(
//                                                .linearGradient(.init(colors: [
//                                                    Color("Button1"),
//                                                    Color("Button2"),
//                                                ]), startPoint: .leading, endPoint: .trailing), in: RoundedRectangle(cornerRadius: 35)
//                                            )
                                    })
                                }
                                .navigationDestination(isPresented: $signUp.isCreate) {
                                    MainView(routerModels: routerModels)
                                        .environmentObject(map)
                                        .navigationBarHidden(true)
                                }
                                Spacer()
                                Spacer()
                                Spacer()
                            }
                        } else {
                            VStack {
                                Spacer()
                                Button {
                                } label: {
                                    Text(LocalizedStringKey("SignUpV17"))
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
                                }.padding(.top, 15)
                                    .disabled(true)
                                Spacer()
                                Spacer()
                                Spacer()
                                Spacer()
                            }
                        }
                    }
                    if signUp.isLoading {
                        LoaderComponent()
                    }
                }
            }
        }.edgesIgnoringSafeArea(.bottom)
            .overlay(overlayView: BannerComponent.init(data: BannerComponent.BannerDataModel(title: LocalizedStringKey("SignUpV18"), detail: LocalizedStringKey("SignUpV19"), type: .error), show: $signUp.isWrong), show: $signUp.isWrong)
    }
    func random(count: Int) -> Data {
        var data = Data(count: count)
        let result = data.withUnsafeMutableBytes { (mutableBytes: UnsafeMutableRawBufferPointer) in
            SecRandomCopyBytes(kSecRandomDefault, count, mutableBytes.baseAddress!)
        }
        if result == errSecSuccess {
            return data
        } else {
            fatalError("Impossible de générer des données aléatoires.")
        }
    }
}

struct CreateProfilView_Previews: PreviewProvider {
    static var previews: some View {
        CreateProfilView()
            .environmentObject(AccountCreation())
            .environmentObject(SignUp())
    }
}
