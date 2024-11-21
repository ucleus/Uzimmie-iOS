//
//  UzimmieApp.swift
//  Uzimmie
//
//  Created by SEAN BLAKE on 3/7/24.
//


import SwiftUI
import Firebase

@main
struct UzimmieApp: App {
    @EnvironmentObject var cartManager: CartManager
    @StateObject var profileVM = ProfileViewModel()
    
    init() {
        FirebaseApp.configure()
        print("Firebase setup right")
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(CartManager())
                .environmentObject(AuthManager())
                .environmentObject(profileVM)
        }
    }
}
