//
//  MLSLocalStorageTeamCatalog.swift
//  inimigos-do-desespero
//
//  Created by Marcela De Souza Goncalves on 11/10/22.
//

import Foundation
import MLLocalStorage

class MLSLocalStorageTeamCatalog: MLSTeamCatalogDefault {
    public static let localStorageTeamId = MLSTeamId("CatalogInimigos")
    public static let productsPropertyId = MLSPropertyId("ProductsCatalog")
    
    convenience init() {
        let team = MLSLocalStorageTeamCatalog.localStorageTeamId
        self.init(teamId: team, definitions: [:])
        
        let teamDataDefinitions = [
            Self.productsPropertyId: self.dataDefinition(id: Self.productsPropertyId, description: "Products Local Storage", _: Product.self)
        ]
        self.definitions = teamDataDefinitions
    }
    
    func dataDefinition<T>(id: MLSPropertyId, description: String, _: T.Type) -> MLSDataDefinition where T: Codable {
        return MLSDataDefinition(
            id: id,
            team: Self.localStorageTeamId,
            description: description,
            storageType: MLSStorageType.KVS,
            size: 1000,
            ttl: MLSTTLType(),
            scope: MLSScopeType.APP,
            secure: MLSSecurityType.Unsecure,
            dataType: [T]()
        )
    }
}
