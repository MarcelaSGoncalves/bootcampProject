//
//  NewNetworkProtocol.swift
//  inimigos-do-desespero
//
//  Created by Luciano Da Silva Berchon on 17/10/22.
//

import Foundation

protocol NewNetworkProtocol {
    func get<T>(with key: String?, completion: @escaping (Result<[T], Error>) -> Void)  where T: Codable
    func set<T>(key: String?, value: [T], completion: @escaping (Result<[T], Error>) -> Void)  where T: Codable
}
