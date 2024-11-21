//
//  AuthManager.swift
//  Uzimmie
//
//  Created by SEAN BLAKE on 3/13/24.
//


import FirebaseAuth
import Foundation

class AuthManager1: ObservableObject {
    @Published var errorMessage = ""
    @Published var email = ""
    @Published var password = ""
    @Published var address = ""
    @Published var add2 = ""
    @Published var city = ""
    @Published var state = ""
    @Published var zip = ""
    @Published var phoneNumber = ""
    
    static let shared = AuthManager() // Singleton instance
    
    init() {}
 
    func signIn() {
        guard validate() else {
            return
        }
        
        // Try to login
        Auth.auth().signIn(withEmail: email, password: password)
    }
    
    // Sign up method
    func signUp(email: String, password: String) {
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            if let error = error {
                print("Failed to sign up with error: \(error.localizedDescription)")
                return
            }
            print("You are signed up and logged in")
        }
    }
    
    // Sign out method
    func signOut() {
        do {
            try Auth.auth().signOut()
            print("You are logged out")
        } catch let signOutError as NSError {
            print("Error signing out: %@", signOutError)
        }
    }
    
    // Validate the text fields
    private func validate() -> Bool {
        errorMessage = ""
        guard !email.trimmingCharacters(in: .whitespaces).isEmpty,
                !password.trimmingCharacters(in: .whitespaces).isEmpty else {
            errorMessage = "Please fill in all fields."
            return false
        }
        
        // to validate the email field
        guard email.contains("@") && email.contains(".") else {
            errorMessage = "Please enter a valid email."
            return false
        }
        return true
    }
}
