//
//  User.swift
//  project
//
//  Created by Artur Anissimov on 02.01.2025.
//

import Vapor
import Fluent

final class User: Model, Content, @unchecked Sendable {
    
    static let schema: String = "users"
    
    @ID(key: .id)
    var id: UUID?
    
    @Field(key: "email")
    var email: String
    
    @Field(key: "password")
    var password: String
    
    init() {}
    
    init(id: UUID? = nil, email: String, password: String) {
        self.id = id
        self.email = email
        self.password = password
    }
    
    final class Public: Content, @unchecked Sendable {
        var id: UUID?
        var email: String
        
        init(id: UUID? = nil, email: String) {
            self.id = id
            self.email = email
        }
    }
}

extension User {
    func convertToPublic() -> User.Public {
        return User.Public(id: id, email: email)
    }
}


