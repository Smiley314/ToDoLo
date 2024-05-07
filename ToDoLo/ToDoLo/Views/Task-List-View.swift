//
//  Task-List-View.swift
//  ToDoLo
//
//  Created by Melissa Benefer on 5/3/24.
//

import SwiftUI
import Firebase
import FirebaseCore
import FirebaseDatabase

struct Task_List_View: View {
    @EnvironmentObject private var viewModel: TaskViewModel
    
    let task: Task
    var body: some View {
        HStack(spacing: 12) {
            Button(action: {
                viewModel.markComplete(id: task.id, completed: !task.completed)
            }) {
                Image(systemName: task.completed ? "checkmark.circle.fill" : "circle")
                    .resizable()
                    .frame(width: 20, height: 20)
                    .foregroundColor(task.completed ? Color.green : Color.gray)
            }
            .buttonStyle(PlainButtonStyle())
            Text(task.title)
            Spacer()
            
            if task.priortyHigh {
                        Text("High")
                    .foregroundColor(.red)
            } else if task.priortyMed {
                        Text("Normal")
                    .foregroundColor(.yellow)
            } else if task.priortyLow {
                        Text("Low")
                    .foregroundColor(.green)
                    }
        }
        .padding()
    }
}


struct Task_List_View_Preview: PreviewProvider {
    static var previews: some View {
        let task = Task(id: "123", title:"Test", completed: false, updatedAt: Date.now, priortyHigh: false, priortyMed: true, priortyLow: false)
        
        return Task_List_View(task: task)
    }
    
    
}
