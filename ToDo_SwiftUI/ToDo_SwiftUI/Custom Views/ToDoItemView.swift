//
//  ToDoEntry.swift
//  ToDo_SwiftUI
//
//  Created by Denis Cherniy on 07.07.2020.
//  Copyright © 2020 Denis Cherniy. All rights reserved.
//

import SwiftUI

struct ToDoItemView: View {
    var item: ToDoItem
    var onSelection: () -> Void
    
    var body: some View {
        Button(action: {
            self.onSelection()
        }) {
            HStack {
                if item.checked {
                    Image(systemName: "checkmark.circle")
                        .padding()
                } else {
                    Image(systemName: "circle")
                    .padding()
                }
                Text(item.name)
                    .foregroundColor(.primary)
                Spacer()
            }
        }
    }
}

struct ToDoItemView_Previews: PreviewProvider {
    static var previews: some View {
        ToDoItemView(item: ToDoItem(id: "abc", name: "Finish app!", checked: true)) { }
            .previewLayout(.fixed(width: 320, height: 40))
    }
}
