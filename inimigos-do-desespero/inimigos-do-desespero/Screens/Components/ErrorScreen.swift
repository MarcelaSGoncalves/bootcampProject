//
//  ErrorScreen.swift
//  inimigos-do-desespero
//
//  Created by Marcela De Souza Goncalves on 23/10/22.
//

import Foundation
import AndesUI
import UIKit

class ErrorScreen: AndesFeedbackScreenErrorComponent {
    let titleMessage: String
    let imageName: String
    let descriptionMessage: String
    
    init(titleMessage: String , imageName: String, descriptionMessage: String) {
        self.titleMessage = titleMessage
        self.imageName = imageName
        self.descriptionMessage = descriptionMessage
    }
    
    func getErrorCode() -> String? {
        return nil
    }
    
    func onViewCreated() { }
    
    func getFeedbackScreeErrorData() -> AndesFeedbackScreenHeader {
        let feedbackText = AndesFeedbackScreenText(title: titleMessage,description: descriptionMessage, errorCode: nil)
        let image = UIImage(named: imageName) ?? UIImage()
        return AndesFeedbackScreenHeader(feedbackText: feedbackText, imageView: image, sizeIllustration: .large)
    }
}
