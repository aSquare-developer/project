//
//  Request+Restaurant.swift
//
//  Created by Artur Anissimov on 04.01.2025.
//

import Vapor
import Fluent

extension Request {
    func findRestaurant(by id: String?) async throws -> Restaurant {
        guard let id = id, let uuid = UUID(uuidString: id) else {
            throw AppError.validationFailed("Invalid UUID format.")
        }
        guard let restaurant = try await Restaurant.find(uuid, on: self.db) else {
            throw AppError.resourceNotFound("Restaurant")
        }
        return restaurant
    }
}

