
import SwiftUI

struct AddTaskView: View {
    @State private var taskTitle: String = ""
    @State private var dateDue: Date = Date.now
    @State private var updatedAt: Date = Date.now
    @State private var Notes: String = ""
    @State private var High: Bool = false
    @State private var Med: Bool = false
    @State private var Low: Bool = false
    @State private var Valid: Bool = false
    var task: Task?
    
    
    
    @EnvironmentObject private var viewModel: TaskViewModel
    @Environment(\.dismiss) var dismiss
    var body: some View {
        
            ScrollView{
                HStack(spacing: 20){
                    TextField("To Do Lo...", text: $taskTitle, onCommit: handleSubmit)
                        .padding(20)
                        .overlay(
                            RoundedRectangle(cornerRadius: 30)
                                .stroke(Color.accentColor, lineWidth: 0.5)
                        )
                    
                }
                .padding()
                VStack(spacing: 20) {
                    DatePicker("Date due: ", selection: $dateDue, displayedComponents: .date)
                        .datePickerStyle(.automatic)
                }
                .padding(.leading, 20)
                .padding(.trailing, 20)
                
                Divider()
                    .padding(10)
                
                VStack(spacing: 20) {
                    DatePicker("Created: ", selection: $updatedAt, displayedComponents: .date)
                        .datePickerStyle(.compact)
                }
                .padding(.leading, 20)
                .padding(.trailing, 20)
                
                Divider()
                    .padding(10)
                HStack(spacing: 20) {
                    TextField("Notes to add...", text: $Notes)
                        .frame(height: 200)
                        .padding(20)
                        .overlay(
                        RoundedRectangle(cornerRadius: 30)
                            .stroke(Color.accentColor, lineWidth: 0.5))
                }
                .padding()
                
                Divider()
                    .padding(10)
                
                
                HStack(spacing: 20){
                    Button("High") {
                        High.toggle()
                        
                    }
                    .frame(width:170, height: 50)
                    .background(
                        RoundedRectangle(cornerRadius: 30)
                            .fill(High ? Color.accentColor : Color.white )
                            .shadow(color: .gray, radius: 2, x: 0, y: 2)
                    )
                    .foregroundColor(High ? Color.white : Color.black)
                    
                    Button("Medium") {
                        Med.toggle()
                        
                    }
                    .frame(width:170, height: 50)
                    .background(
                        RoundedRectangle(cornerRadius: 30)
                            .fill(Med ? Color.accentColor : Color.white )
                            .shadow(color: .gray, radius: 2, x: 0, y: 2)
                    )
                    .foregroundColor(Med ? Color.white : Color.black)
                    
                }
                .padding(.bottom, 10)
                
                
                Button("Low") {
                    Low.toggle()
                    
                }
                .frame(width:170, height: 50)
                .background(
                            RoundedRectangle(cornerRadius: 30)
                                .fill(Low ? Color.accentColor : Color.white )
                                .shadow(color: .gray, radius: 2, x: 0, y: 2)
                        )
                .foregroundColor(Low ? Color.white : Color.black)
                
                Divider()
                    .padding(20)
                
                Button("Save") {
                    handleSubmit()
                    dismiss()
                }
                .frame(maxWidth: .infinity)
                .frame(height: 80)
                .disabled(taskTitle.isEmpty)
                .foregroundColor(.white)
                .background(Color.accentColor)
            }
            .navigationTitle("Add A To-Do-Lo")
            .padding(.top, 10)
            
    }
    private func handleSubmit() {
        
        var newTask = Task(id: "1", title: taskTitle, due: dateDue, notes: Notes, completed: false, updatedAt: updatedAt, priortyHigh: High, priortyMed: Med, priortyLow: Low  )
        
        
        viewModel.addTask(title: taskTitle, due: dateDue, notes: Notes, completed: false, updatedAt: updatedAt, priortyHigh: High, priortyMed: Med, priortyLow: Low)
        taskTitle = ""
    }
}

struct AddTaskView_Preview: PreviewProvider {
    static var previews: some View {
       // let task = Task(id: "123", title:"Test", completed: false, updatedAt: Date.now)
        
        return AddTaskView().environmentObject(TaskViewModel())
    }
    
    
}
