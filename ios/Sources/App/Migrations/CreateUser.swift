//
//  CreateUser.swift
//  
//
//  Created by Ilya Derezovskiy on 02.04.2023.
//

import Fluent
import Vapor

struct CreateUser: AsyncMigration {
    
    // Создание базы данных
    func prepare(on database: Database) async throws {
        try await database.schema("users")
            .id()
            .field("username", .string, .required)
            .unique(on: "username")
            .field("email", .string, .required)
            .field("password_hash", .string, .required)
            .create()
    }

    func revert(on database: Database) async throws {
        try await database.schema("users").delete()
    }
}
