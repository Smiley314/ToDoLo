//
//  Data.swift
//  ToDoLo
//
//  Created by Melissa Benefer on 5/3/24.
//

import Foundation
import FirebaseFirestore

struct Task: Codable {
    var id: String
    var title: String
    var due = Date.now
    var notes: String?
    var completed = false
    var updatedAt = Date.now
    var priortyHigh = false
    var priortyMed = false
    var priortyLow = false
}
