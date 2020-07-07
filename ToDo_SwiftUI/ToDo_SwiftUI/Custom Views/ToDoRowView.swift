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
            Image(systemName: "checkmark")
                .padding()
                .foregroundColor(.gray)
            Text(item.name)
            Spacer()
        }
    }
}

struct ToDoRowView_Previews: PreviewProvider {
    static var previews: some View {
        ToDoRowView(item: ToDoItem(name: "Finish app!"))
            .previewLayout(.fixed(width: 320, height: 40))
    }
}
