//
//  ProfileViewModel.swift
//  NONTON ID
//
//  Created by Garry on 24/07/22.
//

import Combine
import SwiftUI
import Firebase

struct CustomUser: Identifiable, Equatable {
    var id: String = ""
    var name: String = ""
}

struct Metadata: Codable {
    var updatedAt: Date?
    var createdAt: Date?
}

struct Response: Identifiable, Equatable, Codable {
    var id: String = UUID().uuidString
    var meta: Metadata?
    var data: User?
    
    static func == (lhs: Response, rhs: Response) -> Bool {
        lhs.id == rhs.id
    }
}

final class ProfileViewModel: ObservableObject {
    
    @AppStorage("language") var language = NONTON_ID.LocalizationService.shared.language
    @AppStorage("loginStatus") var loginStatus = false
    @AppStorage("isDarkMode") var isDarkMode = false
    @Published var email = Auth.auth().currentUser?.email.orEmpty()
    @Published var username = ""
    @Published var isError = false
    @Published var errorMessage = ""
    @Published var showAlert = false
    
    @Published var user: DataState<User> = .hasData(User(id: UUID().uuidString, email: "", username: ""))
    @Published var anotherUser: DataState<CustomUser> = .hasData(.init())
    @Published var listUser: DataState<[User]> = .hasData([.init(id: UUID().uuidString), .init(id: UUID().uuidString), .init(id: UUID().uuidString)])
    
    @Published var userWithMeta: DataState<Response> = .hasData(Response(meta: .init(), data: .init(id: UUID().uuidString, email: "", username: "")))
    
    func showingAlert() {
        showAlert = true
    }
    
    func logOut() {
        try? Auth.auth().signOut()
        withAnimation {
            loginStatus = false
        }
        
        language = Language.english_us
    }
    
    func fetchUserData() {
        guard let uid = Auth.auth().currentUser?.uid else {
            self.errorMessage = "Could not find Firebase uid."
            return
        }
        
        Firestore.firestore().collection("users")
            .document(uid)
            .getDocument { snapshot, error in
                if let error = error {
                    self.isError = true
                    self.errorMessage = error.localizedDescription
                    print(self.errorMessage)
                    return
                }
                
                guard let data = snapshot?.data() else { return }
                
                DispatchQueue.main.async { [weak self] in
                    self?.username = data["username"] as? String ?? ""
                    self?.email = data["email"] as? String ?? ""
                }
            }
    }
    
    func changeUsername() {
        guard let uid = Auth.auth().currentUser?.uid else {
            self.errorMessage = "Could not find Firebase uid."
            return
        }
        
        let userData = User(id: uid, email: self.email, username: self.username).toJSON()
        
        Firestore.firestore().collection("users")
            .document(uid)
            .setData(userData) { error in
                if let error = error {
                    self.isError = true
                    self.errorMessage = error.localizedDescription
                    print(self.errorMessage)
                    return
                }

                self.isError = false
                self.errorMessage = "Successfully store user data"
                print(self.errorMessage)
            }
    }
}
