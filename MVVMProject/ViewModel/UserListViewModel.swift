//
//  UserListViewModel.swift
//  MVVMProject
//
//  Created by Suman Nandi on 05/03/23.
//

import Foundation

class UserListViewModel {
    
    func getUserListFromService() {
        
        let url = URL(string: "https://jsonplaceholder.typicode.com/users")

        NetworkManager.shared.performAPICall(url: url!, httpMethod: "GET") { (result: Result<[User], Error>) in
            switch result {
            case .success(let users):
                print("Users from API - \(users)")
            case .failure(let error):
                print("Failed due to - \(error.localizedDescription)")
            }
        }
    }
}
