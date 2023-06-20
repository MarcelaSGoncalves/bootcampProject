//
//  ApiDataSource.swift
//  inimigos-do-desespero
//
//  Created by Marcela De Souza Goncalves on 18/10/22.
//

import Foundation

protocol DataSourceProtocol {
    func fetchProducts(category: String, completion: @escaping (Result<Products, ApiError>) -> Void)
    func fetchProductDetails(with productId: String, completion: @escaping (Result<[ProductDetails], ApiError>) -> Void)
}

final class ApiDataSource: DataSourceProtocol { 
    static var shared = ApiDataSource()
    private let environment = Environment()
    
    func fetchProducts(category: String, completion: @escaping (Result<Products, ApiError>) -> Void) {
        let urlBase = environment.urlBase
        let path = environment.pathGetCategories
        let stringUrl = urlBase + path + category
        let urlcorrect = URL(string: stringUrl)
        
        guard let url = urlcorrect else {
            completion(.failure(.NetworkInvalidUrl))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("Bearer \(self.environment.token)", forHTTPHeaderField: "Authorization")
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let _ = error {
                completion(.failure(.ServiceUnavailable))
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completion(.failure(.NetworkResponseError))
                return
            }
            
            guard let data = data else {
                completion(.failure(.NetworkInvalidData))
                return
            }
            do{
                let decoder = JSONDecoder()
                let categoryDecoded = try decoder.decode(Products.self, from: data)
                completion(.success(categoryDecoded))
                return
            }
            catch{
                completion(.failure(.NetworkInvalidData))
            }
        }
        task.resume()
    }
    
    func fetchProductDetails(with productId: String, completion: @escaping (Result<[ProductDetails], ApiError>) -> Void) {
        let urlBase = environment.urlBase
        let path = environment.pathGetProdutsDetails
        let pathSuffix = environment.pathGetProdutsDetailsSuffix
        let stringUrl = urlBase + path + productId + pathSuffix
        
        guard let url = URL(string: stringUrl) else {
            completion(.failure(.NetworkInvalidUrl))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("Bearer \(self.environment.token)", forHTTPHeaderField: "Authorization")
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let _ = error {
                completion(.failure(.ServiceUnavailable))
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completion(.failure(.NetworkResponseError))
                return
            }
            
            guard let data = data else {
                completion(.failure(.NetworkInvalidData))
                return
            }
            do{
                let decoder = JSONDecoder()
                let categoryDecoded = try decoder.decode([ProductDetails].self, from: data)
                completion(.success((categoryDecoded)))
                return
            }
            catch{
                completion(.failure(.NetworkInvalidData))
            }
        }
        task.resume()
    }   
}
