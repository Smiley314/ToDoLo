import SwiftUI

struct To_do_List: View {
    @EnvironmentObject private var viewModel: TaskViewModel
    
    @Environment(\.presentationMode) var presentationMode
    @State private var quickTask: String = ""
    @State private var showingConfirm = false
    @State private var compleTask = []
    
    var body: some View {
        
        VStack (alignment: .leading) {
                Text("To Do Lo's")
                    .padding()
                    .font(.title)
                    .fontWeight(.bold)
            
            Divider()
                .padding(.leading, 20)
                .padding(.trailing, 20)
            
            HStack(spacing: 12) {
                        TextField("Enter New Task..", text: $quickTask, onCommit: quickAdd)
                        Button(action: quickAdd) {
                            Image(systemName: "plus")
                        }
                    }
                    .padding(20)
            
                ScrollView {
                    Divider()
                        .padding(.init(top: 0, leading: 20, bottom: 0, trailing: 20))
                    ForEach(viewModel.tasks, id: \.id) { task in
                        
                        NavigationLink(destination: DetailView(task: task)) {
                            Task_List_View(task: task)
                                
                        }
                        
                    }
                    
                    
                }
            
                .animation(.default)
            }
            //.navigationBarTitle("ToDo-Lo")
            .navigationBarItems(trailing: NavigationLink(destination: AddTaskView()){
                Image(systemName: "plus.circle.fill")
            })
            .navigationBarItems(trailing: NavigationLink(destination: AddTaskView()){
                Image(systemName: "xmark.circle.fill")
                                        .imageScale(.large)
                                        .frame(width: 44, height: 44, alignment: .trailing)
                                        .onTapGesture {
                                            self.showingConfirm = true
                                        }
                                        .confirmationDialog("Confirm clear?", isPresented: $showingConfirm) {
                                            Button("Clear", role: .destructive) {
                                                viewModel.removeAll()
                                            }
                                            Button("Cancel", role: .cancel) {
                                                // Dismiss the confirm window
                                            }
                                        }
            })
        
        
    }
        
    private func quickAdd() -> Void {
        viewModel.addTask(title: quickTask, due: Date.now, notes: "", completed: false, updatedAt: Date.now, priortyHigh: false, priortyMed: false, priortyLow: false)
        quickTask = ""
    }
    
    private func deleteRow(indexSet: IndexSet) {
        guard let index = indexSet.first else { return }
        let taskId = viewModel.tasks[index].id
        viewModel.remove(id: taskId)
    }
}


struct To_do_list_Preview: PreviewProvider {
    static var previews: some View {
        return To_do_List().environmentObject(TaskViewModel())
    }
    
    
}
