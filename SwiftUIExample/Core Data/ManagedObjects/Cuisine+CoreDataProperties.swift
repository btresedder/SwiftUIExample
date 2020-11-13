//
//  Cuisine+CoreDataProperties.swift
//  SwiftUIExample
//
//  Created by Brian Tresedder on 11/12/20.
//
//

import Foundation
import CoreData


extension Cuisine {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Cuisine> {
        return NSFetchRequest<Cuisine>(entityName: "Cuisine")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var type: String?

    public var wrappedType: String {
        type ?? "Unknown Cuisine"
    }
    
}

extension Cuisine : Identifiable {

}
