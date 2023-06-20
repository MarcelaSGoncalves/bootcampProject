//
//  UIView+Additions.swift
//  inimigos-do-desespero
//
//  Created by Karen Camilla Portera Tavela on 24/10/22.
//

import Foundation
import UIKit

extension UIView {
    func pinTo(view: UIView) {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        self.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        self.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        self.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
}
