//
//  AppIosW2InimigosDessesperoFaqsExamplePresenter.swift
//  AppIosW2InimigosDessespero_Example
//
//  Created by ext_feteruel on 2022-09-26.
//  Copyright (c) 2022 Mercado Libre. All rights reserved
//

import UIKit

protocol AppIosW2InimigosDessesperoFaqsExampleDelegate: AnyObject {
    func willLoadTable()
}

class AppIosW2InimigosDessesperoFaqsExamplePresenter {
    private weak var delegate: AppIosW2InimigosDessesperoFaqsExampleDelegate?
    private var exampleFaqsItems: [AppIosW2InimigosDessesperoFaqsExampleModel?]

    init(delegate: AppIosW2InimigosDessesperoFaqsExampleDelegate) {
        self.delegate = delegate
        self.exampleFaqsItems = [AppIosW2InimigosDessesperoFaqsExampleModel]()
    }

    func setExampleFaqs() {
        let faqs = [
            "Documentacion de arquitectura": "https://sites.google.com/mercadolibre.com/mobile/home?authuser=0",
            "Quiero arrancar un proyecto": "https://sites.google.com/mercadolibre.com/mobile/quiero-arrancar-un-proyecto",
            "Requerimientos para subir a producción": "https://sites.google.com/mercadolibre.com/mobile/quiero-arrancar-un-proyecto/requerimientos-para-prod?authuser=0",
            "Guías de migración": "https://sites.google.com/mercadolibre.com/mobile/arquitectura/gu%C3%ADas-de-migración?authuser=0",
            "Fechas especiales y freezes": "https://sites.google.com/mercadolibre.com/mobile/releases/fechas-especiales-y-freezes?authuser=0"
        ]

        self.exampleFaqsItems = faqs.map {
            return AppIosW2InimigosDessesperoFaqsExampleModel(title: $0, urlString: $1)
        }
        self.delegate?.willLoadTable()
    }

    func getNumberOfRows() -> Int {
        return self.exampleFaqsItems.count
    }

    func getExampleFaqsTitle(index: Int) -> String? {
        let exampleItem = self.exampleFaqsItems[index]
        return exampleItem?.title
    }

    func getExampleFaqsURL(index: Int) -> URL? {
        let exampleItem = self.exampleFaqsItems[index]
        return exampleItem?.url
    }
}
