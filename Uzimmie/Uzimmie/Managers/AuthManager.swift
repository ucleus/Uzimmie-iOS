//
//  AuthManager.swift
//  Uzimmie
//
//  Created by SEAN BLAKE on 4/8/24.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

class AuthManager: ObservableObject {
    @Published var errorMessage = "Try again, something is wrong"
    @Published var email = ""
    @Published var password = ""
    @Published var address = ""
    @Published var add2 = ""
    @Published var city = ""
    @Published var state = ""
    @Published var zip = ""
    @Published var phoneNumber = ""
    @Published var isLoggedIn: Bool = false
    
    private var db = Firestore.firestore()
    
    init() {
        // Check if the user is already logged in
        if Auth.auth().currentUser != nil {
            isLoggedIn = true
        }
    }
    
    func createUserProfile() {
        guard let currentUser = Auth.auth().currentUser else { return }
        let userId = currentUser.uid
        
        // Define user profile data
        let userProfile = [
            "firstName": "New", // Set initial or default values
            "lastName": "User",
            "email": currentUser.email ?? "",
            "joined": Timestamp(date: Date()) // Using Firebase's Timestamp
        ] as [String : Any]
        
        // Set the user profile in Firestore using the uid as the document ID
        db.collection("user").document(userId).setData(userProfile) { error in
            if let error = error {
                print("Error creating user profile: \(error.localizedDescription)")
            } else {
                print("User profile successfully created")
            }
        }
    }
    
    func signIn(email: String, password: String, completion: @escaping (Result<Void, Error>) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] result, error in
            if let error = error {
                completion(.failure(error))
            } else {
                self?.isLoggedIn = true
                completion(.success(()))
            }
        }
    }
    
    func signOut() {
        do {
            try Auth.auth().signOut()
            isLoggedIn = false
        } catch {
            print("Error signing out: \(error.localizedDescription)")
        }
    }
}
