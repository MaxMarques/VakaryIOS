//
//  ChatView.swift
//  VakaryIOS
//
//  Created by Thibaut  Humbert on 26/09/2023.
//

import SwiftUI

struct ChatView: View {
    
    @EnvironmentObject var profil: Profil
    @State var user: UserInfo? = nil
    @State var group: Group
    @ObservedObject var groupAPI = GroupAPI()
    
    @State private var newMessageText = ""
    
    var body: some View {
        GeometryReader { geometry in
            VStack(alignment: .leading) {
                VStack {
                    AsyncImage(url: URL(string: group.picture ?? "https://cpworldgroup.com/wp-content/uploads/2021/01/placeholder.png")) {
                        image in image.resizable()
                    } placeholder: {
                        ProgressView()
                    }
                    //                    .resizable()
                    .cornerRadius(20)
                    .frame(width: geometry.size.width/1.8, height: geometry.size.height/6, alignment: .center)
                    Text(group.name)
                        .font(.headline)
                        .foregroundColor(.black)
                    Divider()
                        .padding(.leading, 25)
                }
                VStack {
                    ScrollView {
                        VStack {
                            ForEach(groupAPI.allMessages, id: \.id) { message in
                                if let user = user {
                                    MessageView(mess: message, user: user)
                                }
                            }
                        }
                    }
                    HStack {
                        TextField(LocalizedStringKey("chatV1"), text: $newMessageText)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                        Button(action: {
                            Task {
                                do {
                                    try await groupAPI.sendChat(chatId: group.chat!.id, messageBody: newMessageText)
                                    
                                    try await groupAPI.getChat(chatId: group.chat!.id)
                                    
                                    newMessageText = ""
                                } catch {
                                    // Gérer les erreurs ici
                                }
                            }
                        }) {
                            Image(systemName: "arrow.right.circle.fill")
                                .font(.system(size: 30))
                                .foregroundColor(.blue)
                        }
                    }
                    .padding()
                }
            }
        }
        .task {
            do {
                try await groupAPI.getChat(chatId: group.chat!.id)
                user = try await profil.getMyUser()
            } catch {
                // Gérer les erreurs ici
                print("Erreur lors de la récupération des messages : \(error)")
            }
        }
        .onAppear {
            SoundManager.shared.playSound()
        }
    }
}

struct MessageView: View {
//    var message: Message
    var mess: AllMessages
    var user: UserInfo
    
    var body: some View {
        HStack {
            if mess.user.username != user.username {
                HStack {
                    VStack {
                        Image("bleu_profil")
                            .resizable()
                            .frame(width: 40, height: 40)
                            .clipShape(Circle())
                    }
                    VStack {
                        HStack {
                            Text(mess.user.username)
                                .font(.system(size: 8))
                                .foregroundColor(.gray)
                                .padding(.trailing, 5)
                            Spacer()
                        }
                        HStack {
                            Text(mess.messageBody)
                                .padding(10)
                                .foregroundColor(.white)
                                .background(Color(red: 0.752, green: 0.752, blue: 0.752))
                                .cornerRadius(10)
                            Spacer()
                        }
                    }
                }
                Spacer()
            }
            if mess.user.username == user.username {
                Spacer()
                VStack {
                    HStack {
                        Spacer()
                        Text(LocalizedStringKey("chatV2"))
                            .font(.system(size: 8))
                            .foregroundColor(.gray)
                            .padding(.trailing, 5)
                    }
                    HStack {
                        Spacer()
                        Text(mess.messageBody)
                            .padding(10)
                            .foregroundColor(.white)
                            .background(Color.blue)
                            .cornerRadius(10)
                    }
                }
            }
        }
        .padding(.horizontal)
    }
}
