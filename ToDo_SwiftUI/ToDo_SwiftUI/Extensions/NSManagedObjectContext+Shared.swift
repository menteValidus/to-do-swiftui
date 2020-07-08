//
//  NSManagedObjectContext+Shared.swift
//  ToDo_SwiftUI
//
//  Created by Denis Cherniy on 08.07.2020.
//  Copyright © 2020 Denis Cherniy. All rights reserved.
//

import CoreData

extension NSManagedObjectContext {

    static var shared: NSManagedObjectContext = {
        let container = NSPersistentContainer(name: "ToDo_SwiftUI")
        container.loadPersistentStores(completionHandler: { storeDescription, error in
            if let error = error {
                fatalError("*** Error at loading persisten store. Error:\n\(error)")
            }
        })
        
        return container.viewContext
    }()
    
}

struct DataModelDB {
    static let name = "ToDo_SwiftUI"
    
    struct Entities {
        struct ItemEntity {
            static let name = "Item"
            
            struct KeyPathNames {
                static let name = "name"
                static let checked = "checked"
            }
        }
            
    }
}
