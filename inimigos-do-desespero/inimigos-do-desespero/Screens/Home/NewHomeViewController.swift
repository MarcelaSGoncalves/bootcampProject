//
//  NewHomeViewController.swift
//  inimigos-do-desespero
//
//  Created by Luciano Da Silva Berchon on 18/10/22.
//

import Foundation
import UIKit

final class NewHomeViewController: UIViewController {
    // MARK: - Screen objects
    private lazy var newHomeView: UIView = {
        let view = NewHomeView()
        view.delegate = self
        return view
    }()
    
    private lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.sizeToFit()
        searchBar.searchTextField.layer.cornerRadius = 36 / 2
        searchBar.searchTextField.layer.masksToBounds = true
        searchBar.placeholder = "Buscar em Mercado livre"
        searchBar.searchTextField.backgroundColor = .white
        return searchBar
    }()
    
    //MARK: - Properties
    private let viewModel: NewViewModel
    
    //MARK: Initialization/ MARK: - Initializer
    init(with viewModel: NewViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Life cycle methods
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNavigationBar()
    }

    override func loadView() {
        view = newHomeView
    }
    
    // MARK: - Methods
    private func setupNavigationBar() {
        let image = UIImage(systemName: "cart")
        let cartButton = UIBarButtonItem(image: image, style: .done, target: self, action: #selector(cartButtonAction))
        cartButton.tintColor = .black
      
        navigationItem.titleView = searchBar
        navigationItem.rightBarButtonItem = cartButton
        navigationItem.backButtonTitle = ""
    }
    
    @objc private func cartButtonAction() {
        Message.show(with: "Funcionalidade não implementada", type: .neutral)
    }
}

// MARK: - NewHomeViewDelegateProtocol
extension NewHomeViewController: NewHomeViewDelegateProtocol {
    func go(to category: Category) {
        let viewController = NewViewController(with: viewModel, for: category)
        navigationController?.pushViewController(viewController, animated: true)
    }
}
