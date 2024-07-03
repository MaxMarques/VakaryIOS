//
//  SignUpView.swift
//  Vakary
//
//  Created by Marques on 06/09/2022.
//

import SwiftUIFontIcon
import SwiftUI

struct SignUpView: View {
    @StateObject var accountCreation = AccountCreation()
    var body: some View {
        ZStack {
            if accountCreation.pageNumber == 0 {
                PhoneNumberView()
                    .environmentObject(accountCreation)
            } else if accountCreation.pageNumber == 1 {
                MailView()
                    .environmentObject(accountCreation)
            } else if accountCreation.pageNumber == 2 {
                StartView()
            }
//            else if accountCreation.pageNumber == 3 {
//                VerificationCodeView()
//                    .environmentObject(accountCreation)
//            }
            else if accountCreation.pageNumber == 3 {
                PasswordView()
                    .environmentObject(accountCreation)
            } else if accountCreation.pageNumber == 4 {
                CreateProfilView()
                    .environmentObject(accountCreation)
                    .environmentObject(SignUp())
            }
        }
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}
