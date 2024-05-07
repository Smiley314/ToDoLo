//
//  Home.swift
//  ToDoLo
//
//  Created by Smiley on 5/2/24.
//

import SwiftUI
import UIKit

struct DetailView: View {
    @EnvironmentObject private var viewModel: TaskViewModel
    @Environment(\.presentationMode) var presentationMode
    @State var task: Task
    
    var body: some View {
        ScrollView(){
            VStack(alignment: .leading){
                HStack(alignment: .center){
                    Text(task.title)
                        .font(.largeTitle)
                        .padding(20)
                    
                    
                    if task.priortyHigh {
                                Text("High")
                            .foregroundColor(.red)
                            .padding(.leading, 20)
                    } else if task.priortyMed {
                                Text("Normal")
                            .foregroundColor(.yellow)
                            .padding(.leading, 20)
                    } else if task.priortyLow {
                                Text("Low")
                            .foregroundColor(.green)
                            .padding(.leading, 20)
                            }
                    
                    
                }
                
                Divider()
                    .padding(20)
                
                HStack(alignment: .center){
                    Text("Created: ")
                    Text(dateStyle(date: task.updatedAt))
                    Text("Due: ")
                    Text(dateStyle(date: task.due))
                }
                .padding(.leading, 20)
                Divider()
                    .padding(20)
                
                Text(task.notes ?? " ")
                    .padding(20)
            }
            
        }
        .navigationBarItems(trailing: NavigationLink(destination: AddTaskView()){
            Image(systemName: "pencil")
        })
    }
    
    
    private func dateStyle(date: Date) -> String{
        let formatter1 = DateFormatter()
        formatter1.dateStyle = .short
        return formatter1.string(from: date)
    }
}


struct DetailView_Preview: PreviewProvider {
    static var previews: some View {
        let taskTest = Task(id: "123", title: "test", notes: "test notes", priortyLow: true)
        
        return DetailView(task: taskTest).environmentObject(TaskViewModel())
    }
    
    
}
