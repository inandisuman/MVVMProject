//
//  UsersSplitViewontroller.swift
//  MVVMProject
//
//  Created by Suman Nandi on 05/03/23.
//

import Foundation
import UIKit

class UsersSplitViewontroller: UITableViewController {
    
    var userList: [User]?
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Instantiate   view model
        let userListViewModel = UserListViewModel()
        // Bind view model using delegation
        userListViewModel.delegate = self
        // Fetch user list from service
        userListViewModel.getUserListFromService()
    }
    
    // MARK: - TableView Source and Delegates
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userList?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "displayUserMetadataCell", for: indexPath)
        if let userList = userList {
            cell.textLabel?.text = userList[indexPath.row].name
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let sb = UIStoryboard(name: "Main", bundle: nil)
        if let detailVC = sb.instantiateViewController(withIdentifier:"UserDetailsVC") as? UserDetailsViewController {
            // Pass data to details view
            detailVC.user = userList?[indexPath.row]
            splitViewController?.showDetailViewController(detailVC, sender: nil)
        }
    }
}

// MARK: - Extensions

extension UsersSplitViewontroller: UserListViewModelDelegate {
    func didReceiveUserListFromService(result: [User]?) {
        userList = result
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}
