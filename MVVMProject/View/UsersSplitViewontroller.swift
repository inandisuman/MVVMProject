//
//  UsersSplitViewontroller.swift
//  MVVMProject
//
//  Created by Suman Nandi on 05/03/23.
//

import Foundation
import UIKit

class UsersSplitViewontroller: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Instantiate   view model
        let userListViewModel = UserListViewModel()
        // Bind view model using delegation
        userListViewModel.delegate = self
        // Fetch user list from service
        userListViewModel.getUserListFromService()
    }
}

extension UsersSplitViewontroller: UserListViewModelDelegate {
    func didReceiveUserListFromService(result: [User]?) {
        if let users = result {
            print("Display \(users.count) users on table view")
        } else {
            print("Nothing to display on table view")
        }
    }
}
