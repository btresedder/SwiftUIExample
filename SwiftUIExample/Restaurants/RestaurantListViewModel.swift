//
//  RestaurantListViewModel.swift
//  SwiftUIExample
//
//  Created by Brian Tresedder on 11/12/20.
//

import Foundation

class RestaurantListViewModel: ObservableObject {
    
    @Published var restaurants = [Restaurant]()
    
    @Published var segmentedSelected: Int = 0 {
        didSet {
            print("in did set")
            fetchRestaurants()
        }
    }
    
    var coreDataHelper: CoreDataHelperProtocol
    
    //NOTE: For testability we use dependency injection. We could create a mock class that conforms to the CoreDataHelperProtocol and pass that in to test the view model.
    init(coreDataHelper: CoreDataHelperProtocol = CoreDataHelper.shared) {
        self.coreDataHelper = coreDataHelper
    }
    
    func fetchRestaurants() {
        var sort = NSSortDescriptor()
        if segmentedSelected == 0 {
            sort = NSSortDescriptor(keyPath: \Restaurant.name, ascending: true)
        } else {
            sort = NSSortDescriptor(keyPath: \Restaurant.lastReviewDate, ascending: false)
        }
        
        let result: Result<[Restaurant], Error> = coreDataHelper.fetch(Restaurant.self, predicate: nil, sort: sort, limit: nil)
        switch result {
        case .success(let restaurants):
            self.restaurants = restaurants
        case .failure(let error):
            fatalError(error.localizedDescription)
        }
        
    }
    
    func deleteRestaurant(at offsets: IndexSet) {
        offsets.forEach { index in
            let restaurant = self.restaurants[index]
            
            self.coreDataHelper.delete(restaurant)
        }
        fetchRestaurants()
    }
    
    func addRestaurant(name: String, cuisine: String) {
        
        let restaurant = Restaurant(context: coreDataHelper.context)
        restaurant.name = name
        restaurant.cuisine = cuisine
        restaurant.id = UUID()
        coreDataHelper.create(restaurant)
        
        fetchRestaurants()
    }
    
    
    func populateCuisines() {
        let defaults = UserDefaults.standard
        
        if !defaults.bool(forKey: "shouldPopulateCuisines") {
            
            //NOTE: This could be done in a much better way, like reading in from a file, but I was running short on time.
            let cuisine1 = Cuisine(context: coreDataHelper.context)
            cuisine1.type = "American"
            cuisine1.id = UUID()
            coreDataHelper.create(cuisine1)
            
            let cuisine2 = Cuisine(context: coreDataHelper.context)
            cuisine2.type = "Mexican"
            cuisine2.id = UUID()
            coreDataHelper.create(cuisine2)
            
            let cuisine3 = Cuisine(context: coreDataHelper.context)
            cuisine3.type = "BBQ"
            cuisine3.id = UUID()
            coreDataHelper.create(cuisine3)
        
            defaults.set(true, forKey: "shouldPopulateCuisines")
        }
    }
}
