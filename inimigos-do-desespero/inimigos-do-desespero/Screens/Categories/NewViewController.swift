//
//  ViewControllerBase.swift
//  inimigos-do-desespero
//
//  Created by Luciano Da Silva Berchon on 17/10/22.
//

import Foundation
import UIKit
import AndesUI

final class NewViewController: UIViewController {
    // MARK: - Screen Objects
    private lazy var newView: NewView = {
        let view = NewView(category: category, delegateTable: self, dataSourceTable: self)
        return view
    }()
    
    private lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.sizeToFit()
        searchBar.searchTextField.layer.cornerRadius = 36 / 2
        searchBar.searchTextField.layer.masksToBounds = true
        searchBar.placeholder = "Buscar em Mercado livre"
        searchBar.searchTextField.backgroundColor = .white
        searchBar.delegate = self
        return searchBar
    }()
    
    // MARK: - Properties
    private var viewModel: NewViewModel
    private let cellIdentifier = "\(NewTableViewCell.self)"
    private let category: Category
    
    // MARK: - Initializer
    init(with viewModel: NewViewModel, for category: Category) {
        self.category = category
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        viewModel.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life cycle methods
    override func viewWillAppear(_ animated: Bool) {
        setupNavigationBar()
        viewModel.resetApiData()
        reloadData(isLoadingHidden: true)
        if category != .favorite {
            newView.loadingStackView(isHidden: false)
            viewModel.fetchProducts(category: category.rawValue)
        }
    }
    
    override func loadView() {
        view = newView
    }
    
    // MARK: - Methods
    @objc private func cartButtonAction() {
        Message.show(with: "Funcionalidade não implementada", type: .neutral)
    }
    
    private func setupNavigationBar() {
        let image = UIImage(systemName: "cart")
        let cartButton = UIBarButtonItem(image: image, style: .done, target: self, action: #selector(cartButtonAction))
        cartButton.tintColor = .black

        navigationItem.titleView = searchBar
        navigationItem.rightBarButtonItem = cartButton
        navigationItem.backButtonTitle = ""
    }
    
    private func getProduct(at index: Int) -> Product {
        var product: Product
        switch category {
        case .car, .cycle, .truck, .property:
            product = viewModel.getApiDataProduct(at: index)
        case .favorite:
            product = viewModel.getLocalStorageDataProduct(at: index)
        }
        return product
    }
}

// MARK: - UISearchBarDelegate
extension NewViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.filterApiData(with: searchText)
    }
}

//MARK: - NewTableViewCellDelegateProtocol
extension NewViewController: NewTableViewCellDelegateProtocol {
    func favoriteProduct(with index: Int) {
        let product = getProduct(at: index)
        if category == .favorite {
            viewModel.removeInLocalStorage(the: product)
            reloadData(isLoadingHidden: true)
            return
        }
        let isFavorite = viewModel.isFavorite(at: index)
        if isFavorite {
            viewModel.removeInLocalStorage(the: product)
        } else {
            viewModel.insertInLocalStorage(new: product)
        }
        reloadData(isLoadingHidden: true)
    }
}

// MARK: - Table view data source
extension NewViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var numberOfElements: Int
        switch category {
        case .car, .cycle, .truck, .property:
            numberOfElements = viewModel.countApiData()
        case .favorite:
            numberOfElements = viewModel.countLocalStorage()
        }
        
        numberOfElements == 0
            ? newView.setIsHiddenFeedbackView(isHidden: false)
            : newView.setIsHiddenFeedbackView(isHidden: true)
        return numberOfElements
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = newView.tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? NewTableViewCell else { return UITableViewCell () }
        cell.delegate = self
        let index = indexPath.row
        let product = getProduct(at: index)
        switch category {
        case .car, .cycle, .truck:
            let isFavorite = viewModel.isFavorite(at: index)
            cell.setCell(with: product, in: index, isFavorite: isFavorite, isHouse: false)
        case .property:
            let isFavorite = viewModel.isFavorite(at: index)
            cell.setCell(with: product, in: index, isFavorite: isFavorite, isHouse: true)
        case .favorite:
            cell.setCell(with: product, in: index, isFavorite: true, isHouse: false)
        }
        return cell
    }
}

// MARK: - Table view Delegate
extension NewViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let index = indexPath.row
        let product = getProduct(at: index)
        if category != .favorite {
            let newDetailsViewController = NewDetailsViewController(with: product, viewModel: viewModel, for: category, index: index)
            navigationController?.pushViewController(newDetailsViewController, animated: true)
        }
    }
}

extension NewViewController: NewViewControllerDelegateProtocol {
    func reloadData(isLoadingHidden: Bool) {
        newView.loadingStackView(isHidden: isLoadingHidden)
        newView.tableView.reloadData()
    }
    
    func showMessage(with text: String, type: AndesMessageType) {
        Message.show(with: text, type: type)
    }
}
