//
//  Environment.swift
//  inimigos-do-desespero
//
//  Created by Marcela De Souza Goncalves on 18/10/22.
//

import Foundation

class Environment {
    let urlBase: String = "https://api.mercadolibre.com"
    let pathGetToken: String = "/oauth/token"
    let pathGetCategories: String = "/sites/MLB/search?q="
    let pathGetProdutsDetails: String = "/items?ids="
    let pathGetProdutsDetailsSuffix: String = "&attributes=id,title,seller_id,permalink,price,pictures,start_time,attributes,location"
    let token: String = "APP_USR-7169050861406625-102608-037c4ec35c63d1e953aebdeaab158c03-45988325"
}
