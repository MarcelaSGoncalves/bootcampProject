//
//  PlusViewController.swift
//  inimigos-do-desespero
//
//  Created by Luciano Da Silva Berchon on 18/10/22.
//

import Foundation
import UIKit
import AndesUI

final class NewPlusViewController: UIViewController {
    private lazy var feedbackView: AndesFeedbackScreenView = generateFeedbackView()
    
    override func viewDidLoad() {
        view.backgroundColor = .green
        setupViews()
    }

    private func setupViews() {
        self.view.backgroundColor = feedbackView.statusBarColor
        self.view.addSubview(self.feedbackView)
        self.feedbackView.autoPinEdge(.top, to: .top, of: self.view, withOffset: 0)
        self.feedbackView.autoPinEdge(.leading, to: .leading, of: self.view)
        self.feedbackView.autoPinEdge(.trailing, to: .trailing, of: self.view)
        self.feedbackView.autoPinEdge(.bottom, to: .bottom, of: self.view)
    }
}

extension NewPlusViewController {
    private func generateFeedbackView() -> AndesFeedbackScreenView {
        let errorScreen: AndesFeedbackScreenErrorComponent = ErrorScreen(titleMessage: "Página em construção", imageName: "error_de_servidor_interno", descriptionMessage: "Volte mais tarde")
        let view = AndesFeedbackScreenFactory.createAndesFeedbackScreenError(errorComponent: errorScreen, actions: nil)
        return view
    }
}
