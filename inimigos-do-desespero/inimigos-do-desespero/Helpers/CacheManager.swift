//
//  CacheManager.swift
//  inimigos-do-desespero
//
//  Created by Marcela De Souza Goncalves on 21/10/22.
//

import Foundation

class CacheManager {
    static var imageDictionary = [String:Data]()

    static func saveData(_ url: String,_ imageData: Data) {
        imageDictionary[url] = imageData
    }
    
    static func retrieveData(_ url: String) -> Data? {
        return imageDictionary[url]
    }
}
