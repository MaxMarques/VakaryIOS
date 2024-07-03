//
//  ShowGroupView.swift
//  Vakary
//
//  Created by Marques on 12/08/2023.
//

import SwiftUI
import SwiftUIFontIcon

struct ShowGroupView: View {
    @State var groupMembers: String = ""
    @State private var showDetails = false
    @State var addEmail = ""
    @State var group: Group
    @State var groupAPI = GroupAPI()
    @State private var showAlertMemberAdded = false
    @State private var showAlertMemberNotAdded = false
    @State private var showAlertMemberDeleted = false
    @State private var showAlertMemberNotDeleted = false
    @State private var changeViewProfilOfMemberView: Bool = false
    @State private var selectedMemberEmail: String?
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                VStack {
                    HStack {
                        FontIcon.text(.materialIcon(code: .add), fontsize: 35, color: .blue)
                        Button(LocalizedStringKey("ShowGroupV1")) {
                            showDetails.toggle()
                        }
                        .foregroundColor(.blue)
                    }
                    VStack {
                        if showDetails {
                            HStack {
                                TextField("exemple.exemple.com", text: $groupMembers)
                                Button(LocalizedStringKey("ShowGroupV2")) {
                                    Task {
                                        do {
                                            print("memberAdded: ", self.groupAPI.memberAdded as Any)
                                            print("memberAdded: ", self.groupAPI.memberNotAdded)
                                            try await self.groupAPI.addMember(groupId: group.id, email: groupMembers)
                                            if self.groupAPI.memberAdded == true {
                                                self.showAlertMemberAdded = true
                                            }
                                            print(self.groupAPI.memberAdded as Any)
                                            showAlertMemberAdded = true
                                        } catch {
                                            if self.groupAPI.memberNotAdded == true {
                                                self.showAlertMemberNotAdded = true
                                            }
                                            showAlertMemberNotAdded = true
                                        }
                                    }
                                }
                                .padding(.horizontal, 10)
                                .background(Color.blue)
                                .foregroundColor(.white)
                                .cornerRadius(10)
                            }
                        }
                    }
                }
                List(group.emails, id: \.self) { email in
                    NavigationLink(
                        destination: ProfilOfMemberView(selectedMemberEmail: email),
                        isActive: Binding(
                            get: { selectedMemberEmail == email },
                            set: { isActive in
                                if !isActive {
                                    selectedMemberEmail = nil
                                }
                            }
                        )
                    ) {
                        HStack {
                            Image("noprofil")
                                .resizable()
                                .frame(width: 30, height: 30)
                                .clipShape(Circle())
                                .shadow(radius: 10)
                            Text(email.trimmingCharacters(in: .whitespacesAndNewlines))
                            Spacer()
                            if findGroupStatusByEmail(email: email) != nil {
                                if findGroupStatusByEmail(email: email) == "joined" {
                                    FontIcon.text(.materialIcon(code: .check_circle), fontsize: 20, color: .green)
                                }
                                else {
                                    FontIcon.text(.materialIcon(code: .schedule), fontsize: 20, color: .orange)
                                }
                            }
                        }
                    }.swipeActions {
                        Button(LocalizedStringKey("ShowGroupV3")) {
                            Task {
                                do {
                                    try await self.groupAPI.deleteMember(groupId: group.id, email: email)
                                    if self.groupAPI.memberDeleted {
                                        self.showAlertMemberDeleted = true
                                    }
                                    print(self.groupAPI.memberDeleted)
                                    if self.groupAPI.memberNotDeleted {
                                        self.showAlertMemberNotDeleted = true
                                    }
                                    print(self.groupAPI.memberNotDeleted)
                                    showAlertMemberDeleted = true
                                } catch {
                                    if self.groupAPI.memberNotDeleted {
                                        self.showAlertMemberNotDeleted = true
                                    }
                                    showAlertMemberNotDeleted = true
                                }
                            }
                        }
                        .tint(.red)
                    }
                    .onTapGesture {
                        Task {
                            do {
                                selectedMemberEmail = email
                                //                                changeViewProfilOfMemberView.toggle()
                            } catch {
                                // Gérer les erreurs ici
                            }
                        }
                    }
                }.refreshable {}
            }
            .navigationBarTitle(Text(LocalizedStringKey("ShowGroupV4")), displayMode: .inline)
            .refreshable {}
        }
        .edgesIgnoringSafeArea(.bottom)
        .overlay(overlayView: BannerComponent.init(data: BannerComponent.BannerDataModel(title: LocalizedStringKey("showGroupV10"), detail: LocalizedStringKey("showGroupV11"), type: .error), show: $showAlertMemberNotAdded), show: $showAlertMemberNotAdded)
        .overlay(overlayView: BannerComponent.init(data: BannerComponent.BannerDataModel(title: LocalizedStringKey("showGroupV12"), detail: LocalizedStringKey("showGroupV13"), type: .success), show: $showAlertMemberAdded), show: $showAlertMemberAdded)
        .overlay(overlayView: BannerComponent.init(data: BannerComponent.BannerDataModel(title: LocalizedStringKey("showGroupV14"), detail: LocalizedStringKey("showGroupV15"), type: .error), show: $showAlertMemberNotDeleted), show: $showAlertMemberNotDeleted)
        .overlay(overlayView: BannerComponent.init(data: BannerComponent.BannerDataModel(title: LocalizedStringKey("showGroupV16"), detail: LocalizedStringKey("showGroupV17"), type: .success), show: $showAlertMemberDeleted), show: $showAlertMemberDeleted)
        .onAppear {
            SoundManager.shared.playSound()
        }
    }
    
    func findGroupStatusByEmail(email: String) -> String? {
        if let i = group.status?.firstIndex(where: {$0.User?.email == email}) {
            return group.status?[i].status
        }
        return nil
    }
}
