//
//  AppIosW2InimigosDessesperoExampleCoordinator.swift
//  AppIosW2InimigosDessespero_Example
//
//  Created by ext_feteruel on 2022-09-26.
//  Copyright (c) 2022 Mercado Libre. All rights reserved
//

import UIKit

protocol AppIosW2InimigosDessesperoExampleCoordinator {
    var childCoordinators: [AppIosW2InimigosDessesperoExampleCoordinator] { get set }
    var navigationController: UINavigationController { get set }

    func start()
}
