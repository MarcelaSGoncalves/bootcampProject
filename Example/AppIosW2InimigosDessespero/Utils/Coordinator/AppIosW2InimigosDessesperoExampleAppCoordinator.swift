//
//  AppIosW2InimigosDessesperoExampleAppCoordinator.swift
//  AppIosW2InimigosDessespero_Example
//
//  Created by ext_feteruel on 2022-09-26.
//  Copyright (c) 2022 Mercado Libre. All rights reserved
//

import UIKit

class AppIosW2InimigosDessesperoExampleAppCoordinator: AppIosW2InimigosDessesperoExampleCoordinator {
    var childCoordinators = [AppIosW2InimigosDessesperoExampleCoordinator]()
    var navigationController: UINavigationController
    var menuOpened = false

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let viewController = AppIosW2InimigosDessesperoExampleViewController()
        viewController.coordinator = self
        self.navigationController.pushViewController(viewController, animated: true)
    }

    func goToHome() {
        self.navigationController.popToRootViewController(animated: true)
    }

    func goToBack() {
        self.navigationController.popViewController(animated: false)
    }

    func goToFaqs() {
        let viewController = AppIosW2InimigosDessesperoFaqsExampleViewController()
        viewController.coordinator = self
        self.navigationController.pushViewController(viewController, animated: true)
    }

    func gotToController(_ viewController: UIViewController) {
        self.navigationController.pushViewController(viewController, animated: false)
    }
}
