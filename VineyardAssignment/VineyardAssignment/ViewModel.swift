import Combine
import Foundation

class TaskViewModel: ObservableObject {
    @Published var tasks: [Task] = []

    func addTask(name: String) {
        let newTask = Task(name: name)
        tasks.append(newTask)
    }

    func toggleCompletion(of task: Task) {
        if let index = tasks.firstIndex(where: { $0.id == task.id }) {
            tasks[index].isCompleted.toggle()
        }
    }

    func deleteTask(at offsets: IndexSet) {
        tasks.remove(atOffsets: offsets)
    }
}
