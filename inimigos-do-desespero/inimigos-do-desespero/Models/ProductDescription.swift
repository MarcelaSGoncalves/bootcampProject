//
//  ProductDescription.swift
//  inimigos-do-desespero
//
//  Created by Marcela De Souza Goncalves on 13/10/22.
//

import Foundation

struct ProductDescription: Codable {
    let plainText: String
    
    enum CodingKeys: String, CodingKey {
        case plainText = "plain_text"
    }
}
