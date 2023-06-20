//
//  SellerInformation.swift
//  inimigos-do-desespero
//
//  Created by Marcela De Souza Goncalves on 13/10/22.
//

import Foundation

struct SellerInformation: Codable {
    let id: String
    let nickName: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case nickName = "nickname"
    }
}
