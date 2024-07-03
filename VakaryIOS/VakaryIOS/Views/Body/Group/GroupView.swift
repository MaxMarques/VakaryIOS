//
//  GroupView.swift
//  Vakary
//
//  Created by Marques on 19/10/2022.
//

import SwiftUI
import SwiftUIFontIcon

struct GroupView: View {
    @State private var changeViewShowChatGroup: Bool = false
    @State private var changeViewCreateGroup: Bool = false
    @State private var acceptedGroup: Bool = false
    @State private var acceptedGroupFail: Bool = false
    @State private var refusedGroup: Bool = false
    @State private var refusedGroupFail: Bool = false
    @State private var image = UIImage()
    @StateObject var routerModels: Router
    @ObservedObject var group = GroupAPI()
    @State var array: [Group] = []
    @State var arrayStatus: [GroupStatus] = []
    @State var selectedGroupURL: URL? = nil
    @State private var groupView = 0
    @EnvironmentObject var profil: Profil
    @State var user: UserInfo? = nil
    @State private var refreshView = 0
    @EnvironmentObject var dataStore: DataStore
    @EnvironmentObject var mapAPI: MapAPI
    @EnvironmentObject var map: MapModel
    
    var body: some View {
        GeometryReader { geometry in
            ScrollView() {
                ZStack {
                    NavigationStack {
                        GeometryReader { geometry in
                            VStack {
                                Picker("Groupe", selection: $groupView) {
                                    Text(LocalizedStringKey("GroupV1")).tag(0)
                                    
                                    Text(LocalizedStringKey("GroupV2"))
                                        .tag(1)
                                }
                                .pickerStyle(.segmented)
                                .overlay {
                                    if array.contains(where: { group in
                                        group.status?.contains { member in
                                            member.User?.email == user?.email && member.status == "pending"
                                        } ?? false
                                    }) {
                                        Text("1")
                                            .padding(5)
                                            .background(Color.red)
                                            .foregroundColor(.white)
                                            .clipShape(Circle())
                                            .overlay(
                                                Circle()
                                                    .stroke(Color.white, lineWidth: 1)
                                            )
                                            .offset(x: 10, y: -10)
                                    }
                                }
                                if groupView == 0 {
                                    ForEach(array.filter { group in
                                        group.status?.contains { member in
                                            member.User?.email == user?.email && member.status == "joined"
                                        } ?? false
                                    }, id: \.id) { group in
                                        NavigationLink(
                                            destination: GroupSettingView(group: group, array: dataStore.sharedItineraryArray, router: routerModels)
                                                .navigationBarHidden(false)
                                                .environmentObject(MapAPI(dataStore: dataStore))
                                                .environmentObject(map)
                                        ) {
                                            VStack(alignment: .leading) {
                                                HStack {
                                                    HStack {
                                                        AsyncImage(url: URL(string: group.picture!)) {
                                                            image in image.resizable().cornerRadius(10)
                                                        } placeholder: {
                                                            ProgressView()
                                                        }
                                                        .frame(width: 80, height: 80)
                                                        VStack(alignment: .leading) {
                                                            Text(group.name)
                                                                .font(.title)
                                                                .foregroundColor(.black)
                                                        }
                                                        Spacer()
                                                        VStack {
                                                            Text("\(group.emails.count)")
                                                                .font(.system(size: 13))
                                                                .foregroundColor(.black)
                                                            FontIcon.text(.materialIcon(code: .people), fontsize: 15, color: .black)
                                                        }
                                                    }
                                                }
                                                .padding()
                                                .background(Color.white)
                                                .cornerRadius(10)
                                                .shadow(radius: 10)
                                            }
                                            .padding()
                                        }
                                    }
                                    NavigationLink(
                                        destination: CreateGroupView(itineraryChoice: $map.itineraryChoice)
                                            .environmentObject(GroupAPI())
                                            .environmentObject(Profil())
                                            .navigationBarHidden(false),
                                        isActive: $changeViewCreateGroup
                                    ) {
                                        VStack {
                                            Spacer()
                                            HStack {
                                                Spacer()
                                                Text(LocalizedStringKey("GroupV3"))
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
                                        .frame(maxWidth: geometry.size.width / 2) // Définissez la largeur maximale souhaitée
                                    }
                                } else {
                                    ForEach(array.filter { group in
                                        group.status?.contains { member in
                                            member.User?.email == user?.email && member.status == "pending"
                                        } ?? false
                                    }, id: \.id) { group in
                                        VStack(alignment: .leading) {
                                            HStack {
                                                HStack {
                                                    AsyncImage(url: URL(string: group.picture!)) {
                                                        image in image.resizable().cornerRadius(10)
                                                    } placeholder: {
                                                        ProgressView()
                                                    }
                                                        .frame(width: 50, height: 50)
                                                        .cornerRadius(25)
                                                    VStack(alignment: .leading) {
                                                        Text(group.name)
                                                            .font(.title)
                                                            .foregroundColor(.black)
                                                    }
                                                    Spacer()
                                                    Button(action: {
                                                            Task {
                                                                do {
                                                                    try await self.group.acceptGroup(groupId: group.id, email: user?.email ?? "", status: (1 != 0))
                                                                    refreshView = refreshView + 1
                                                                    acceptedGroup = true
                                                                    groupView = 0
                                                                    array = try await self.group.getMyAllGroup()
                                                                } catch {
                                                                    print("Error accepting group: \(error)")
                                                                    acceptedGroupFail = true
                                                                }
                                                            }
                                                        }) {
                                                            Text(LocalizedStringKey("groupV10"))
                                                                .font(.system(size: 15))
                                                                .foregroundColor(.green)
                                                        }
                                                        .padding()
                                                        
                                                        Button(action: {
                                                            Task {
                                                                do {
                                                                    try await self.group.acceptGroup(groupId: group.id, email: user?.email ?? "", status: (0 != 0))
                                                                    refreshView = refreshView + 1
                                                                    refusedGroup = true
                                                                } catch {
                                                                    print("Error refused group: \(error)")
                                                                    refusedGroupFail = true
                                                                }
                                                            }
                                                        }) {
                                                            Text(LocalizedStringKey("groupV11"))
                                                                .font(.system(size: 15))
                                                                .foregroundColor(.red)
                                                        }
                                                        .padding()
                                                }
                                            }
                                            .padding()
                                            .background(Color.white)
                                            .cornerRadius(10)
                                            .shadow(radius: 10)
                                        }
                                        .padding()
                                    }
                                }
                                
                            }
                            .task {
                                do {
                                    array = try await group.getMyAllGroup()
                                    user = try await profil.getMyUser()
                                }
                                catch {
                                    print(error)
                                }
                            }
                            .refreshable() {
                                do {
                                    array = try await group.getMyAllGroup()
                                }
                                catch {
                                    print(error)
                                }
                            }
                            .overlay(overlayView: BannerComponent.init(data: BannerComponent.BannerDataModel(title: LocalizedStringKey("groupV12"), detail: LocalizedStringKey("groupV13"), type: .error), show: $acceptedGroupFail), show: $acceptedGroupFail)
                            .overlay(overlayView: BannerComponent.init(data: BannerComponent.BannerDataModel(title: LocalizedStringKey("groupV14"), detail: LocalizedStringKey("groupV15"), type: .success), show: $acceptedGroup), show: $acceptedGroup)
                            .overlay(overlayView: BannerComponent.init(data: BannerComponent.BannerDataModel(title: LocalizedStringKey("groupV16"), detail: LocalizedStringKey("groupV17"), type: .error), show: $refusedGroupFail), show: $refusedGroupFail)
                            .overlay(overlayView: BannerComponent.init(data: BannerComponent.BannerDataModel(title: LocalizedStringKey("groupV18"), detail: LocalizedStringKey("groupV19"), type: .success), show: $refusedGroup), show: $refusedGroup)
                        }
                    }
                }
                Spacer()
                    .frame(height: 100)
            }
        }
        .onAppear {
            SoundManager.shared.playSound()
        }
    }
}
