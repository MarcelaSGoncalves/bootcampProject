//
//  AppIosW2InimigosDessesperoExampleViewController.swift
//  AppIosW2InimigosDessespero_Example
//
//  Created by ext_feteruel on 2022-09-26.
//  Copyright (c) 2022 Mercado Libre. All rights reserved
//

import UIKit

class AppIosW2InimigosDessesperoExampleViewController: UIViewController {
    @IBOutlet private var tableView: UITableView!
    weak var coordinator: AppIosW2InimigosDessesperoExampleAppCoordinator?
    private lazy var presenter = AppIosW2InimigosDessesperoExamplePresenter(delegate: self)

    override func viewDidLoad() {
        super.viewDidLoad()
        self.presenter.setExampleViewControllers()
        self.setupView()
    }

    func setupView() {
        self.title = "AppIosW2InimigosDessespero"
        self.tableView.dataSource = self
        self.tableView.tableFooterView = UIView(frame: .zero)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Faqs", style: .plain, target: self, action: #selector(faqsTapped))
    }

    @objc
    func faqsTapped() {
        self.coordinator?.goToFaqs()
    }
}

extension AppIosW2InimigosDessesperoExampleViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.presenter.getNumberOfRows()
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "Cell")
        cell.textLabel?.text = self.presenter.getExampleTitle(index: indexPath.row)
        return cell
    }
}

extension AppIosW2InimigosDessesperoExampleViewController: AppIosW2InimigosDessesperoExampleDelegate {
    func willLoadTable() {
        self.tableView.reloadData()
    }
}
