//
//  Item.swift
//  MacLandmarks
//
//  Created by Chase Wright on 1/22/23.
//
import Foundation

struct TodoItem: Identifiable, Codable {
    let id: UUID
    var todo: String
    var isComplete: Bool
    
    init(id: UUID = UUID(), todo: String, isComplete: Bool = false) {
        self.id = id
        self.todo = todo
        self.isComplete = isComplete
    }
}
