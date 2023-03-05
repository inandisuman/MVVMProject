//
//  UserModel.swift
//  MVVMProject
//
//  Created by Suman Nandi on 05/03/23.
//

import Foundation

/// User object from the API
struct User: Codable {
    let id: Int
    let name: String
    let username: String
    let email: String
    let address: Address
    let phone: String
    let website: String
    let company: Company
}

struct Address: Codable {
    let street: String
    let suite: String
    let city: String
    let zipcode: String
    let geo: Coordinate
}

struct Coordinate: Codable {
    let latitude: String
    let longitude: String
    
    enum CodingKeys: String, CodingKey {
        case latitude = "lat"
        case longitude = "lng"
    }
}

struct Company: Codable {
    let name: String
    let catchPhrase: String
    let bs: String
}
