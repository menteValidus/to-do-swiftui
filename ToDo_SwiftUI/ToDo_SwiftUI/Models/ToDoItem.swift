//
//  ToDoItem.swift
//  ToDo_SwiftUI
//
//  Created by Denis Cherniy on 07.07.2020.
//  Copyright © 2020 Denis Cherniy. All rights reserved.
//

import Foundation

protocol ItemProtocol {
    var id: String { get }
    var name: String { get set }
    var checked: Bool { get set }
}

typealias Item = Identifiable & ItemProtocol

struct ToDoItem: Item {
    let id: String
    
    var name: String
    var checked: Bool = false
}
