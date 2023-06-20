//
//  Pictures.swift
//  inimigos-do-desespero
//
//  Created by Marcela De Souza Goncalves on 13/10/22.
//

import Foundation

struct Picture: Codable {
    let secureURL: String

    enum CodingKeys: String, CodingKey {
        case secureURL = "secure_url"
    }
}
