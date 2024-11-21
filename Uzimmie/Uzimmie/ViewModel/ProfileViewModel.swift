//
//  ProfileViewModel.swift
//  Uzimmie
//
//  Created by SEAN BLAKE on 3/15/24.
//

import FirebaseAuth
import FirebaseFirestore
import Foundation

class ProfileViewModel: ObservableObject {
    @Published var user: User?
    
    private var db = Firestore.firestore()
    
    func fetchUser() {
        guard let userId = Auth.auth().currentUser?.uid else {
            print("User not authenticated")
            return
        }
        
        db.collection("user").document(userId).getDocument { [weak self] documentSnapshot, error in
            if let error = error {
                print("Error fetching user: \(error.localizedDescription)")
                return
            }
            
            guard let snapshot = documentSnapshot, snapshot.exists else {
                print("User document does not exist for current logged in user with ID: \(userId)")
                return
            }
            
            guard let data = snapshot.data() else {
                print("Data is nil for existing document for user with ID: \(userId)")
                return
            }
            
            print("User data: \(data)")
            
            DispatchQueue.main.async {
                self?.user = User(
                    id: userId,
                    firstName: data["firstName"] as? String ?? "",
                    lastName: data["last"] as? String ?? "",
                    email: data["email"] as? String ?? "",
                    joined: (data["joined"] as? Timestamp)?.dateValue().timeIntervalSince1970 ?? 0
                )
            }
        }
    }
    
    func logOut() {
        do {
            try Auth.auth().signOut()
            user = nil // Clear the user data on logout
        } catch {
            print("Error signing out: \(error.localizedDescription)")
        }
    }
    
    // Assuming 'joined' field is a String representing a date, parse it to a TimeInterval or Date as needed
    private func parseJoinedDate(joinedString: String?) -> TimeInterval {
        guard let joinedString = joinedString else { return 0 }
        // Implement the date parsing here, returning a TimeInterval
        // This is placeholder logic, update with actual date parsing as required by your application
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM d, yyyy 'at' h:mm:ss a 'UTC'Z"
        if let date = formatter.date(from: joinedString) {
            return date.timeIntervalSince1970
        } else {
            return 0
        }
    }
}
