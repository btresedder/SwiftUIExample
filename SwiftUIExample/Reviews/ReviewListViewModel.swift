//
//  ReviewListViewModel.swift
//  SwiftUIExample
//
//  Created by Brian Tresedder on 11/12/20.
//

import Foundation

class ReviewListViewModel: ObservableObject {
    
    @Published var reviews = [Review]()
    
    var coreDataHelper: CoreDataHelperProtocol
    var restaurant: Restaurant?
    
    init(coreDataHelper: CoreDataHelperProtocol = CoreDataHelper.shared) {
        self.coreDataHelper = coreDataHelper
    }
    
    func fetchReviews() {
        if let restaurant = self.restaurant {
            let result: Result<[Review], Error> = coreDataHelper.fetch(Review.self, predicate: NSPredicate(format: "restaurant == %@", restaurant), sort: nil, limit: nil)
            switch result {
            case .success(let reviews):
                self.reviews = reviews
            case .failure(let error):
                //NOTE: We should properly handle the error here and display a user friendly message
                fatalError(error.localizedDescription)
            }
        }
    }
    
    func addReview(body: String, date: Date, rating: Double) {
        let review = Review(context: coreDataHelper.context)
        review.body = body
        review.date = date
        review.rating = rating
        review.restaurant = restaurant
        coreDataHelper.create(review)
        
        if let restaurant = restaurant {
            restaurant.lastReviewDate = Date()
            coreDataHelper.update(restaurant)
        }

        
        fetchReviews()
    }
}
