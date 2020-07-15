//
//  ContentView.swift
//  ToDo_SwiftUI
//
//  Created by Denis Cherniy on 07.07.2020.
//  Copyright © 2020 Denis Cherniy. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    let databaseGateway: DataStoreGateway
    @State var items: [ToDoItem] = []
    @State private var showingDetail = false {
        didSet {
            if showingDetail == false {
                itemNameToCreate = ""
            }
        }
    }
    @State private var itemNameToCreate = ""
    
    init(databaseGateway: DataStoreGateway) {
        self.databaseGateway = databaseGateway
    }
    
    private var sortedItems: [ToDoItem] {
        let sortedItems = items.sorted { lhs, rhs in
            return lhs.checked != rhs.checked && lhs.checked == false
        }
        return sortedItems
    }
    
    private var createItemSection: some View {
        HStack {
            Button(action: {
                // save item
                self.createItem()
                self.showingDetail = false
            }) {
                Image(systemName: "checkmark")
            }
            .foregroundColor(itemNameToCreate.count == 0 ? .gray : .green)
            .disabled(itemNameToCreate.count == 0)
            
            TextField("Write a new item name...", text: $itemNameToCreate, onCommit: {
                // save item
                self.createItem()
                self.showingDetail = false
            })
            .textFieldStyle(RoundedBorderTextFieldStyle())
            
            Button(action: {
                self.showingDetail = false
            }) {
                Image(systemName: "xmark")
            }
            .foregroundColor(.red)
        }.padding()
    }
    
    var body: some View {
        NavigationView {
            VStack {
                if showingDetail {
                    createItemSection
                }
                
                Form {
                    List {
                        ForEach(sortedItems) { item in
                            ToDoItemView(item: item) {
                                let index = self.items.firstIndex(where: {
                                    $0.id == item.id
                                    })!
                                self.items[index].checked.toggle()
                            }
                        }
                        .onDelete(perform: deleteItem(at:))
                    }
                }
                .navigationBarTitle("ToDo", displayMode: .inline)
                .navigationBarItems(leading: Button("Add") {
                    self.showingDetail.toggle()
                    print("*** Add tapped!")
                }
                .disabled(showingDetail))
                .onAppear() {
                    let fetchedItems = self.databaseGateway.fetchAll()
                    self.items = fetchedItems
                }
            }
        }
    }
}

extension ContentView {
    private func createItem() {
        let item = ToDoItem(id: UUID().uuidString, name: itemNameToCreate)
        items.append(item)
        databaseGateway.insert(item: item)
    }
    
    private func deleteItem(at offsets: IndexSet) {
        let item = items[offsets.first!]
        databaseGateway.delete(item: item)
        items.remove(atOffsets: offsets)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(databaseGateway: CoredataGateway())
    }
}
