//
//  AppIosW2InimigosDessesperoExamplePresenter.swift
//  AppIosW2InimigosDessespero_Example
//
//  Created by ext_feteruel on 2022-09-26.
//  Copyright (c) 2022 Mercado Libre. All rights reserved
//

import UIKit

protocol AppIosW2InimigosDessesperoExampleDelegate: AnyObject {
    func willLoadTable()
}

class AppIosW2InimigosDessesperoExamplePresenter {
    private weak var delegate: AppIosW2InimigosDessesperoExampleDelegate?
    private var exampleItems: [AppIosW2InimigosDessesperoExampleModel?]

    init(delegate: AppIosW2InimigosDessesperoExampleDelegate) {
        self.delegate = delegate
        self.exampleItems = [AppIosW2InimigosDessesperoExampleModel]()
    }

    func setExampleViewControllers() {
        self.exampleItems.append(AppIosW2InimigosDessesperoExampleModel(title: "Item 1", controller: UIViewController()))
        self.exampleItems.append(AppIosW2InimigosDessesperoExampleModel(title: "Item 2", controller: UIViewController()))
        self.exampleItems.append(AppIosW2InimigosDessesperoExampleModel(title: "Item 3", controller: UIViewController()))
        self.delegate?.willLoadTable()
    }

    func getNumberOfRows() -> Int {
        return self.exampleItems.count
    }

    func getExampleTitle(index: Int) -> String? {
        let exampleItem = self.exampleItems[index]
        return exampleItem?.title
    }
}
