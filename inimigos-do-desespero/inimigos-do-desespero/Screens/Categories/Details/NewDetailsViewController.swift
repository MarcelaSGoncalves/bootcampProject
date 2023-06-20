//
//  NewDetailsViewController.swift
//  inimigos-do-desespero
//
//  Created by Luciano Da Silva Berchon on 17/10/22.
//

import Foundation
import UIKit
import AndesUI

final class NewDetailsViewController: UIViewController {
    // MARK: - Screen objects
    private lazy var newDetailsView: NewDetailsView = {
        let view = NewDetailsView()
        view.delegate = self
        return view
    }()
    
    // MARK: - Properties
    private var viewModel : NewViewModel
    private let product: Product
    private let category: Category
    private let index: Int
    
    // MARK: - Initializers
    init(with product: Product, viewModel: NewViewModel, for category: Category, index: Int) {
        self.viewModel = viewModel
        self.product = product
        self.category = category
        self.index = index
        super.init(nibName: nil, bundle: nil)
        viewModel.delegateDetails = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Life cycle methods
    override func viewWillAppear(_ animated: Bool) {
        setupNavigationBar()
        newDetailsView.loadingStackView(isHidden: false)
        viewModel.fetchProductDetails(with: product.id)
    }
    
    override func loadView() {
        view = newDetailsView
    }
    
    // MARK: - Methods
    @objc private func cartButtonAction() {
        Message.show(with: "Funcionalidade não implementada", type: .neutral)
    }
    
    @objc private func favoriteButtonAction() {
        Message.show(with: "Funcionalidade não implementada", type: .neutral)
    }
    
    private func setupNavigationBar() {
        let cartImage = UIImage(systemName: "cart")
        let cartButton = UIBarButtonItem(image: cartImage, style: .done, target: self, action: #selector(cartButtonAction))
        cartButton.tintColor = .black
        
        let isFavorite = viewModel.isFavorite(at: index)
        let favoriteImage = isFavorite ? UIImage(systemName: "heart.fill") : UIImage(systemName: "heart")
        let favoriteButton = UIBarButtonItem(image: favoriteImage, style: .done, target: self, action: #selector(favoriteButtonAction))
        favoriteButton.tintColor = .black
        
        navigationItem.rightBarButtonItems = [cartButton, favoriteButton]
    }
    
    private func getProductDetails() -> ProductDetails? {
        return viewModel.getApiDataProduct()
    }
}

//MARK: - NewTableViewCellDelegateProtocol
extension NewDetailsViewController: NewTableViewCellDelegateProtocol {
    func favoriteProduct(with index: Int) {
        let isFavorite = viewModel.isFavorite(at: index)
        if isFavorite {
            viewModel.removeInLocalStorage(the: product)
        } else {
            viewModel.insertInLocalStorage(new: product)
        }
    }
}

// MARK: - NewViewControllerDelegateProtocol
extension NewDetailsViewController: NewViewControllerDelegateProtocol {
    func reloadData(isLoadingHidden: Bool) {
        if isLoadingHidden {
            let productDetails = getProductDetails()
            let isFavorite = viewModel.isFavorite(at: index)
            switch category {
            case .property:
                newDetailsView.setData(with: productDetails, isHouse: true, isFavorite: isFavorite)
            default:
                newDetailsView.setData(with: productDetails, isHouse: false, isFavorite: isFavorite)
            }
            newDetailsView.loadingStackView(isHidden: isLoadingHidden)
        } else {
            newDetailsView.setIsHiddenFeedbackView(isHidden: false)
        }
        newDetailsView.loadingStackView(isHidden: isLoadingHidden)
    }
    
    func showMessage(with text: String, type: AndesMessageType) {
        Message.show(with: text, type: type)
    }
}

// MARK: - CarsDetailsDelegateProtocol
extension NewDetailsViewController: NewDetailViewDelegateProtocol {
    func sendQuestion(with text: String) {
        if text.isEmpty {
            let message = "Você deve completar a pergunta antes de enviá-la"
            newDetailsView.setErrorLabel(with: message)
            return
        }
        
        if hasAValidEmail(in: text) {
            let message = "Não é permitido escrever endereços de e-mail"
            newDetailsView.setErrorLabel(with: message)
            return
        }
        
        if hasASequenceOfNumbers(in: text) {
            let message = "Não é permitido escrever números de telefone"
            newDetailsView.setErrorLabel(with: message)
            return
        }
        newDetailsView.setTextAskTextField(with: String())
    }
    
    private func hasAValidEmail(in text: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: text)
    }

    private func hasASequenceOfNumbers(in text: String) -> Bool {
        let phoneRegEx = "(.{1,})?\\d{5,}(.{1,})?"
        let phonePred = NSPredicate(format:"SELF MATCHES %@", phoneRegEx)
        return phonePred.evaluate(with: text)
    }
}
