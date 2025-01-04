//
//  Request+Shisha.swift
//  project
//
//  Created by Artur Anissimov on 04.01.2025.
//

import Vapor
import Fluent

extension Request {
    func findShisha(by id: String?) async throws -> Shisha {
        guard let id = id, let uuid = UUID(uuidString: id) else {
            throw AppError.validationFailed("Invalid UUID format.")
        }
        guard let shisha = try await Shisha.find(uuid, on: self.db) else {
            throw AppError.resourceNotFound("Shisha place")
        }
        return shisha
    }
}

