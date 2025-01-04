//
//  Shisha.swift
//  project
//
//  Created by Artur Anissimov on 02.01.2025.
//

import Fluent
import Vapor

final class Coordinates: Fields, @unchecked Sendable {
    @Field(key: "latitude")
    var latitude: String
    
    @Field(key: "longitude")
    var longitude: String
    
    init() {}
    
    init(latitude: String, longitude: String) {
        self.latitude = latitude
        self.longitude = longitude
    }
}


final class Shisha: Model, Content, @unchecked Sendable {
    static let schema: String = "shishas"
    
    @ID(key: .id)
    var id: UUID?
    
    @Field(key: "name")
    var name: String
    
    @Field(key: "image_url")
    var image_url: String?
    
    @Field(key: "description")
    var description: String?
    
    @Group(key: "coordinates")
    var coordinates: Coordinates
    
    @OptionalField(key: "city")
        var city: String?

    @OptionalField(key: "country")
        var country: String?
    
    init() { }
    
    init(id: UUID? = nil, name: String, image_url: String?, description: String?, coordinates: Coordinates, city: String?, country: String?) {
        self.id = id
        self.name = name
        self.image_url = image_url
        self.description = description
        self.coordinates = coordinates
        self.city = city
        self.country = country
    }
}
