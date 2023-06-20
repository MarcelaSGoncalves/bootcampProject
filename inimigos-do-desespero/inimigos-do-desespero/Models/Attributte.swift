//
//  Attributte.swift
//  inimigos-do-desespero
//
//  Created by Marcela De Souza Goncalves on 13/10/22.
//

import Foundation

struct Attribute: Codable {
    let id: String
    let valueName: String
    let name: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case valueName = "value_name"
    }
}
