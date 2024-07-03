//
//  EditedProfilView.swift
//  VakaryIOS
//
//  Created by Thibaut  Humbert on 13/12/2023.
//

import SwiftUI

struct EditedProfilView: View {
    
    @State var user: UserInfo? = nil
    @EnvironmentObject var profil: Profil
    @ObservedObject var updateProfil = Profil()
    @State var username: String
    @State var description: String
    @State private var showingSelectGroupPicture = false
    @State private var showingGroupPicture = false
    @State private var profilPicture = UIImage(named: "noProfil2")!
    @State private var banierePicture = UIImage(named: "Cultural")!
    @State private var isProfilePictureChanged = false
    @State private var showAlert = false
    @State private var profilUpdated = false
    @State private var profilNotUpdated = false
    
    var body: some View {
        VStack {
            ZStack {
                Image(uiImage: banierePicture)
                    .resizable()
                    .frame(maxWidth: .infinity, maxHeight: 160)
                Image(uiImage: profilPicture)
                    .resizable()
                    .frame(width: 95, height: 95)
                    .clipShape(Circle())
                    .padding(.leading, 10)
                    .offset(x: -160, y: 75)
                    .onTapGesture {
                        showingGroupPicture = true
                    }
                    .sheet(isPresented: $showingGroupPicture) {
                        VStack {
                            Image(uiImage: profilPicture)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                            Text(LocalizedStringKey("editedProfilV1"))
                                .font(.system(size: 25))
                                .onTapGesture {
                                    showingSelectGroupPicture = true
                                }
                        }
                        .sheet(isPresented: $showingSelectGroupPicture, content: {
                            PhotoPicker(profilImages: $profilPicture)
                                .onChange(of: profilPicture) { newImage in
                                    isProfilePictureChanged = true
                                    profilPicture = newImage
                                }
                        })

                    }
            }
            Spacer(minLength: 60)
            Form {
                Section(header: Text(LocalizedStringKey("editedProfilV2"))) {
                    TextField(user?.username ?? "null", text: $username)
                }
                Section(header: Text(LocalizedStringKey("editedProfilV4"))) {
                    TextField(user?.description ?? "null", text: $description)
                }
            }
            Button {
                Task {
                    do {
                        let update = UpdateProfil(username: username, description: description)
                        try await self.updateProfil.updateProfil(userInfo: update)
                        
                        if isProfilePictureChanged {
                            try await self.updateProfil.updateProfilPicture(profilPicture: profilPicture)
                        }

                        profilUpdated = true
                    } catch {
                        profilNotUpdated = true
                    }
                    if profil.updateProfil {
                        showAlert = true
                    }
                }
            } label: {
                HStack {
                    Text(LocalizedStringKey("editedProfilV6"))
                        .foregroundColor(Color.white)
                        .bold()
                        .multilineTextAlignment(.center)
                }
                .padding()
                .background(Color("BG1"))
                .cornerRadius(25)
            }
            .frame(maxWidth: .infinity / 2)

        }
        .onAppear {
            if let existingUsername = user?.username {
                username = existingUsername
            }
            if let existingDescription = user?.description {
                description = existingDescription
            }
            SoundManager.shared.playSound()
        }
        .task {
            do {
                user = try await profil.getMyUser()
                debugPrint(user as Any)
            }
            catch {
                
            }
        }
        .alert(isPresented: $showAlert) {
                Alert(
                    title: Text("Current Location Not Available"),
                    message: Text("Your current location can’t be " +
                                    "determined at this time.")
                )
            }
        
        .overlay(overlayView: BannerComponent.init(data: BannerComponent.BannerDataModel(title: LocalizedStringKey("editedProfilV7"), detail: LocalizedStringKey("editedProfilV8"), type: .error), show: $profilNotUpdated), show: $profilNotUpdated)
        .overlay(overlayView: BannerComponent.init(data: BannerComponent.BannerDataModel(title: LocalizedStringKey("editedProfilV9"), detail: LocalizedStringKey("editedProfilV10"), type: .success), show: $profilUpdated), show: $profilUpdated)
        
        if profil.isLoading {
            LoaderComponent()
        }
    }
}
