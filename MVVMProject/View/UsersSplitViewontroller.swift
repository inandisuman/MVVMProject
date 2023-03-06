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
        // Do any additional setup after loading the view.
        let userListViewModel = UserListViewModel()
        userListViewModel.getUserListFromService()
    }
}
