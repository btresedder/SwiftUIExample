//
//  RestaurantRow.swift
//  SwiftUIExample
//
//  Created by Brian Tresedder on 11/10/20.
//

import SwiftUI

struct RestaurantRow: View {
    
    @ObservedObject var restaurant: Restaurant
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(restaurant.wrappedName).font(.title)
                Text(restaurant.wrappedCuisine).font(.subheadline)
            }
            Spacer(minLength: 10)
            Text("\(restaurant.reviews?.count ?? 0)")
                .font(.body)
                .background(Circle()
                                .fill(Color.blue)
                                .frame(width: 30, height: 30))
            Spacer().frame(width: 10)
        }
    }
    
    
}

struct RestaurantRow_Previews: PreviewProvider {
    static var previews: some View {
        RestaurantRow(restaurant: Restaurant())
    }
}
