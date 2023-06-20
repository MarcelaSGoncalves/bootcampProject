//
//  Message.swift
//  inimigos-do-desespero
//
//  Created by Luciano Da Silva Berchon on 22/10/22.
//

import Foundation
import AndesUI

final class Message {
    static func removeMessage(element target: UIView) {
        UIView.animate(withDuration: 0.5, delay: 3, options: [.curveEaseOut, .transitionCrossDissolve]) {
            target.alpha = 0
        } completion: { _ in
            target.removeFromSuperview()
        }
    }

    static func show(with message: String, type: AndesMessageType) {
        let windows = UIApplication.shared.windows
        guard let window = windows.first(where: { $0.isKeyWindow }) else {
            return
        }

        let andesMessage = AndesMessage()
        andesMessage.type = type
        andesMessage.title = message
        andesMessage.alpha = 0
        
        window.addSubview(andesMessage)
        setupConstraints(with: andesMessage, in: window)
        
        UIView.animate(withDuration: 0.5, delay: 0, options: [.curveEaseOut, .transitionCrossDissolve]) {
            andesMessage.alpha = 1
        } completion: { _ in
            removeMessage(element: andesMessage)
        }
    }
    
    private static func setupConstraints(with component: UIView, in target: UIView) {
        component.topAnchor.constraint(equalTo: target.topAnchor, constant: 64).isActive = true
        component.leadingAnchor.constraint(equalTo: target.leadingAnchor, constant: 16).isActive = true
        component.trailingAnchor.constraint(equalTo: target.trailingAnchor, constant: -16).isActive = true
    }
}
