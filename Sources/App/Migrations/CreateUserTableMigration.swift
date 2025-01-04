//
//  CreateUserTableMigration.swift
//  project
//
//  Created by Artur Anissimov on 02.01.2025.
//

import Fluent

struct CreateUserTableMigration: AsyncMigration {
    
    func prepare(on database: any Database) async throws {
        try await database.schema("users")
            .id()
            .field("email", .string, .required)
            .field("password", .string, .required)
            .unique(on: "email")
            .create()
    }

    func revert(on database: any Database) async throws {
        try await database.schema("users")
            .delete()
    }
}


