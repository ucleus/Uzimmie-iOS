//
//  Profile.swift
//  Uzimmie
//
//  Created by SEAN BLAKE on 3/7/24.
//

import SwiftUI

struct Profile: View {
    @Environment(\.dismiss) var goBck
    @EnvironmentObject var authManager: AuthManager
    @StateObject var vm = ProfileViewModel()
    
    var body: some View {
        VStack {
            if authManager.isLoggedIn {
                if let user = vm.user {
                    // print("User Loaded: \(user)")
                    ProfileView(user: user)
                } else {
                    ProgressView()
                    Text("Trying to Logon")
                        .font(.largeTitle)
                    
                    Button {
                        goBck.callAsFunction()
                    } label: {
                        Text("Go Back")
                    }
                    
                    Button {
                        vm.logOut()
                    } label: {
                        Text("log out")
                    }
                    
                }
            } else {
                SignIn()
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .padding()
        .background()
        .environment(\.colorScheme, .light)
        .navigationBarBackButtonHidden(true)
        .onAppear {
            vm.fetchUser()
        }
    }
    
    @ViewBuilder
    private func ProfileView(user: User) -> some View {
        VStack {
            // Header
            Header(
                action: {
                    goBck()
                },
                headerTitle: "profile",
                subTitle: "Hi \(user.firstName)",
                icon: "arrow.left"
            )
            
            Text("You are logged in.")
            
            // Log out button
            CustomSolidButton(
                action: { vm.logOut() },
                buttonTitle: "Log Out",
                foregroundColor: Color.white,
                backgroundColor: Color.black,
                icon: "rectangle.portrait.and.arrow.right"
            )
            
            Text("Member since: \(Date(timeIntervalSince1970: user.joined).formatted(date: .abbreviated, time: .shortened))")
                .font(.footnote)
        }
    }
}

#Preview {
    Profile.example
        .environmentObject(AuthManager())
}

extension Profile {
    static var example: Profile {
        let profile = Profile()
        // Configure your preview example if needed
        return profile
    }
}
