//
//  Product.swift
//  inimigos-do-desespero
//
//  Created by Luciano Da Silva Berchon on 17/10/22.
//

import Foundation

struct Product: Codable {
    let id: String
    let title: String
    let price: Double
    let thumbnail: String
    let location: Location
    let attributes: [Attribute]
}
