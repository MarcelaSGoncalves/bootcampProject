//
//  ViewCodeProtocol.swift
//  inimigos-do-desespero
//
//  Created by Luciano Da Silva Berchon on 28/09/22.
//

import Foundation

protocol ViewCodeProtocol {
    func setupSubViews()
    func setupConstraints()
    func setupExtraConfiguration()
    func setup()
}

extension ViewCodeProtocol {
    func setup() {
        setupSubViews()
        setupConstraints()
        setupExtraConfiguration()
    }
}
