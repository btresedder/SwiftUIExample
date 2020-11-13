//
//  ReviewRow.swift
//  SwiftUIExample
//
//  Created by Brian Tresedder on 11/12/20.
//

import SwiftUI

struct ReviewRow: View {
    //date formatter
    static let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        return formatter
    }()
    
    
    let review: Review
    
    var body: some View {
        HStack {
            Text("\(review.rating, specifier: "%.1f")").font(.body)
            VStack(alignment: .leading) {
                Text(review.body ?? "").font(.body)
                Text(Self.dateFormatter.string(from: review.date ?? Date())).font(.caption)
            }
            
        }
    }
}

struct ReviewRow_Previews: PreviewProvider {
    static var previews: some View {
        ReviewRow(review: Review())
    }
}
