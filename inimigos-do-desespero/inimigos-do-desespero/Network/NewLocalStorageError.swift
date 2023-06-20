//
//  NewLocalStorageError.swift
//  inimigos-do-desespero
//
//  Created by Luciano Da Silva Berchon on 19/10/22.
//

import Foundation

enum NewLocalStorageError: String, Error {
    case NetworkSetDataFailure = "Fail to set data in local storage"
    case NetworkGetDataFailure = "Fail to get data in local storage"
    case NetworkDataDecodedFailure = "Data not be decoded"
    case NetworkInvalidKey = "Key invalid or null"
}
