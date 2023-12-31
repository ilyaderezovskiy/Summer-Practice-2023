import Fluent
import FluentPostgresDriver
import Vapor

// configures your application
public func configure(_ app: Application) throws {
    // uncomment to serve files from /Public folder
    // app.middleware.use(FileMiddleware(publicDirectory: app.directory.publicDirectory))

    app.databases.use(.postgres(
        hostname: Environment.get("DATABASE_HOST") ?? "localhost",
        port: Environment.get("DATABASE_PORT").flatMap(Int.init(_:)) ?? PostgresConfiguration.ianaPortNumber,
        username: Environment.get("DATABASE_USERNAME") ?? "planner_username",
        password: Environment.get("DATABASE_PASSWORD") ?? "planner_password",
        database: Environment.get("DATABASE_NAME") ?? "planner_database"
    ), as: .psql)

    app.migrations.add(CreateTask())
    app.migrations.add(CreateUser())
    try app.autoMigrate().wait()

    // register routes
    try routes(app)
}
