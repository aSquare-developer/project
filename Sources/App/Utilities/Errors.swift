//
//  Errors.swift
//
//  Created by Artur Anissimov on 04.01.2025.
//

import Vapor

enum AppError: Error {
    case validationFailed(String)
    case resourceNotFound(String)
    case serverError(String)
}

extension AppError: AbortError {
    var status: HTTPResponseStatus {
        switch self {
        case .validationFailed: return .badRequest
        case .resourceNotFound: return .notFound
        case .serverError: return .internalServerError
        }
    }

    var reason: String {
        switch self {
        case .validationFailed(let message): return "Validation failed: \(message)"
        case .resourceNotFound(let resource): return "\(resource) not found."
        case .serverError(let message): return "Internal server error: \(message)"
        }
    }
}
