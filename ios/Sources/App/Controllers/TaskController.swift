//
//  TaskController.swift
//  
//
//  Created by Ilya Derezovskiy on 02.04.2023.
//

import Fluent
import Vapor

struct TaskController: RouteCollection {
    func boot(routes: RoutesBuilder) throws {
        let tasks = routes.grouped("tasks")
        tasks.get(use: index)
        tasks.get(":userID", use: getUserHandler)
        
        tasks.post(use: create)
        tasks.delete(":taskID", use: delete)
        tasks.put(":taskID", use: update)
    }

    // Получение всех задач
    func index(req: Request) async throws -> [Task] {
        try await Task.query(on: req.db).all()
    }
    
    // Получение задачи по id
    func getUserHandler(req: Request) async throws -> [Task] {
        var task = try await Task.query(on: req.db).all()
        return task.filter({$0.userID == req.parameters.get("userID")})
    }
    
    // Создание новой задачи
    func create(req: Request) async throws -> Task {
        let task = try req.content.decode(Task.self)
        try await task.save(on: req.db)
        return task
    }
    
    // Обновление информации о задаче
    func update(req: Request) async throws -> Task {
        guard let task = try await Task.find(req.parameters.get("taskID"), on: req.db) else {
            throw Abort(.notFound)
        }
        
        let updatedTask = try req.content.decode(Task.self)

        task.userID = updatedTask.userID
        task.title = updatedTask.title
        task.time = updatedTask.time
        task.description = updatedTask.description
        task.category = updatedTask.category
        task.isDone = updatedTask.isDone
        task.isOverdue = updatedTask.isOverdue
        
        try await task.save(on: req.db)
        
        return task
    }

    // Удаление задачи
    func delete(req: Request) async throws -> HTTPStatus {
        guard let task = try await Task.find(req.parameters.get("taskID"), on: req.db) else {
            throw Abort(.notFound)
        }
        try await task.delete(on: req.db)
        return .noContent
    }
}
