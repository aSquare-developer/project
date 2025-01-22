//
//  RestaurantController.swift
//
//  Created by Artur Anissimov on 02.01.2025.
//

import Fluent
import Vapor

struct RestaurantController: RouteCollection {
    func boot(routes: RoutesBuilder) throws {
        let restaurants = routes.grouped("api", "restaurants")
        
        restaurants.get(use: index)
        restaurants.post(use: create)
        
        restaurants.group(":id") { restaurant in
            restaurant.get(use: show)
            restaurant.put(use: update)
            restaurant.delete(use: delete)
        }
    }
    
    func index(_ req: Request) async throws -> Page<Restaurant> {
        let restaurants = try await Restaurant.query(on: req.db).paginate(for: req)
        
        guard !restaurants.items.isEmpty else {
            throw AppError.resourceNotFound("The restaurants")
        }
        
        return restaurants
    }
    
    func create(_ req: Request) async throws -> Restaurant {
        let input = try req.content.decode(Restaurant.self)
        guard !input.name.isEmpty else {
            throw AppError.validationFailed("Name cannot be empty")
        }
        
        let shisha = Restaurant(
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
    
    func show(_ req: Request) async throws -> Restaurant {
        try await req.findRestaurant(by: req.parameters.get("id"))
    }
    
    func update(_ req: Request) async throws -> Restaurant {
        
        let restaurant = try await req.findRestaurant(by: req.parameters.get("id"))
        let input = try req.content.decode(Restaurant.self)
        
        restaurant.name = input.name
        restaurant.image_url = input.image_url
        restaurant.description = input.description
        restaurant.coordinates.latitude = input.coordinates.latitude
        restaurant.coordinates.longitude = input.coordinates.longitude
        restaurant.city = input.city
        restaurant.country = input.country
        
        try await restaurant.save(on: req.db)
        return restaurant
    }
    
    func delete(_ req: Request) async throws -> HTTPStatus {
        let restaurant = try await req.findRestaurant(by: req.parameters.get("id"))
        try await restaurant.delete(on: req.db)
        return .ok
    }
}
