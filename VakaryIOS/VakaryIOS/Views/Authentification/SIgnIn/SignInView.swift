//
//  SignInView.swift
//  Vakary
//
//  Created by Marques on 12/08/2022.
//
import SwiftUIFontIcon
import SwiftUI
import WebKit

struct SignInView: View {
    init(){
        UINavigationBar.setAnimationsEnabled(false)
    }

    @StateObject var  routerModels = Router()
    @StateObject var  faceID = FaceIDManager()
    @StateObject var map = MapModel()
    @EnvironmentObject var signIn: SignIn
    @State private var colorWhite = Color.white
    @State private var colorBlack = Color.black
    @State private var showTextPassword = false
    @State private var missingFields = false
    @State var mail = ""
    @State var password = ""
    @State private var back = false

    var body: some View {
        GeometryReader { geometry in
            NavigationStack {
                ZStack {
                    Color("Color1")
                        .ignoresSafeArea()
                    VStack {
                        VStack {
                            HStack {
                                Button(action: {
                                    back.toggle()
                                }) {
                                    Image(systemName: "chevron.backward")
                                        .font(.system(size: geometry.size.height/26, weight: .bold))
                                        .foregroundColor(Color("Color2"))
                                }.padding(.horizontal, 10)
                                Spacer()
                            }.navigationDestination(isPresented: $back) {
                                StartView().navigationBarHidden(true)
                            }
                        }
                        Spacer()
                        VStack {
                            Image("LogoVakary")
                                .resizable()
                                .frame(width: geometry.size.width/3, height:  geometry.size.width/3)
                        }
                        Spacer()
                        VStack {
                            VStack {
                                VStack(alignment: .leading) {
                                    Text(LocalizedStringKey("SignInV1"))
                                        .font(.system(size: geometry.size.height/50))
                                        .foregroundColor(Color("Color5"))
                                        .bold()
                                    HStack {
                                        TextField("", text: $mail)
                                            .onTapGesture {
                                                UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                                            }
                                            .foregroundColor(colorBlack)
                                            .padding(.horizontal)
                                            .frame(width: geometry.size.height/2.8)
                                            .keyboardType(.default)
                                            .disableAutocorrection(true)
                                            .autocapitalization(.none)
                                    }
                                    Divider()
                                        .frame(width: geometry.size.height/2.4)
                                }.padding(.bottom, 30)
                                VStack(alignment: .leading) {
                                    Text(LocalizedStringKey("SignInV2"))
                                        .font(.system(size: geometry.size.height/50))
                                        .foregroundColor(Color("Color5"))
                                        .bold()
                                    HStack {
                                        if showTextPassword {
                                            TextField("", text: $password)
                                                .onTapGesture {
                                                    UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                                                }
                                                .foregroundColor(colorBlack)
                                                .padding(.horizontal)
                                                .frame(width: geometry.size.height/2.8)
                                                .keyboardType(.default)
                                                .disableAutocorrection(true)
                                                .autocapitalization(.none)
                                        } else {
                                            SecureField("", text: $password)
                                                .onTapGesture {
                                                    UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                                                }
                                                .foregroundColor(colorBlack)
                                                .padding(.horizontal)
                                                .frame(width: geometry.size.height/2.8)
                                                .keyboardType(.default)
                                                .disableAutocorrection(true)
                                                .autocapitalization(.none)
                                        }
                                        Button(action: {
                                            showTextPassword.toggle()
                                        }, label: {
                                            Image(systemName: showTextPassword ? "eye.slash.fill" : "eye.fill")
                                                .foregroundColor(colorBlack)
                                        })
                                    }
                                    Divider()
                                        .frame(width: geometry.size.height/2.4)
                                }
                            }
                            .padding(.vertical)
                            .padding(.horizontal)
                            .padding(.bottom, 60)
                            .background(colorWhite)
                            .cornerRadius(10)
                            
                            HStack {
                                VStack {
                                    Button(action: {
                                        if mail.count == 0 || password.count == 0 {
                                            missingFields = true
                                        } else {
                                            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                                            self.signIn.cekLogin(password: self.password, email: self.mail, faceIdConnection: "")
                                        }
                                    }) {
                                        Text(LocalizedStringKey("SignInV3"))
                                            .font(.title3.bold())
                                            .foregroundColor(Color("Color1"))
                                            .padding(.vertical, 22)
                                            .frame(width: geometry.size.height/3, height: geometry.size.width/6)
                                            .background(Color("Color5"))
                                            .cornerRadius(100)
//                                            .background(
//                                                .linearGradient(.init(colors: [
//                                                    Color("Button1"),
//                                                    Color("Button2"),
//                                                ]), startPoint: .leading, endPoint: .trailing), in: RoundedRectangle(cornerRadius: 20)
//                                            )
                                    }
                                }
                                switch faceID.biometryType {
                                case .faceID:
                                    FaceIDComponent(image: "faceID", size: geometry.size.height/30)
                                        .foregroundColor(colorWhite)
                                        .frame(width: geometry.size.height/16, height: geometry.size.width/8)
                                        .background(Color("Color4"))
                                        .cornerRadius(15)
//                                        .background(
//                                            .linearGradient(.init(colors: [
//                                                Color("Button1"),
//                                                Color("Button2"),
//                                            ]), startPoint: .leading, endPoint: .trailing), in: RoundedRectangle(cornerRadius: 20)
//                                        )
                                        .onTapGesture {
                                            Task.init {
                                                await faceID.authenticateWithBiometrics()
                                                if faceID.isAuthenticated {
                                                    self.signIn.cekLogin(password: "", email: "", faceIdConnection: UserDefaults.standard.string(forKey: "faceID") ?? "")
                                                }
                                            }
                                        }
                                case .touchID:
                                    FaceIDComponent(image: "touchID", size: geometry.size.height/30)
                                        .foregroundColor(colorWhite)
                                        .frame(width: geometry.size.height/13, height: geometry.size.width/8)
                                        .background(Color("Color4"))
                                        .cornerRadius(15)
//                                        .background(
//                                            .linearGradient(.init(colors: [
//                                                Color("Button1"),
//                                                Color("Button2"),
//                                            ]), startPoint: .leading, endPoint: .trailing), in: RoundedRectangle(cornerRadius: 20)
//                                            )
                                        .onTapGesture {
                                            Task.init {
                                                await faceID.authenticateWithBiometrics()
                                                if faceID.isAuthenticated {
                                                    self.signIn.cekLogin(password: "", email: "", faceIdConnection: UserDefaults.standard.string(forKey: "faceID") ?? "")
                                                }
                                            }
                                        }
                                default:
                                    FaceIDComponent(image: "person.crop.circle.badge.exclamationmark", size: geometry.size.height/30)
                                        .foregroundColor(colorWhite)
                                        .frame(width: geometry.size.height/16, height: geometry.size.width/8)
                                        .background(Color("Color4"))
                                        .cornerRadius(15)
//                                        .background(
//                                            .linearGradient(.init(colors: [
//                                                Color("Button1"),
//                                                Color("Button2"),
//                                            ]), startPoint: .leading, endPoint: .trailing), in: RoundedRectangle(cornerRadius: 20)
//                                            )
                                }
                            }.navigationDestination(isPresented: $signIn.isLoggedin) {
                                MainView(routerModels: routerModels).environmentObject(map).navigationBarHidden(true)
                            }
                            .offset(y: -40)
                                .padding(.bottom, -46)
                                .onTapGesture {
                                    UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                                }


                            Button(action: {
                            }) {
                                NavigationLink(
                                    destination: LostPasswordView().navigationBarHidden(true),
                                    label: {
                                        Text(LocalizedStringKey("SignInV4"))
                                            .font(.system(size: geometry.size.width/25))
                                            .fontWeight(.semibold)
                                            .foregroundColor(Color("Color5"))
                                            .padding(.bottom)
                                    }).navigationBarHidden(true)
                            }.padding(.top)
                        }
                        VStack {
                            HStack(spacing: 15) {
                                Color("Color2")
                                    .frame(width: geometry.size.height/10, height: geometry.size.height/500)
                                Text("Ou")
                                    .font(.system(size: geometry.size.height/40))
                                    .foregroundColor(Color("Color2"))
                                Color("Color2")
                                    .frame(width: geometry.size.height/10, height: geometry.size.height/500)
                            }
                            HStack {
                                Button(action: {
                                }) {
                                    Image("apple_logo")
                                        .resizable()
                                        .frame(width: geometry.size.height/30, height:  geometry.size.height/30)
                                        .padding()
                                }.background(colorWhite)
                                    .clipShape(Circle())
                                Button(action: {
                                    signIn.cekLoginGoogle { googleURL in
                                        if let googleURL = googleURL {
                                            openURL(url: googleURL)
                                        } else {
                                            print("Failed to retrieve Google URL")
                                        }
                                    }
                                }) {
                                    Image("google_logo")
                                        .resizable()
                                        .frame(width: geometry.size.height/30, height:  geometry.size.height/30)
                                        .padding()
                                }.background(colorWhite)
                                    .clipShape(Circle())
                                    .padding(.leading, 25)
                            }
                            Button(action: {
                            }) {
                                NavigationLink(
                                    destination: SignUpView().navigationBarHidden(true),
                                    label: {
                                        Text (LocalizedStringKey("SignInV5"))
                                            .font(.system(size: geometry.size.width/25))
                                            .fontWeight(.semibold)
                                            .foregroundColor(Color("Color4"))
                                            .padding(.bottom)
                                    }).navigationBarHidden(true)
                            }.padding(.top)
                        }
                    }.padding(.bottom, 30)
                    if signIn.isLoading {
                            LoaderComponent()
                    }
                }.onTapGesture {
                    UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                }
                
            }
        }.edgesIgnoringSafeArea(.bottom)
            .overlay(overlayView: BannerComponent.init(data: BannerComponent.BannerDataModel(title: LocalizedStringKey("SignInV6"), detail: LocalizedStringKey("SignInV7"), type: .error), show: $signIn.isWrong), show: $signIn.isWrong)
            .overlay(overlayView: BannerComponent.init(data: BannerComponent.BannerDataModel(title: LocalizedStringKey("SignInV6"), detail: LocalizedStringKey("SignInV8"), type: .error), show: $missingFields), show: $missingFields)
    }

    func openURL(url: URL) {
        Task {
            UIApplication.shared.windows.first?.rootViewController?.present(UIHostingController(rootView: WebView(url: url)), animated: true, completion: nil)
        }
    }
}

struct WebView: UIViewRepresentable {
    let url: URL

    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()
        webView.navigationDelegate = context.coordinator
        webView.load(URLRequest(url: url))
        return webView
    }

    func updateUIView(_ uiView: WKWebView, context: Context) {}

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    class Coordinator: NSObject, WKNavigationDelegate {
        var parent: WebView

        init(_ parent: WebView) {
            self.parent = parent
        }
    }
}

struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        SignInView()
            .environmentObject(SignIn())
    }
}
