//
//  AppIosW2InimigosDessesperoFaqsExampleModel.swift
//  AppIosW2InimigosDessespero_Example
//
//  Created by ext_feteruel on 2022-09-26.
//  Copyright (c) 2022 Mercado Libre. All rights reserved
//
import Foundation

struct AppIosW2InimigosDessesperoFaqsExampleModel {
    let title: String
    var url: URL?

    init(title: String, urlString: String) {
        self.title = title
        if let url = URL(string: urlString) {
            self.url = url
        }
    }
}
