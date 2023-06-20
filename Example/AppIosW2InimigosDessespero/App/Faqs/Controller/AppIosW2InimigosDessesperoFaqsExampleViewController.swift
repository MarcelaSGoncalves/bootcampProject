//
//  AppIosW2InimigosDessesperoFaqsExampleViewController.swift
//  AppIosW2InimigosDessespero_Example
//
//  Created by ext_feteruel on 2022-09-26.
//  Copyright (c) 2022 Mercado Libre. All rights reserved
//

import UIKit

class AppIosW2InimigosDessesperoFaqsExampleViewController: UIViewController {
    @IBOutlet private var tableView: UITableView!
    weak var coordinator: AppIosW2InimigosDessesperoExampleAppCoordinator?
    private lazy var presenter = AppIosW2InimigosDessesperoFaqsExamplePresenter(delegate: self)

    override func viewDidLoad() {
        super.viewDidLoad()
        self.presenter.setExampleFaqs()
        self.setupView()
    }

    func setupView() {
        self.title = "FAQS"
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.tableView.tableFooterView = UIView(frame: .zero)

        let barButtonItem = UIBarButtonItem(title: "Faqs", style: .plain, target: self, action: #selector(faqsTapped))
        self.navigationController?.navigationItem.rightBarButtonItem = barButtonItem
    }

    @objc
    func faqsTapped() {
        self.coordinator?.goToFaqs()
    }
}

extension AppIosW2InimigosDessesperoFaqsExampleViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.presenter.getNumberOfRows()
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "Cell")
        cell.textLabel?.text = self.presenter.getExampleFaqsTitle(index: indexPath.row)
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let url = self.presenter.getExampleFaqsURL(index: indexPath.row) else { return }
        UIApplication.shared.open(url, options: [:])
    }
}

extension AppIosW2InimigosDessesperoFaqsExampleViewController: AppIosW2InimigosDessesperoFaqsExampleDelegate {
    func willLoadTable() {
        self.tableView.reloadData()
    }
}
