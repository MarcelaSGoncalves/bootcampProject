//
//  NewTabBarController.swift
//  inimigos-do-desespero
//
//  Created by Luciano Da Silva Berchon on 18/10/22.
//

import Foundation
import UIKit

final class NewTabBarController: UITabBarController {
    // MARK: - Screen Objects
    private lazy var homeNavigationController: UINavigationController = {
        let viewController = NewHomeViewController(with: viewModel)
        viewController.title = "Início"
        viewController.tabBarItem = UITabBarItem(title: "Início", image: UIImage(systemName: "house"), tag: 1)
        let navigationController = UINavigationController(rootViewController: viewController)
        setupStatusBar(navigationController: navigationController)
        return navigationController
    }()
    
    private lazy var favoritesNavigationController: UINavigationController = {
        let viewController = NewViewController(with: viewModel, for: .favorite)
        viewController.title = "Favoritos"
        viewController.tabBarItem = UITabBarItem(title: "Favoritos", image: UIImage(systemName: "heart"), tag: 1)
        let navigationController = UINavigationController(rootViewController: viewController)
        setupStatusBar(navigationController: navigationController)
        return navigationController
    }()
    
    private lazy var minhasComprasNavigationController: UINavigationController = {
        let viewController = NewPlusViewController()
        viewController.title = "Minhas compras"
        viewController.tabBarItem = UITabBarItem(title: "Minhas compras", image: UIImage(systemName: "bag"), tag: 1)
        let navigationController = UINavigationController(rootViewController: viewController)
        setupStatusBar(navigationController: navigationController)
        return navigationController
    }()
    
    private lazy var notificacoesNavigationController: UINavigationController = {
        let viewController = NewPlusViewController()
        viewController.title = "Notificações"
        viewController.tabBarItem = UITabBarItem(title: "Notificações", image: UIImage(systemName: "bell"), tag: 1)
        let navigationController = UINavigationController(rootViewController: viewController)
        setupStatusBar(navigationController: navigationController)
        return navigationController
    }()
    
    private lazy var maisNavigationController: UINavigationController = {
        let viewController = NewPlusViewController()
        viewController.title = "Mais"
        viewController.tabBarItem = UITabBarItem(title: "Mais", image: UIImage(systemName: "plus"), tag: 1)
        let navigationController = UINavigationController(rootViewController: viewController)
        setupStatusBar(navigationController: navigationController)
        return navigationController
    }()
    
    //MARK: - Properties
    let viewModel = NewViewModel(with: .favorite)
    
    // MARK: - Life cycle methods
    override func viewDidLoad() {
        viewControllers = [
            homeNavigationController,
            favoritesNavigationController,
            minhasComprasNavigationController,
            notificacoesNavigationController,
            maisNavigationController
        ]
        tabBar.backgroundColor = .white
        tabBar.barTintColor = .white
        tabBar.tintColor = .systemBlue
        tabBar.unselectedItemTintColor = .systemGray
    }
    
    private func setupStatusBar(navigationController: UINavigationController) {
        let appearance = UINavigationBarAppearance()
        navigationController.navigationBar.isTranslucent = false
        let newYellow = UIColor(red: 1.0, green: 0.9, blue: 0.0, alpha: 1.0)
        appearance.backgroundColor = newYellow
        navigationController.navigationBar.barTintColor = newYellow
        navigationController.navigationBar.standardAppearance = appearance
        navigationController.navigationBar.scrollEdgeAppearance = appearance
        navigationController.navigationBar.compactAppearance = appearance
        navigationController.navigationBar.tintColor = .black
    }
}
