//
//  Category+CoreDataProperties.swift
//  myShopTask
//
//  Created by Manoj 07 on 29/08/22.
//
//

import Foundation
import CoreData


extension Category {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Category> {
        return NSFetchRequest<Category>(entityName: "Category")
    }

    @NSManaged public var categoryName: String?
    @NSManaged public var categoryImage: Data?

}

extension Category : Identifiable {

}
