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
        let url = URL(string: "https://jsonplaceholder.typicode.com/users")
        let networkManager = NetworkManager()

        networkManager.performAPICall(url: url!, httpMethod: "GET") { (result: Result<[User], Error>) in
            switch result {
            case .success(let users):
                print("Users from API - \(users)")
            case .failure(let error):
                print("Failed due to - \(error.localizedDescription)")
            }
        }
    }
}
