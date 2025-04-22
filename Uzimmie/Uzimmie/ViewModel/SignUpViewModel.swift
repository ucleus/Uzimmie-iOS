//
//  SignUpViewModel.swift
//  Uzimmie
//
//  Created by SEAN BLAKE on 3/15/24.
//

import FirebaseFirestore
import FirebaseAuth
import Foundation

class SignUpViewModel: ObservableObject {
    @Published var firstName = ""
    @Published var lastName = ""
    @Published var email = ""
    @Published var password = ""
    
    init() {}
    
    func signUp() {
        guard validate() else {
            return
        }
        
        Auth.auth().createUser(withEmail: email, password: password) { [ weak self ] result, error in
            guard let userID = result?.user.uid else {
                return
            }
            self?.insterUserRecord(id: userID)
        }
    }
    
    private func insterUserRecord(id: String) {
        let newUser = User(id: id,
                           firstName: firstName,
                           lastName: lastName, 
                           email: email,
                           joined: Date().timeIntervalSince1970)
        
        let db = Firestore.firestore()
        
        let userData: [String: Any] = [
            "id": newUser.id,
            "firstName": newUser.firstName,
            "lastName": newUser.lastName,
            "email": newUser.email,
            "joined": newUser.joined
        ]
        
        db.collection("user")
            .document(id)
            .setData(userData)
    }
    
    // Validate
    private func validate() -> Bool {
        guard !firstName.trimmingCharacters(in: .whitespaces).isEmpty,
              !lastName.trimmingCharacters(in: .whitespaces).isEmpty,
              !email.trimmingCharacters(in: .whitespaces).isEmpty,
              !password.trimmingCharacters(in: .whitespaces).isEmpty else {
            return false
        }
        
        guard email.contains("@") && email.contains(".") else {
            return false
        }
        
        guard password.count >= 8 else {
            return false
        }
        
        return true
    }
}
