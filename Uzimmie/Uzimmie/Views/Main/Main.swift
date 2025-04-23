//
//  Main.swift
//  Uzimmie
//
//  Created by SEAN BLAKE on 3/7/24.
//

import SwiftUI

struct Main: View {
    @EnvironmentObject var authManager: AuthManager
    @StateObject var mainVM = MainViewModel()
    @State private var isActive = false
    @State private var selectedCategory: String = "All"
    
    var body: some View {
        NavigationStack {
                VStack {
                    NavigationLink(destination: Profile(), isActive: $isActive) {
                        EmptyView()
                    }
                    
                    // MARK: - Header
                    Header(action: {
                        // Action to the Profile page
                        // Action to signin to see the profile page
                        if authManager.isLoggedIn {
                            isActive = true
                        } else {
                            showSignInSheet = true
                        }    
                    },
                           headerTitle: "uzimmie",
                           subTitle: "From Bull Bay to Di Flippin World",
                           icon: "line.3.horizontal"
                    )
                    
                    //MARK: - Collection view
                    CollectionView()
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
                .background()
                .environment(\.colorScheme, .light)
            
        }
        .sheet(isPresented: $showSignInSheet) {
            SignIn()
        }
    }
}

#Preview {
    Main()
        .environmentObject(AuthManager())
}
