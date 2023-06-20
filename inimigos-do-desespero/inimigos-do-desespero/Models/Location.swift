//
//  Location.swift
//  inimigos-do-desespero
//
//  Created by Marcela De Souza Goncalves on 13/10/22.
//

import Foundation

struct Location: Codable {
    let neighborhood: LocationDetails
    let city: LocationDetails
    let state: LocationDetails
    let addressLine: String
    let zipCode: String
    let country: LocationDetails
    
    enum CodingKeys: String, CodingKey {
        case neighborhood
        case city
        case state
        case addressLine = "address_line"
        case zipCode = "zip_code"
        case country
    }
}
