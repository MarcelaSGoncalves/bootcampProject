//
//  NewViewControllerDelegateProtocol.swift
//  inimigos-do-desespero
//
//  Created by Marcela De Souza Goncalves on 19/10/22.
//

import Foundation
import AndesUI

protocol NewViewControllerDelegateProtocol {
    func reloadData(isLoadingHidden: Bool)
    func showMessage(with text: String, type: AndesMessageType)
}
