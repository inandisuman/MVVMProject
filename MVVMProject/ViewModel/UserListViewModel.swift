//
//  UserListViewModel.swift
//  MVVMProject
//
//  Created by Suman Nandi on 05/03/23.
//

import Foundation

protocol UserListViewModelDelegate: NSObject {
    func didReceiveUserListFromService(result: [User]?)
}

class UserListViewModel {
    
    weak var delegate: UserListViewModelDelegate?
        
    func getUserListFromService() {

        NetworkManager.shared.performAPICall(url: URL(string: K.APIEndpoints.getUserList)!, httpMethod: "GET") { (result: Result<[User], Error>) in
            switch result {
            case .success(let users):
                self.delegate?.didReceiveUserListFromService(result: users)
            case .failure(let error):
                print("Failed due to - \(error.localizedDescription)")
                self.delegate?.didReceiveUserListFromService(result: nil)
            }
        }
    }
}
