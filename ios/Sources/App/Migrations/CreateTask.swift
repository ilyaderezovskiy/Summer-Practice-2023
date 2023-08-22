//
//  CreateTask.swift
//  
//
//  Created by Ilya Derezovskiy on 02.04.2023.
//

import Fluent
import Vapor

struct CreateTask: AsyncMigration {
    
    // Создание базы данных
    func prepare(on database: Database) async throws {
        try await database.schema("tasks")
            .id()
            .field("userID", .uuid, .required)
            .field("title", .string, .required) // .required - обязательное
            .field("time", .string, .required)
            .field("description", .string, .required)
            .field("category", .string, .required)
            .field("isDone", .bool, .required)
            .field("isOverdue", .bool, .required)
            .create()
    }

    func revert(on database: Database) async throws {
        try await database.schema("tasks").delete()
    }
}
