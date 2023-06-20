//
//  NewViewModel.swift
//  inimigos-do-desespero
//
//  Created by Luciano Da Silva Berchon on 18/10/22.
//

import Foundation
import UIKit

final class NewViewModel {
    // MARK: - Properties
    private let service: NewDataSource
    private let localStorage = NewLocalStorage()
    private let apiService = ApiDataSource()
    
    private var localStorageData: [Product] = [] {
        didSet {
            setFavorites()
        }
    }
    private var favorites: [Bool] = []
    
    private var apiData: Products = {
        return Products(results: [])
    }() {
        didSet {
            setFavorites()
        }
    }
    
    private var apiDataNotFiltered: Products = {
        return Products(results: [])
    }()
    
    private var apiDetails: ProductDetails?
    
    var delegate: NewViewControllerDelegateProtocol?
    var delegateDetails: NewViewControllerDelegateProtocol?
    
    // MARK: - Initializers
    init(with category: Category) {
        service = NewDataSource(network: localStorage)
        getLocalStorageData()
    }
    
    // MARK: - Methods
    func filterApiData(with text: String) {
        if text.isEmpty {
            apiData = apiDataNotFiltered
        } else {
            apiData.results = apiDataNotFiltered.results.filter({ $0.title.lowercased().contains(text.lowercased()) })
        }
        self.delegate?.reloadData(isLoadingHidden: true)
    }
    
    func resetApiData() {
        apiData = Products(results: [])
    }
    
    func isFavorite(at index: Int) -> Bool {
        return favorites[index]
    }
    
    func countApiData() -> Int {
        return apiData.results.count
    }
    
    func countLocalStorage() -> Int {
        return localStorageData.count
    }
    
    func getApiDataProduct(at index: Int) -> Product {
        return apiData.results[index]
    }
    
    func getApiDataProduct() -> ProductDetails? {
        return apiDetails
    }
    
    func getLocalStorageDataProduct(at index: Int) -> Product {
        return localStorageData[index]
    }
    
    func insertInLocalStorage(new product: Product) {
        localStorageData.append(product)
        setLocalStorageData(with: localStorageData)
    }
    
    func removeInLocalStorage(the product: Product) {
        if let index = localStorageData.firstIndex(where: { $0.id == product.id}) {
            localStorageData.remove(at: index)
            setLocalStorageData(with: localStorageData)
        }
    }
    
    func setFavorites() {
        favorites = apiData.results.map({ product in
            return localStorageData.contains(where: { $0.id == product.id })
        })
    }
    
    private func getLocalStorageData() {
        service.getData() { (result: Result<[Product], Error>) in
            switch result {
            case .success(let products):
                self.localStorageData = products
                self.delegate?.reloadData(isLoadingHidden: true)
            case .failure( _):
                self.delegate?.showMessage(with: "Falha ao obter seus produtos favoritos.", type: .error)
            }
        }
    }
    
    private func setLocalStorageData(with products: [Product]) {
        service.setData(value: localStorageData) { (result: Result<[Product], Error>) in
            switch result {
            case .success( _):
                self.getLocalStorageData()
            case .failure( _):
                let message = "Falha ao favoritar esse produto."
                self.delegate?.showMessage(with: message, type: .error)
            }
        }
    }
    
    func fetchProducts(category: String) {
        var fetchFailure: ApiError?
        let group = DispatchGroup()
        group.enter()
        self.apiService.fetchProducts(category: category) { [self] result in
            switch result {
            case .success(let products):
                apiData = products
                apiDataNotFiltered = products
            case .failure(let error):
                fetchFailure = error
            }
            group.leave()
        }
        group.notify(queue: .main) {
            self.delegate?.reloadData(isLoadingHidden: true)
            if let error = fetchFailure {
                self.delegate?.showMessage(with: error.rawValue, type: .error)
            }
        }
    }
    
    func fetchProductDetails(with productId: String) {
        var fetchFailure: ApiError?
        let group = DispatchGroup()
        group.enter()
        self.apiService.fetchProductDetails(with: productId) { [self] result in
            switch result {
            case .success(let productDetails):
                apiDetails = productDetails.first
            case .failure(let error):
                fetchFailure = error
            }
            group.leave()
        }
        group.notify(queue: .main) {
            if let error = fetchFailure {
                self.delegate?.showMessage(with: error.rawValue, type: .error)
                self.delegateDetails?.reloadData(isLoadingHidden: false)
                return
            }
            self.delegateDetails?.reloadData(isLoadingHidden: true)
        }
    }
}
