//
//  ContentView.swift
//  ToDo_SwiftUI
//
//  Created by Denis Cherniy on 07.07.2020.
//  Copyright © 2020 Denis Cherniy. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State var items: [ToDoItem]
    
    var body: some View {
        NavigationView {
            Form {
                List(items) { item in
                    ToDoRowView(item: item)
                }
            }
            .navigationBarTitle("ToDo", displayMode: .inline)
            .navigationBarItems(leading: Button("Add") {
                print("*** Add tapped!")
            })
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(items: [ToDoItem(id: "abc", name: "Finish App!"),
        ToDoItem(id: "abd", name: "Create Bindings", checked: true)])
    }
}
