//
//  Restaurant+CoreDataProperties.swift
//  SwiftUIExample
//
//  Created by Brian Tresedder on 11/12/20.
//
//

import Foundation
import CoreData


extension Restaurant {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Restaurant> {
        return NSFetchRequest<Restaurant>(entityName: "Restaurant")
    }

    @NSManaged public var cuisine: String?
    @NSManaged public var id: UUID?
    @NSManaged public var name: String?
    @NSManaged public var reviews: NSSet?
    @NSManaged public var lastReviewDate: Date?

    public var wrappedName: String {
        name ?? "Default Name"
    }
    
    public var wrappedCuisine: String {
        cuisine ?? ""
    }
    
}

// MARK: Generated accessors for review
extension Restaurant {

    @objc(addReviewObject:)
    @NSManaged public func addToReviews(_ value: Review)

    @objc(removeReviewObject:)
    @NSManaged public func removeFromReviews(_ value: Review)

    @objc(addReview:)
    @NSManaged public func addToReviews(_ values: NSSet)

    @objc(removeReview:)
    @NSManaged public func removeFromReviews(_ values: NSSet)

}

extension Restaurant : Identifiable {

}
