//
//  CreateGroupView.swift
//  Vakary
//
//  Created by Marques on 12/08/2023.
//

import SwiftUI
import PhotosUI
import SwiftUIFontIcon

struct CreateGroupView: View {
    @State var groupname = ""
    @State var groupPicture = UIImage(named: "baniere")!
    @State private var showingGroupPicture = false
    @State private var showingSelectGroupPicture = false
    @ObservedObject var group = GroupAPI()
    @State private var emails: [String] = []
    @State private var newEmail: String = ""
    @State private var showAlert = false
    @EnvironmentObject var profil: Profil
    @State var user: UserInfo? = nil
    @Binding var itineraryChoice: Bool
    @State private var showAlertCreatedGroup = false
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                Form {
                    Section(header: Text(LocalizedStringKey("CreateGroupV1"))) {
                        TextField("VAKARY", text: $groupname)
                            .ignoresSafeArea(.keyboard)
                    }
                    Section(header: Text(LocalizedStringKey("CreateGroupV2"))) {
                        HStack {
                            TextField("exemple.exemple.com", text: $newEmail, onCommit: {
                                self.addNewEmail()
                            })
                            Button(action: {
                                self.addNewEmail()
                            }) {
                                Text(LocalizedStringKey("CreateGroupV3"))
                            }
                        }
                        List {
                            ForEach(emails, id: \.self) { email in
                                Text(email)
                                    .swipeActions {
                                        Button(LocalizedStringKey("createGroupV10")) {
                                            Task {
                                                do {
                                                    removeEmail(email)
                                                }
                                            }
                                        }
                                        .tint(.red)
                                    }
                            }
                        }
                    }
                    Image(uiImage: groupPicture)
                    //                        .resizable()
                        .cornerRadius(20)
                        .frame(width: geometry.size.width/1.8, height: geometry.size.height/6, alignment: .center)
                    Text(LocalizedStringKey("CreateGroupV4"))
                        .foregroundColor(.blue)
                        .onTapGesture {
                            showingGroupPicture = true
                        }
                        .sheet(isPresented: $showingGroupPicture) {
                            VStack {
                                Image(uiImage: groupPicture)
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                Text(LocalizedStringKey("CreateGroupV5"))
                                    .font(.system(size: 25))
                                    .onTapGesture {
                                        showingSelectGroupPicture = true
                                    }
                            }
                            .sheet(isPresented: $showingSelectGroupPicture, content: {
                                PhotoPicker(profilImages: $groupPicture)
                            })
                        }
                    Section(footer:
                                HStack {
                        Button(action: {
                            SoundManager.shared.playSound()
                            Task {
                                do {
                                    let updateEmails = (user?.email ?? "") + ";" + emails.joined(separator: ";")
                                    try await self.group.createGroup(groupname: groupname, emails: updateEmails, groupPicture: groupPicture)
                                } catch {
                                    // Gérer les erreurs ici
                                }
                            }
                        }) {
                            Text(LocalizedStringKey("CreateGroupV6"))
                                .foregroundColor(Color.white)
                                .bold()
                                .multilineTextAlignment(.center)
                        }
                        .frame(maxWidth: geometry.size.width)
                        .padding()
                        .background(Color("BG1"))
                        .cornerRadius(25)
                    }
                    ) {
                        EmptyView()
                    }
                }
                if group.isLoading {
                    LoaderComponent()
                }
            }
            .task {
                do {
                    user = try await profil.getMyUser()
                }
                catch {
                    print(error)
                }
            }
            .onAppear() {
                SoundManager.shared.playSound()
            }
        }.edgesIgnoringSafeArea(.bottom)
            .overlay(overlayView: BannerComponent.init(data: BannerComponent.BannerDataModel(title: LocalizedStringKey("createGroupV11"), detail: LocalizedStringKey("CreateGroupV7"), type: .error), show: $group.groupNotCreated), show: $group.groupNotCreated)
            .overlay(overlayView: BannerComponent.init(data: BannerComponent.BannerDataModel(title: LocalizedStringKey("createGroupV12"), detail: LocalizedStringKey("createGroupV13"), type: .success), show: $group.groupCreated), show: $group.groupCreated)
    }
    private func addNewEmail() {
        if !newEmail.isEmpty {
            emails.append(newEmail)
            newEmail = ""
        }
    }
    
    private func removeEmail(_ email: String) {
        if let index = emails.firstIndex(of: email) {
            emails.remove(at: index)
        }
    }
}
