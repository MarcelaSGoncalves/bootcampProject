//
//  Product.swift
//  inimigos-do-desespero
//
//  Created by Marcela De Souza Goncalves on 13/10/22.
//

import Foundation

struct ProductDetails: Codable {
    let body: Body
}

struct Body: Codable {
    let id: String
    let title: String
    let price: Double
    let pictures: [Picture]
    let permalink: String
    let startTime: String
    let attributes: [Attribute]
    let location: Location
    let sellerId: Int
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case permalink
        case price
        case pictures
        case startTime = "start_time"
        case attributes
        case location
        case sellerId = "seller_id"
    }
}
