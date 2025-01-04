//
//  File.swift
//  project
//
//  Created by Artur Anissimov on 02.01.2025.
//

import Fluent
import Vapor

struct ShishasController: RouteCollection {
    func boot(routes: any RoutesBuilder) throws {
        let shishas = routes.grouped("api", "shishas")
        
        shishas.get(use: index)
        shishas.post(use: create)
        
        shishas.group(":id") { shisha in
            shisha.get(use: show)
            shisha.put(use: update)
            shisha.delete(use: delete)
        }
    }
    
    func index(_ req: Request) async throws -> Page<Shisha> {
        try await Shisha.query(on: req.db).paginate(for: req)
    }
    
    func create(_ req: Request) async throws -> Shisha {
        let input = try req.content.decode(Shisha.self)
        guard !input.name.isEmpty else {
            throw AppError.validationFailed("Name cannot be empty")
        }
        
        let shisha = Shisha(
            name: input.name,
            image_url: input.image_url,
            description: input.description,
            coordinates: Coordinates(latitude: input.coordinates.latitude, longitude: input.coordinates.longitude),
            city: input.city,
            country: input.country
        )
        
        try await shisha.save(on: req.db)
        return shisha
    }
    
    func show(_ req: Request) async throws -> Shisha {
        try await req.findShisha(by: req.parameters.get("id"))
    }
    
    func update(_ req: Request) async throws -> Shisha {
        
        let shisha = try await req.findShisha(by: req.parameters.get("id"))
        let input = try req.content.decode(Shisha.self)
        
        shisha.name = input.name
        shisha.image_url = input.image_url
        shisha.description = input.description
        shisha.coordinates.latitude = input.coordinates.latitude
        shisha.coordinates.longitude = input.coordinates.longitude
        shisha.city = input.city
        shisha.country = input.country
        
        try await shisha.save(on: req.db)
        return shisha
    }
    
    func delete(_ req: Request) async throws -> HTTPStatus {
        let shisha = try await req.findShisha(by: req.parameters.get("id"))
        try await shisha.delete(on: req.db)
        return .ok
    }
}
