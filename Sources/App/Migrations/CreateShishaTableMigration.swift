//
//  CreateShishaTableMigration.swift
//  project
//
//  Created by Artur Anissimov on 02.01.2025.
//

import Fluent

struct CreateShishaTableMigration: AsyncMigration {
    
    func prepare(on database: FluentKit.Database) async throws {
        try await database.schema("shishas")
            .id()
            .field("name", .string, .required)
            .field("image_url", .string)
            .field("description", .string)
            .field("coordinates_latitude", .string, .required)
            .field("coordinates_longitude", .string, .required)
            .field("city", .string)
            .field("country", .string)
            .unique(on: "name")
            .create()
    }
    
    
    func revert(on database: FluentKit.Database) async throws {
        try await database.schema("shishas").delete()
    }
}
