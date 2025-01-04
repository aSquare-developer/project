//
//  UsersController.swift
//  project
//
//  Created by Artur Anissimov on 02.01.2025.
//

import Vapor

struct UsersController: RouteCollection {
    func boot(routes: any RoutesBuilder) throws {
        let users = routes.grouped("api", "users")
        
        users.post(use: create)
    }
    
    /*
     Create a user
     */
    func create(_ req: Request) async throws -> User.Public {
        
        let user = try req.content.decode(User.self)
        user.password = try Bcrypt.hash(user.password)
        try await user.save(on: req.db)
        
        return user.convertToPublic()
    }
}
