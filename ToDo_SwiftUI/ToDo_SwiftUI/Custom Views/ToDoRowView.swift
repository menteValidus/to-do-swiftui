//
//  ToDoEntry.swift
//  ToDo_SwiftUI
//
//  Created by Denis Cherniy on 07.07.2020.
//  Copyright © 2020 Denis Cherniy. All rights reserved.
//

import SwiftUI

struct ToDoRowView: View {
    var item: ToDoItem
    
    var body: some View {
        HStack {
            if item.checked {
                Image(systemName: "checkmark.circle")
                    .padding()
            } else {
                Image(systemName: "circle")
                .padding()
            }
            Text(item.name)
            Spacer()
        }
    }
}

struct ToDoRowView_Previews: PreviewProvider {
    static var previews: some View {
        ToDoRowView(item: ToDoItem(id: "abc", name: "Finish app!", checked: true))
            .previewLayout(.fixed(width: 320, height: 40))
    }
}
