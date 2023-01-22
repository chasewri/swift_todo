//
//  ContentView.swift
//  MacLandmarks
//
//  Created by Chase Wright on 1/21/23.
//

import SwiftUI

struct ContentView: View {
    @State private var newTodoInput: String = ""
    @State private var allTodos: [TodoItem] = []
    
    private func saveTodos() {
        UserDefaults.standard.set(try? PropertyListEncoder().encode(self.allTodos), forKey: "myTodosKey")
    }
    
    private func loadTodos() {
        if let todosData = UserDefaults.standard.value(forKey: "myTodosKey") as? Data {
            if let todosList = try? PropertyListDecoder().decode(Array<TodoItem>.self, from: todosData) {
                self.allTodos = todosList
            }
        }
    }
    
    private func deleteTodos() {
        self.allTodos.removeAll(where: { $0.isComplete == true })
        saveTodos()
    }
    
    private func onSubmitTodo() {
        guard !self.newTodoInput.isEmpty else {return}
        
        allTodos.append(TodoItem(todo: self.newTodoInput))
        self.newTodoInput = ""
        self.saveTodos()
    }
    
    var body: some View {
        
        VStack {
            Text("Todos").fontWeight(.bold).font(.largeTitle).multilineTextAlignment(.center).padding(.top)
            
            HStack {
                TextField( "New Todo", text: $newTodoInput).onSubmit(self.onSubmitTodo)
                
                Button(action: {
                    self.onSubmitTodo()
                    
                }) {
                    Image(systemName: "text.badge.plus")
                }.buttonStyle(.borderedProminent)
            }.padding([.leading, .bottom, .trailing], 100)
            
            Button("Delete All") {
                self.deleteTodos()
            }
            
            List($allTodos) { todo in
                HStack{
                    Text(todo.todo.wrappedValue).frame(maxWidth: .infinity, alignment: .center)
                    Toggle(isOn: todo.isComplete) {
                        Text("Completed")
                    }
                    .padding(.trailing)
                }.padding(.all).background(Color.gray.opacity(0.3)).cornerRadius(10)
                
            }
            
        }.onAppear{
            self.loadTodos()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

