//
//  Review+CoreDataProperties.swift
//  SwiftUIExample
//
//  Created by Brian Tresedder on 11/12/20.
//
//

import Foundation
import CoreData


extension Review {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Review> {
        return NSFetchRequest<Review>(entityName: "Review")
    }

    @NSManaged public var date: Date?
    @NSManaged public var body: String?
    @NSManaged public var rating: Double
    @NSManaged public var restaurant: Restaurant?

    public var wrappedBody: String {
        body ?? "no review left"
    }
    
}

extension Review : Identifiable {

}
