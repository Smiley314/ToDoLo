import Combine
import FirebaseDatabase
import FirebaseDatabaseSwift
import Foundation


class TaskViewModel: ObservableObject {
    // 3
    @Published var tasks = [Task]()
    
    private let ref = Database.database().reference()
    private let dbPath = "tasks"
    // 4
    init() {
        initListener()
    }
    
    func initListener() {
        ref.child(dbPath).observe(.value) { snapshot in
            // 5
            guard let children = snapshot.children.allObjects as? [DataSnapshot] else {
                return
            }
            // 6
            self.tasks = children.compactMap { snapshot in
                // 7
                return try? snapshot.data(as: Task.self)
            }
            .sorted(by: { $0.updatedAt > $1.updatedAt })
            .sorted(by: { !$0.completed && $1.completed })
        }
    }
    // 8
    func addTask(title: String, due: Date, notes: String, completed: Bool, updatedAt: Date, priortyHigh: Bool, priortyMed: Bool, priortyLow: Bool) {
        
        
        guard let autoID = ref.child(dbPath).childByAutoId().key else {
            return
        }
        
        let NewTask = Task(id: autoID, title: title, due: due, notes: notes, completed: false, updatedAt: updatedAt, priortyHigh: priortyHigh, priortyMed: priortyMed, priortyLow: priortyLow)
        
        do {
            try ref.child("\(dbPath)/\(NewTask.id)")
                .setValue(from: NewTask)
        } catch let error {
            print(error.localizedDescription)
        }
    }
    // 9
    func markComplete(id: String, completed: Bool) {
        ref.child("\(dbPath)/\(id)")
            .updateChildValues([
                "completed": completed,
                //"updatedAt": Date().timeIntervalSince1970
            ])
    }
    // 10
    func remove(id: String) {
        ref.child("\(dbPath)/\(id)").setValue(nil)
    }
    
    func removeAll() {
        for task in tasks {
            if task.completed {
                ref.child("\(dbPath)/\(task.id)").setValue(nil)
            }
        }
        
    }
}


