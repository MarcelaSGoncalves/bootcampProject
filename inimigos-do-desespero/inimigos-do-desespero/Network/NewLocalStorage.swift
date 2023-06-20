//
//  NewLocalStorage.swift
//  inimigos-do-desespero
//
//  Created by Luciano Da Silva Berchon on 17/10/22.
//

import Foundation
import MLLocalStorage

final class NewLocalStorage: NewNetworkProtocol {
    func get<T>(with key: String?, completion: @escaping (Result<[T], Error>) -> Void)  where T: Codable {
        let id = MLSLocalStorageTeamCatalog.productsPropertyId
        let team = MLSLocalStorageTeamCatalog.localStorageTeamId
        
        do {
            let transaction = MLSStorageProvider.shared.kvsTransaction(id: id, team: team)
            let transactionSuccess = try transaction.get()
            let response = transactionSuccess.get(defaultValue: [T]())
            let responseSuccess = try response.get()
            completion(.success(responseSuccess))
        } catch {
            completion(.failure(NewLocalStorageError.NetworkSetDataFailure))
        }
    }
    
    func set<T>(key: String?, value: [T], completion: @escaping (Result<[T], Error>) -> Void) where T: Codable {
        let id = MLSLocalStorageTeamCatalog.productsPropertyId
        let team = MLSLocalStorageTeamCatalog.localStorageTeamId
        
        do {
            let transaction = MLSStorageProvider.shared.kvsTransaction(id: id, team: team)
            let transactionSuccess = try transaction.get()
            let response = transactionSuccess.put(value: value)
            let responseSuccess = try response.get()
            completion(.success(responseSuccess))
        } catch {
            completion(.failure(NewLocalStorageError.NetworkSetDataFailure))
        }
    }
}
