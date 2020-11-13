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
        VStack(alignment: .leading){
            Text(Self.dateFormatter.string(from: review.date ?? Date())).font(.headline)
            Spacer().frame(height: 15)
            HStack {
                Text("\(review.rating, specifier: "%.1f")")
                    .font(.body)
                    .background(Circle()
                                    .fill(Color.blue)
                                    .frame(width: 40, height: 40))
                Spacer().frame(width: 20)
                Text(review.body ?? "").font(.body)
            }
            Spacer(minLength: 10)
        }
    }
}

struct ReviewRow_Previews: PreviewProvider {
    static var previews: some View {
        ReviewRow(review: Review())
    }
}
