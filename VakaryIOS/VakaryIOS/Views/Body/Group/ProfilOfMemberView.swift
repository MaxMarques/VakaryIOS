//
//  ProfilOfMemberView.swift
//  VakaryIOS
//
//  Created by Thibaut  Humbert on 07/12/2023.
//

import SwiftUI

struct ProfilOfMemberView: View {
    
    @State var user: UserInfo? = nil
    @State var groupAPI = GroupAPI()
    var selectedMemberEmail: String?
    @State private var banierePicture = UIImage(named: "Cultural")!
    @EnvironmentObject var appTheme: AppTheme
    
    var body: some View {
        GeometryReader { geometry in
            ScrollView() {
                VStack(alignment: .leading) {
                    ZStack {
                        Image(uiImage: banierePicture)
                            .resizable()
                            .frame(maxWidth: .infinity, maxHeight: 150)
                        AsyncImage(url: URL(string: user?.picture ?? "https://cpworldgroup.com/wp-content/uploads/2021/01/placeholder.png")) {
                            image in image.resizable()
                        } placeholder: {
                            ProgressView()
                        }
                        .frame(width: 95, height: 95)
                        .clipShape(Circle())
                        .padding(.leading, 10)
                        .offset(x: -160, y: 75)
                    }
                    HStack {
                        VStack(alignment: .center) {
                            Text(user?.username ?? "")
                                .font(.headline)
                            Text(user?.description ?? "")
                                .font(.subheadline)
                                .foregroundColor(appTheme.colorScheme == .dark ? .white : .black)
                        }
                        .padding(.leading)
                    }
                    .frame(maxWidth: .infinity, alignment: .center)
                    
                    Divider()
                    
                    HStack {
                        Spacer()
                        
                        VStack {
                            Text(String(user?.comments ?? 0))
                                .font(.system(size: 25, weight: .bold))
                                .offset(y: geometry.size.height / 60)
                            
                            Text(LocalizedStringKey("ProfilV5"))
                                .font(.system(size: 25, weight: .light))
                                .offset(y: geometry.size.height / 50)
                                .multilineTextAlignment(.center)
                                .foregroundColor(.gray)
                        }
                        
                        Spacer()
                        
                        VStack {
                            Text(String(user?.comments ?? 0))
                                .font(.system(size: 25, weight: .bold))
                                .offset(y: geometry.size.height / 60)
                            
                            Text(LocalizedStringKey("ProfilV6"))
                                .font(.system(size: 25, weight: .light))
                                .offset(y: geometry.size.height / 50)
                                .multilineTextAlignment(.center)
                                .foregroundColor(.gray)
                        }
                        
                        Spacer()
                    }

                    HStack {
                        Spacer()
                        
                        VStack {
                            Text(String(user?.likes ?? 0))
                                .font(.system(size: 25, weight: .bold))
                                .offset(y: geometry.size.height / 35)
                                .offset(x: -geometry.size.width / 25)
                            
                            Text(LocalizedStringKey("ProfilV7"))
                                .font(.system(size: 25, weight: .light))
                                .offset(y: geometry.size.height / 25)
                                .offset(x: -geometry.size.width / 25)
                                .multilineTextAlignment(.center)
                                .foregroundColor(.gray)
                        }
                        
                        Spacer()
                        
                        VStack {
                            Text(String(user?.milesTraveled ?? 0))
                                .font(.system(size: 25, weight: .bold))
                                .offset(y: geometry.size.height / 35)
                                .offset(x: -geometry.size.width / 25)
                            
                            Text(LocalizedStringKey("ProfilV8"))
                                .font(.system(size: 25, weight: .light))
                                .offset(y: geometry.size.height / 25)
                                .offset(x: -geometry.size.width / 25)
                                .multilineTextAlignment(.center)
                                .foregroundColor(.gray)
                        }
                        
                        Spacer()
                    }
                    Spacer(minLength: 60)
                    
                    Divider()
                        .padding(.leading, 25)
                    
                    HStack {
                        Text(LocalizedStringKey("ProfilV9"))
                            .font(.headline)
                            .padding(.top, 25)
                            .padding(.leading, 25)
                        Spacer()
                        Text("Metz")
                            .font(.headline)
                            .padding(.top, 25)
                            .padding(.trailing, 25)
                            .foregroundColor(.gray)
                    }
                    HStack {
                        Text(LocalizedStringKey("ProfilV10"))
                            .font(.headline)
                            .padding(.top, 25)
                            .padding(.leading, 25)
                        Spacer()
                        Text("Paris")
                            .font(.headline)
                            .padding(.top, 25)
                            .padding(.trailing, 25)
                            .foregroundColor(.gray)
                    }
                    HStack {
                        Text(LocalizedStringKey("ProfilV11"))
                            .font(.headline)
                            .padding(.top, 25)
                            .padding(.leading, 25)
                        Spacer()
                        Text("Accrobranche")
                            .font(.headline)
                            .padding(.top, 25)
                            .padding(.trailing, 25)
                            .foregroundColor(.gray)
                    }
                }
            }
        }
        .task {
            do {
                if let email = selectedMemberEmail {
                    user = try await groupAPI.getUserByEmail(email: email)
                }
            }
            catch {
                print(error)
            }
        }
        .onAppear {
            SoundManager.shared.playSound()
        }
    }
}

