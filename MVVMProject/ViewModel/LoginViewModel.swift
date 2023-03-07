//
//  LoginViewModel.swift
//  MVVMProject
//
//  Created by Suman Nandi on 05/03/23.
//

import Foundation
import UIKit

class RegistrationViewModel {
    
    let username: String
    let password: String
    let country: String

    init(username: String, password: String, country: String) {
        self.username = username
        self.password = password
        self.country = country
    }
    
    /// Register user to Core Data
        /// - Returns: A bool value to deplit if registration is successful or not
    func registerUser() -> Bool {
        // Create in Core Data
        return PersistentStoreManager.shared.createData(for: NewUser(username: username, password: password, country: country))
    }
}

class LoginViewModel {
    
    /// Authenticate user from Core Data
        /// - Parameters:
        ///   - username: Username entered by user
        ///   - password: Password entered by user
        /// - Returns: A bool value to deplit if login is successful or not
    func authenticateUser(username: String, password: String) -> Bool {
        if let loggedinUsers = PersistentStoreManager.shared.readData() {
            return !loggedinUsers.filter { $0.username == username && $0.password == password }.isEmpty
        }
        return false
    }
}
