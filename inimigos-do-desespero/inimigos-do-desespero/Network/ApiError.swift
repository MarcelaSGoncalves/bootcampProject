//
//  ApiError.swift
//  inimigos-do-desespero
//
//  Created by Marcela De Souza Goncalves on 18/10/22.
//

import Foundation

enum ApiError: String, Error {
    case NetworkBadRequest = "Resource not found"
    case NetworkResponseError = "Error validating grant. Your authorization code or refresh token may be expired or it was already used"
    case NetworkInvalidData = "Invalid data"
    case NetworkTokenNotFound = "Token not found"
    case NetworkInvalidUrl = "Invalid URL"
    case InternalError = "Internal error"
    case ServiceUnavailable = "Unavailable service"
    case EmptyDataError = "No data returned"
}
