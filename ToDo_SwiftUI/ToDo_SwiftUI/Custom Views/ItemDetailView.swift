//
//  ItemDetailView.swift
//  ToDo_SwiftUI
//
//  Created by Denis Cherniy on 14.07.2020.
//  Copyright © 2020 Denis Cherniy. All rights reserved.
//

import SwiftUI

struct ItemDetailView: View {
    var createItemClosure: (_ itemToCreate: ToDoItem) -> Void
    @State private var itemToCreate: ToDoItem = .init(id: UUID().uuidString, name: "")
    
    var body: some View {
        VStack {
            TextField("Write an item to do...", text: $itemToCreate.name)
            .padding()
            .textFieldStyle(RoundedBorderTextFieldStyle())
        }
    }
}

struct ItemDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ItemDetailView(createItemClosure: {_ in })
    }
}
