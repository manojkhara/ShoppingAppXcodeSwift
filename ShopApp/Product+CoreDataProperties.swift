//
//  Product+CoreDataProperties.swift
//  myShopTask
//
//  Created by Manoj 07 on 29/08/22.
//
//

import Foundation
import CoreData


extension Product {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Product> {
        return NSFetchRequest<Product>(entityName: "Product")
    }

    @NSManaged public var productImage: Data?
    @NSManaged public var productName: String?
    @NSManaged public var productCategory: String?
    @NSManaged public var productPrice: Double

}

extension Product : Identifiable {

}
