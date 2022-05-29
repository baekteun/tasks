import SwiftUI
import CoreData

final class TaskViewModel: ObservableObject {
    @Published var currentTab: String = "Today"
    
    // MARK: - New Task Properties
    @Published var openEditTask: Bool = false
    @Published var taskTitle: String = ""
    @Published var taskColor: String = "Yellow"
    @Published var taskDeadline = Date()
    @Published var taskType: String = "Basic"
    @Published var showDatePicker = false
    
    @Published var editTask: Item?
    
    // MARK: - Adding Task to core data
    func addTask(context: NSManagedObjectContext) -> Bool {
        // MARK: - Updating Task
        var task: Item!
        if let editTask = editTask {
            task = editTask
        } else {
            task = Item(context: context)
        }
        task.title = taskTitle
        task.color = taskColor
        task.deadline = taskDeadline
        task.type = taskType
        task.isCompleted = false
        
        if let _ = try? context.save() {
            return true
        }
        return false
    }
    
    // MARK: - Reset Data
    func resetTaskData() {
        taskType = "Basic"
        taskColor = "Yellow"
        taskTitle = ""
        taskDeadline = Date()
        editTask = nil
    }
    
    func setUpTask() {
        guard let editTask = editTask else {
            return
        }
        taskType = editTask.type ?? "Basic"
        taskTitle = editTask.title ?? ""
        taskColor = editTask.color ?? "Yellow"
        taskDeadline = editTask.deadline ?? .init()
        
    }
}
