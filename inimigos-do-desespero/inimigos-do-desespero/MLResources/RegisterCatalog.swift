//
//  RegisterCatalog.swift
//  inimigos-do-desespero
//
//  Created by Marcela De Souza Goncalves on 11/10/22.
//

import Foundation
import MLLocalStorage

final class RegisterCatalog {
    static func register() {
        do {
            let appCatalog = try MLSLocalStorageApplicationCatalog(teamCalatogs: [MLSLocalStorageTeamCatalog()])
            let config = MLSStorageProviderConfiguration(catalog: appCatalog, kvsFactory: MLSKVSStorageFactoryDefault(), debuggable: true)
            _ = MLSStorageProvider.shared.initialize(configuration: config)
        } catch {
            print("ERRO AO REGISTRAR CATALOGO")
        }
    }
}
