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
                self.createItem()
                self.showingDetail = false
            }) {
                Image(systemName: "checkmark")
            }
            .foregroundColor(itemNameToCreate.count == 0 ? .gray : .green)
            .disabled(itemNameToCreate.count == 0)
            
            TextField("Write a new item name...", text: $itemNameToCreate, onCommit: {if self.itemNameToCreate.count > 0 {
                    self.createItem()
                    self.showingDetail = false
                }
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
    
    private var leadingNavigationBarItem: some View {
        if showingDetail {
            return Button("Cancel") {
                self.showingDetail.toggle()
            }
            .foregroundColor(.red)
        } else {
            return Button("Add") {
                self.showingDetail.toggle()
            }
            .foregroundColor(.accentColor)
        }
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
                            ToDoItemView(item: self.$items[self.indexInItems(of: item)])
                        }
                        .onDelete(perform: deleteItem(at:))
                    }
                }
                .navigationBarTitle("ToDo", displayMode: .inline)
                .navigationBarItems(leading: leadingNavigationBarItem)
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
    
    private func editItem(at offsets: IndexSet) {
        
    }
    
    private func indexInItems(of item: ToDoItem) -> Int {
        let index = self.items.firstIndex(where: {
        $0.id == item.id
        })!
        
        return index
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(databaseGateway: CoredataGateway())
    }
}
