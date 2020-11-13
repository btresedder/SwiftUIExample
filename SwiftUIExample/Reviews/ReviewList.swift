//
//  ReviewList.swift
//  SwiftUIExample
//
//  Created by Brian Tresedder on 11/12/20.
//

import SwiftUI

struct ReviewList: View {
    @ObservedObject var viewModel = ReviewListViewModel()
    
    init(restaurant: Restaurant) {
        self.viewModel.restaurant = restaurant
    }
    
    
    //var used to determine if the add restaurant view is presented
    @State var isPresented = false
    
    var body: some View {
        VStack {
            Text("Reviews for \(self.viewModel.restaurant?.wrappedName ?? "")").font(.title)
            Text("\(self.viewModel.restaurant?.wrappedCuisine ?? "")").font(.callout)
            List {
                ForEach(self.viewModel.reviews, id: \.id) { review in
                    ReviewRow(review: review)
                }
            }
            .sheet(isPresented: $isPresented) {
                AddReview(onComplete: { reviewBody, date, rating in
                    //self.viewModel.addReview(body: reviewBody, date: date, rating: rating)
                    self.viewModel.addReview(body: reviewBody, date: date, rating: rating)
                    self.isPresented = false
                })
            }
            .navigationBarItems(trailing:
                                    Button(action: { self.isPresented.toggle() }) {
                                        Image(systemName: "plus")
                                    }
            )
        }
        .onAppear {
            self.viewModel.fetchReviews()
        }
        
    }
}

struct ReviewList_Previews: PreviewProvider {
    static var previews: some View {
        ReviewList(restaurant: Restaurant())
    }
}
