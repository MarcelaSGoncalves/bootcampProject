//
//  NewDataSource.swift
//  inimigos-do-desespero
//
//  Created by Luciano Da Silva Berchon on 17/10/22.
//

import Foundation

final class NewDataSource {
    private let network: NewNetworkProtocol
    
    init(network: NewNetworkProtocol) {
        self.network = network
    }
    
    func getData<T>(with key: String? = nil, completion: @escaping (Result<[T], Error>) -> Void) where T: Codable {
        network.get(with: key) { (result: Result<[T], Error>) in
            switch result {
            case .success(let datas):
                completion(.success(datas))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func setData<T>(key: String? = nil, value: [T], completion: @escaping (Result<[T], Error>) -> Void) where T: Codable {
        network.set(key: key, value: value) { (result: Result<[T], Error>) in
            switch result {
            case .success(let data):
                completion(.success(data))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
