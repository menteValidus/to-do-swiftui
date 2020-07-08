//
//  ItemEntity+CoreDataProperties.swift
//  ToDo_SwiftUI
//
//  Created by Denis Cherniy on 08.07.2020.
//  Copyright © 2020 Denis Cherniy. All rights reserved.
//
//

import Foundation
import CoreData


extension ItemEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ItemEntity> {
        return NSFetchRequest<ItemEntity>(entityName: "ItemEntity")
    }

    @NSManaged public var id: String
    @NSManaged public var checked: Bool
    @NSManaged public var name: String

}
