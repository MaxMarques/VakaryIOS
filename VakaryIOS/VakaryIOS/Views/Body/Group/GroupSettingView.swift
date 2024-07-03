//
//  GroupSettingView.swift
//  Vakary
//
//  Created by Marques on 12/08/2023.
//

import SwiftUI
import SwiftUIFontIcon
import PhotosUI

struct GroupSettingView: View {
    
    struct Parent : Identifiable  {
        let name: LocalizedStringKey
        let id = UUID()
        let children : [Children]
    }

    struct Children : Identifiable {
        let name: LocalizedStringKey
        var dest : AnyView?
        let icon : Icon
        let colorText : Color
        let id = UUID()
    }

    struct Icon {
        let iconCode : MaterialIconCode
        let iconColor : Color
    }
    
    private var group: Group
    private var list : [Parent]
    @StateObject var routerModels: Router
    @EnvironmentObject var map: MapModel
    @ObservedObject var groupAPI = GroupAPI()
    @State private var singleSelection: UUID?
    @State var newGrouname: String = ""
    @State private var showingAlertGroupName = false
    @State private var showingAlertLeaveGroup = false
    @State private var showingAlertGroupPicture = false
    @State private var showingSelectGroupPicture = false
    @State private var itineraryGood = false
    @State private var itineraryFalse = false
    @State var groupPicture = UIImage(named: "baniere")!
    @State private var showingOptions = false
    @State private var showAlertDeletedGroup = false
    @State private var sharedItinerary = false
    @State private var groupDeleted = false
    @State private var groupNotDeleted = false
    @EnvironmentObject var appTheme: AppTheme
    @EnvironmentObject var mapAPI: MapAPI
    @EnvironmentObject var dataStore: DataStore
    @State private var array: [InterestPoint] = [] {
            didSet {
                dataStore.itineraryArray = array
            }
        }
    
    init(group: Group, array: [InterestPoint], router: Router) {
        self.group = group
        self._array = State(initialValue: array)
        self._routerModels = StateObject(wrappedValue: router)
        self.list = [
            Parent(name: LocalizedStringKey("GroupSetingsV1"), children: [
                Children(name: LocalizedStringKey("GroupSetingsV2"),  dest : AnyView(ShowGroupView(group: group)), icon: Icon(iconCode: .group, iconColor: .black), colorText: .black),
                Children(name: "Chat",  dest : AnyView(ChatView(group: group).environmentObject(Profil())), icon: Icon(iconCode: .chat, iconColor: .black), colorText: .black)
            ]),
            
            Parent(name: LocalizedStringKey("GroupSetingsV6"), children: [
                Children(name: LocalizedStringKey("GroupSetingsV8"), icon: Icon(iconCode: .block, iconColor: .red), colorText: .red)
            ])
        ]
    }
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                Spacer()
                VStack {
                    AsyncImage(url: URL(string: group.picture ?? "https://cpworldgroup.com/wp-content/uploads/2021/01/placeholder.png")) {
                        image in image.resizable()
                    } placeholder: {
                        ProgressView()
                    }
                    .cornerRadius(20)
                    .frame(width: geometry.size.width/1.8, height: geometry.size.height/6, alignment: .center)
                    Text(group.name)
                    .font(.system(size: 30, weight: .bold))
                    Button(LocalizedStringKey("GroupSetingsV9")) {
                        showingOptions = true
                    }
                    .font(.system(size: 20))
                    .multilineTextAlignment(.center)
                    .confirmationDialog(LocalizedStringKey("groupSettingV25"), isPresented: $showingOptions, titleVisibility: .visible) {
                        Button(LocalizedStringKey("GroupSetingsV10")) {
                            showingAlertGroupPicture = true
                        }
                        Button(LocalizedStringKey("GroupSetingsV11")) {
                            showingAlertGroupName = true
                        }
                    }
                }
                .sheet(isPresented: $showingAlertGroupPicture) {
                    VStack {
                        Image(uiImage: groupPicture)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                        Text(LocalizedStringKey("GroupSetingsV12"))
                            .font(.system(size: 25))
                            .onTapGesture {
                                showingSelectGroupPicture = true
                            }
                        Spacer()
                        Text(LocalizedStringKey("GroupSetingsV13"))
                            .font(.system(size: 25))
                            .onTapGesture {
                                Task {
                                    do {
                                        try await self.groupAPI.updateGroupPicture(groupeId: group.id, groupPicture: groupPicture)
                                    } catch {

                                    }
                                }
                            }
                    }
                    .sheet(isPresented: $showingSelectGroupPicture, content: {
                        PhotoPicker(profilImages: $groupPicture)
                    })
                }
                .alert(LocalizedStringKey("GroupSetingsV14"), isPresented: $showingAlertGroupName) {
                    TextField(group.name, text: $newGrouname)
                    Button(LocalizedStringKey("GroupSetingsV15")) {}
                    Button(LocalizedStringKey("GroupSetingsV16")) {
                        Task {
                            do {
                                let group_update = GroupUpdate(groupname: newGrouname)
                                try await self.groupAPI.updateGroup(groupId: group.id, groupUpdate: group_update)
                            } catch {
                            }
                        }
                    }
                }
                Button(action: {
                    Task {
                        do {
                            dataStore.sharedItineraryID = group.itinerary?.id ?? ""
                            let test = try await mapAPI.getSharedItinerary(itineraryId: dataStore.sharedItineraryID)
                            DispatchQueue.main.async {
                                if test.isEmpty {
                                    itineraryFalse = true
                                } else {
                                    array = test
                                    map.itineraryChoice = true
                                    sharedItinerary = true
                                    routerModels.currentPage = .map
                                    itineraryGood = true
                                }
                            }
                        } catch {
                            print(error)
                        }
                    }
                    map.itineraryChoice = true
                }) {
                    Text(LocalizedStringKey("GroupSetingsV17"))
                        .padding(22)
                        .frame(width: 222, height: 44)
                        .background(Color.blue)
                        .foregroundColor(Color.white)
                }.frame(width: 222, height: 44)
                 .background(Color.blue).cornerRadius(10)
                List {
                    ForEach(list) { list in
                        Section(header: Text(list.name)) {
                            ForEach(list.children) { list in
                                HStack {
                                    FontIcon.text(.materialIcon(code: list.icon.iconCode), fontsize: 30, color: list.icon.iconColor)
                                    if ((list.dest) != nil) {
                                        NavigationLink {
                                            list.dest
                                        } label: {
                                            Text(list.name)
                                                .foregroundColor(appTheme.colorScheme == .dark ? .white : .black)
                                        }
                                    } else {
                                        Text(list.name).foregroundColor(appTheme.colorScheme == .dark ? .white : .black).onTapGesture {
                                                showingAlertLeaveGroup = true
                                        }
                                        .alert(LocalizedStringKey("GroupSetingsV18"), isPresented: $showingAlertLeaveGroup) {
                                            Button(LocalizedStringKey("GroupSetingsV19")) {
                                                Task {
                                                    do {
                                                        try await self.groupAPI.deleteGroup(groupId: group.id)
                                                        groupDeleted = true
                                                        if groupAPI.groupDeleted {
                                                            showAlertDeletedGroup = true
                                                        }
                                                    } catch {
                                                        groupNotDeleted = true
                                                    }
                                                }
                                            }.font(.system(size: 30, weight: .bold, design: .default))
                                            Button(LocalizedStringKey("GroupSetingsV20")) {}
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
            .navigationBarTitle(Text(LocalizedStringKey("GroupSetingsV23")), displayMode: .inline)
            .background(appTheme.colorScheme == .dark ? .black : .white)
            .overlay(overlayView: BannerComponent.init(data: BannerComponent.BannerDataModel(title: LocalizedStringKey("groupSettingV26"), detail: LocalizedStringKey("groupSettingV27"), type: .error), show: $itineraryFalse), show: $itineraryFalse)
            .overlay(overlayView: BannerComponent.init(data: BannerComponent.BannerDataModel(title: LocalizedStringKey("groupSettingV28"), detail: LocalizedStringKey("groupSettingV29"), type: .success), show: $itineraryGood), show: $itineraryGood)
            .overlay(overlayView: BannerComponent.init(data: BannerComponent.BannerDataModel(title: LocalizedStringKey("SignInV6"), detail: LocalizedStringKey("SignUpV19"), type: .error), show: $groupNotDeleted), show: $groupNotDeleted)
            .navigationDestination(isPresented: $groupDeleted) {
                MainView(routerModels: routerModels)
                    .environmentObject(map)
                    .navigationBarHidden(true)
            }
            .onAppear {
                SoundManager.shared.playSound()
            }
        }
    }
}
