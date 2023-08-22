//
//  Task.swift
//  
//
//  Created by Ilya Derezovskiy on 02.04.2023.
//

import Fluent
import Vapor

final class Task: Model, Content {
    static let schema = "tasks"
    
    @ID(key: .id)
    var id: UUID?

    @Field(key: "userID")
    var userID: UUID?
    
    @Field(key: "title")
    var title: String
    
    @Field(key: "time")
    var time: String
    
    @Field(key: "description")
    var description: String
    
    @Field(key: "category")
    var category: String
    
    @Field(key: "isDone")
    var isDone: Bool
    
    @Field(key: "isOverdue")
    var isOverdue: Bool
    

    init() { }

    init(id: UUID? = nil, userID: UUID? = nil, title: String, time: String, description: String, category: String, isDone: Bool, isOverdue: Bool) {
        self.id = id
        self.userID = userID
        self.title = title
        self.time = time
        self.description = description
        self.category = category
        self.isDone = isDone
        self.isOverdue = isOverdue
    }
}
