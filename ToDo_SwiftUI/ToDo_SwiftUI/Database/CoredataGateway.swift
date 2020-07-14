//
//  CoredataGateway.swift
//  ToDo_SwiftUI
//
//  Created by Denis Cherniy on 08.07.2020.
//  Copyright © 2020 Denis Cherniy. All rights reserved.
//

import CoreData

protocol DataStoreGateway {
    func fetchAll() -> [ToDoItem]
    func insert(item: ToDoItem)
    func update(item: ToDoItem)
    func delete(item: ToDoItem)
}

class CoredataGateway: DataStoreGateway {
    lazy var managedObjectContext: NSManagedObjectContext = {
        return NSManagedObjectContext.shared
    }()
    
    func fetchAll() -> [ToDoItem] {
        let pointsFetch = NSFetchRequest<NSFetchRequestResult>(entityName: DataModelDB.Entities.ItemEntity.name)
        let fetchedItems: [ItemEntity]
        do {
            fetchedItems = try managedObjectContext.fetch(pointsFetch) as! [ItemEntity]
        } catch {
            fatalError("*** Failed to fetch all RoutePoint's date.\n\(error)")
        }
        
        var items: [ToDoItem] = []
        
        for item in fetchedItems {
            items.append(convertEntityToItem(item))
        }
        
        return items
    }
    
    func insert(item: ToDoItem) {
        let entityDescription = NSEntityDescription.entity(forEntityName: DataModelDB.Entities.ItemEntity.name, in: managedObjectContext)!
        
        let itemEntity = NSManagedObject(entity: entityDescription, insertInto: managedObjectContext) as! ItemEntity
        configure(itemEntity: itemEntity, with: item)
        
        do {
            try managedObjectContext.save()
        } catch {
            fatalError("*** Insert's Error:\n\(error)")
        }
    }
    
    func update(item: ToDoItem) {
        
    }
    
    func delete(item: ToDoItem) {
        
    }
    
    // MARK: Helper Methods
    
    private func convertEntityToItem(_ entity: ItemEntity) -> ToDoItem {
        let item = ToDoItem(id: entity.id, name: entity.name, checked: entity.checked)
        
        return item
    }
    
    private func configure(itemEntity: ItemEntity, with item: ToDoItem) {
        itemEntity.id = item.id
        itemEntity.name = item.name
        itemEntity.checked = item.checked
    }
}
