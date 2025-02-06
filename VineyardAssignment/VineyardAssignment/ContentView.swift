import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = TaskViewModel()
    @State private var newTaskName: String = ""

    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    TextField("Enter new task", text: $newTaskName)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding()
                    Button(action: {
                        guard !newTaskName.isEmpty else { return }
                        viewModel.addTask(name: newTaskName)
                        newTaskName = ""
                    }) {
                        Image(systemName: "plus.circle.fill")
                            .font(.largeTitle)
                            .padding()
                    }
                }
                .padding()

                List {
                    ForEach(viewModel.tasks) { task in
                        HStack {
                            Text(task.name)
                            Spacer()
                            Button(action: {
                                viewModel.toggleCompletion(of: task)
                            }) {
                                Image(systemName: task.isCompleted ? "checkmark.circle.fill" : "circle")
                                    .foregroundColor(task.isCompleted ? .green : .gray)
                            }
                        }
                    }
                    .onDelete(perform: viewModel.deleteTask) // Use without the $
                }
                .listStyle(PlainListStyle())
            }
            .navigationBarTitle("To-Do List")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
