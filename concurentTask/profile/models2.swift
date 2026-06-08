//
//  models.swift
//  omartask2
//
//  Created by Omar on 07/06/2026.
//

import Foundation
// MARK: - Root User
struct User: Decodable {
    let id: Int
    let firstName: String
    let lastName: String
    let email: String
    let role: String
    let address : Address
    let company: Company
  
}

// MARK: - Address
struct Address: Decodable {
    let city: String
    let country: String
}

// MARK: - Company
struct Company: Decodable {
    let department: String
}
