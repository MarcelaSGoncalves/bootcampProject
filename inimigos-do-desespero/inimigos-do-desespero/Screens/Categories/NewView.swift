//
//  NewView.swift
//  inimigos-do-desespero
//
//  Created by Luciano Da Silva Berchon on 17/10/22.
//

import Foundation
import UIKit
import AndesUI

final class NewView: UIView {
    // MARK: Screen objects
    private lazy var feedbackView: AndesFeedbackScreenView = generateFeedbackView()
    
    lazy var tableView: UITableView = {
        let tableview = UITableView()
        tableview.translatesAutoresizingMaskIntoConstraints = false
        tableview.rowHeight = 156
        tableview.register(NewTableViewCell.self, forCellReuseIdentifier: cellIdentifier)
        return tableview
    }()
    
    private lazy var progressBar: AndesProgressIndicatorIndeterminate = {
        let progressIndicator = AndesProgressIndicatorIndeterminate(size: .large, tint: .Andes.blueML500, accessibilityLabel: "Carregando...")
        progressIndicator.isHidden = true
        progressIndicator.translatesAutoresizingMaskIntoConstraints = false
        return progressIndicator
    }()
    
    // MARK: - Properties
    private let cellIdentifier = "\(NewTableViewCell.self)"
    private let category: Category
    
    // MARK: - Initializers
    init(category: Category, delegateTable: UITableViewDelegate, dataSourceTable: UITableViewDataSource) {
        self.category = category
        super.init(frame: .zero)
        backgroundColor = .white
        tableView.delegate = delegateTable
        tableView.dataSource = dataSourceTable
        setup()
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    func loadingStackView(isHidden: Bool) {
        progressBar.isHidden = isHidden
        if isHidden {
            progressBar.stopAnimation()
        } else {
            progressBar.startAnimation()
        }
    }
    
    func setIsHiddenFeedbackView(isHidden: Bool) {
        if progressBar.isHidden {
            feedbackView.isHidden = isHidden
            return
        }
        feedbackView.isHidden = true
    }
    
    private func setupViews() {
        feedbackView.isHidden = true
        backgroundColor = feedbackView.statusBarColor
        addSubview(feedbackView)
        feedbackView.autoPinEdge(.top, to: .top, of: self, withOffset: 0)
        feedbackView.autoPinEdge(.leading, to: .leading, of: self)
        feedbackView.autoPinEdge(.trailing, to: .trailing, of: self)
        feedbackView.autoPinEdge(.bottom, to: .bottom, of: self)
    }
}

extension NewView {
    private func generateFeedbackView() -> AndesFeedbackScreenView {
        var title = "Nenhum produto encontrado"
        var description = "Refine sua busca e descubra produtos incríveis!"
        var imageName = "nao_tem_publicacoes"
        if category == .favorite {
            title = "Você ainda não adicionou os seus favoritos"
            description = "Descubra produtos incríveis!"
        }
        let errorScreen: AndesFeedbackScreenErrorComponent = ErrorScreen(titleMessage: title, imageName: imageName, descriptionMessage: description)
        let view = AndesFeedbackScreenFactory.createAndesFeedbackScreenError(errorComponent: errorScreen, actions: nil)
        return view
    }
}

// MARK: - View code protocol
extension NewView: ViewCodeProtocol {
    func setupSubViews() {
        addSubview(tableView)
        addSubview(progressBar)
    }
    
    func setupConstraints() {
        tableViewConstraints()
        progressBarConstraint()
    }
    
    private func tableViewConstraints() {
        tableView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor).isActive = true
    }
    
    private func progressBarConstraint() {
        progressBar.centerYAnchor.constraint(equalTo: safeAreaLayoutGuide.centerYAnchor).isActive = true
        progressBar.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor).isActive = true
    }
    
    func setupExtraConfiguration() { }
}
