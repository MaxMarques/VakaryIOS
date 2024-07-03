//
//  ProfilView.swift
//  Vakary
//
//  Created by Marques on 19/10/2022.
//

import SwiftUI
import SwiftUIFontIcon

struct ProfilView: View {
    
    @ObservedObject var updateProfil = Profil()
    @EnvironmentObject var profil: Profil
    @State var user: UserInfo? = nil
    
    @State private var changDesc: Bool = false
    @State var description = "(Description)"
    @State var showEditSheet = false
    @State private var showEditAlert = false
    @State private var editedDescription = ""
    @State private var editedUsername = ""
    @State private var showingImageModal = false
    @State private var profilPicture = UIImage(named: "avatar")!
    @State private var banierePicture = UIImage(named: "Cultural")!
    @State private var showingProfilPicture = false
    @State private var changeViewItineraryList = false
    @State private var changeViewEditedProfil = false
    @EnvironmentObject var map: MapModel
    @EnvironmentObject var dataStore: DataStore
    @EnvironmentObject var appTheme: AppTheme

    var body: some View {
        GeometryReader { geometry in
            ScrollView() {
                VStack(alignment: .leading) {
                    ZStack {
                        Image(uiImage: banierePicture)
                            .resizable()
                            .frame(maxWidth: .infinity, maxHeight: 150)
                        NavigationLink(
                            destination: EditedProfilView(username: user?.username ?? "", description: user?.description ?? "")
                                .environmentObject(profil)
                                .navigationBarHidden(false),
                            isActive: $changeViewEditedProfil
                        ) {
                            FontIcon.text(.materialIcon(code: .edit), fontsize: 35, color: .white)
                        }
                        .offset(x: geometry.size.width / 2.4, y: -geometry.size.height / 70)
                        AsyncImage(url: URL(string: user?.picture ?? "https://cpworldgroup.com/wp-content/uploads/2021/01/placeholder.png")) {
                            image in image.resizable()
                        } placeholder: {
                            ProgressView()
                        }
                        .frame(width: 95, height: 95)
                        .clipShape(Circle())
                        .padding(.leading, 10)
                        .offset(x: -geometry.size.width / 2 + 50, y: geometry.size.height / 10)
                    }
                    HStack {
                        VStack(alignment: .center) {
                            Text(user?.username ?? "Nom")
                                .font(.headline)
                            Text(user?.description ?? "Description")
                                .font(.subheadline)
                                .foregroundColor(appTheme.colorScheme == .dark ? .white : .black)
                        }
                        .padding(.leading)
                    }
                    .frame(maxWidth: .infinity, alignment: .center)
                    
                    Spacer(minLength: 20)
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
                    VStack(alignment: .center) {
                        NavigationLink(
                            destination: InfoPreviousItineraryView()
                                .environmentObject(MapAPI(dataStore: dataStore))
                                .environmentObject(map)
                                .navigationBarHidden(false),
                            isActive: $changeViewItineraryList
                        ) {
                            HStack {
                                Spacer()
                                Text(LocalizedStringKey("profilV20"))
                                    .foregroundColor(Color.white)
                                    .bold()
                                    .multilineTextAlignment(.center)
                                Spacer()
                            }
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color("BG1"))
                            .cornerRadius(25)
                        }
                    }
                    .padding()
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
                .task {
                    do {
                        user = try await profil.getMyUser()
                        debugPrint(user as Any)
                    }
                    catch {

                    }
                }
                Spacer()
                    .frame(height: 100)
            }
        }
        .refreshable {
            do {
                user = try await profil.getMyUser()
            }
            catch {

            }
        }
        .onAppear {
            SoundManager.shared.playSound()
        }
        if profil.isLoading {
            LoaderComponent()
        }
    }
}

