import Vapor
import Fluent
import FluentSQLiteDriver

// configures your application
public func configure(_ app: Application) async throws {
    // uncomment to serve files from /Public folder
    // app.middleware.use(FileMiddleware(publicDirectory: app.directory.publicDirectory))
    
    // Database
    app.databases.use(.sqlite(.memory), as: .sqlite)
    
    // Migrations
    app.migrations.add(CreateUserTableMigration())
    app.migrations.add(CreateShishaTableMigration())
    
    try await app.autoMigrate()
    
    // register routes
    try routes(app)
}
