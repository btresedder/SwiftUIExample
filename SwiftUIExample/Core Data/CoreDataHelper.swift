//
//  CoreDataHelper.swift
//  SwiftUIExample
//
//  Created by Brian Tresedder on 11/12/20.
//

import Foundation
import CoreData


protocol CoreDataHelperProtocol {
    var context: NSManagedObjectContext { get }
    
    func create(_ object: NSManagedObject)
    func fetch<T: NSManagedObject>(_ objectType: T.Type, predicate: NSPredicate?, sort: NSSortDescriptor?, limit: Int?) -> Result<[T], Error>
    func update(_ object: NSManagedObject)
    func delete(_ object: NSManagedObject)
}

class CoreDataHelper: CoreDataHelperProtocol {
        
    
    static let shared = CoreDataHelper()
    
    var context: NSManagedObjectContext {
        get {
            persistentContainer.viewContext
        }
    }

    func create(_ object: NSManagedObject) {
        do {
            try context.save()
        } catch {
            fatalError("error saving context while creating an object")
        }
    }
    
    func fetch<T: NSManagedObject>(_ objectType: T.Type, predicate: NSPredicate? = nil, sort: NSSortDescriptor? = nil, limit: Int? = nil) -> Result<[T], Error> {
        let request = objectType.fetchRequest()
        request.predicate = predicate
        if let sort = sort {
            request.sortDescriptors = [sort]
        }
        if let limit = limit {
            request.fetchLimit = limit
        }
        do {
            let result = try context.fetch(request)
            return .success(result as? [T] ?? [])
        } catch {
            return .failure(error)
        }
    }
    
    func update(_ object: NSManagedObject) {
        do {
            try context.save()
        } catch {
            fatalError("error saving context while updating an object")
        }
    }
    
    func delete(_ object: NSManagedObject) {
        context.delete(object)
        do {
            try context.save()
        } catch {
            fatalError("error saving context while deleting an object")
        }
    }
    
    // MARK: - Core Data
    lazy var persistentContainer: NSPersistentCloudKitContainer = {
        let container = NSPersistentCloudKitContainer(name: "SwiftUIExample")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}
