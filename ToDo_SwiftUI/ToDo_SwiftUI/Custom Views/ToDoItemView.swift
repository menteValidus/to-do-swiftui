//
//  ToDoEntry.swift
//  ToDo_SwiftUI
//
//  Created by Denis Cherniy on 07.07.2020.
//  Copyright © 2020 Denis Cherniy. All rights reserved.
//

import SwiftUI

struct ToDoItemView: View {
    @Binding var item: ToDoItem
    
    var body: some View {
        Button(action: {
            self.item.checked.toggle()
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
        ToDoItemView(item: .constant(ToDoItem(id: "abc", name: "Finish app!", checked: true)))
            .previewLayout(.fixed(width: 320, height: 40))
    }
}
