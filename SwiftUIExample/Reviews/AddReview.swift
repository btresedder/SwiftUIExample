//
//  AddReview.swift
//  SwiftUIExample
//
//  Created by Brian Tresedder on 11/12/20.
//

import SwiftUI

struct AddReview: View {
    //@Environment(\.managedObjectContext) var managedObjectContext
    
    //@FetchRequest(entity: Cuisine.entity(), sortDescriptors: []) var cuisines: FetchedResults<Cuisine>
        
    @State var reviewBody = ""
    @State var reviewDate = Date()
    @State var rating: Double = 0
    
    let onComplete: (String, Date, Double) -> Void
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Review Description")) {
                    TextField("Description", text: $reviewBody)
                }
                Section {
                    DatePicker(
                        selection: $reviewDate,
                        displayedComponents: .date) {
                        Text("Review Date").foregroundColor(Color(.gray))
                    }
                }
                Section {
                    VStack {
                        Text("Rating: \(rating, specifier: "%.1f") stars")
                        Slider(value: $rating, in: 0...5, step: 0.5)
                    }
                }
                Section {
                    Button(action: addReviewAction) {
                        Text("Add Review")
                    }
                }
            }
            .navigationBarTitle(Text("Add Review"), displayMode: .inline)
        }
    }
    
    private func addReviewAction() {
        onComplete(
            reviewBody,
            reviewDate,
            rating
        )
    }
}

struct AddReview_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
