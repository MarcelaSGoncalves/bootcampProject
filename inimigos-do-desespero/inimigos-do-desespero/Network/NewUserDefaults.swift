//
//  NewUserDefaults.swift
//  inimigos-do-desespero
//
//  Created by Luciano Da Silva Berchon on 17/10/22.
//

import Foundation

final class NewUserDefaults: NewNetworkProtocol {
    func get<T>(with key: String? = nil, completion: @escaping (Result<[T], Error>) -> Void)  where T: Codable {
        guard let key = key else {
            completion(.failure(NewLocalStorageError.NetworkInvalidKey))
            return
        }
        guard let data = UserDefaults.standard.data(forKey: key) else {
            completion(.failure(NewLocalStorageError.NetworkGetDataFailure))
            return
        }
        do {
            let decoder = JSONDecoder()
            let dataDecoded = try decoder.decode([T].self, from: data)
            completion(.success(dataDecoded))
        } catch {
            completion(.failure(NewLocalStorageError.NetworkDataDecodedFailure))
        }
    }
    
    func set<T>(key: String? = nil, value: [T], completion: @escaping (Result<[T], Error>) -> Void) where T: Codable {
        guard let key = key else {
            completion(.failure(NewLocalStorageError.NetworkInvalidKey))
            return
        }
        do {
            let encoder = JSONEncoder()
            let data = try encoder.encode(value)
            UserDefaults.standard.set(data, forKey: key)
            completion(.success(value))
        } catch {
            completion(.failure(NewLocalStorageError.NetworkSetDataFailure))
        }
    }
}
