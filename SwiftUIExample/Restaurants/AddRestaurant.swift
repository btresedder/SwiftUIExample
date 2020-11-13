//
//  AddRestaurant.swift
//  SwiftUIExample
//
//  Created by Brian Tresedder on 11/10/20.
//

import SwiftUI

struct AddRestaurant: View {
    @Environment(\.managedObjectContext) var managedObjectContext
    
    @FetchRequest(entity: Cuisine.entity(), sortDescriptors: []) var cuisines: FetchedResults<Cuisine>
    
    @State var name = ""
    @State var cuisine = ""
    @State var selectedCuisineIndex = 1
    let onComplete: (String, String) -> Void
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Name")) {
                    TextField("Name", text: $name)
                }
                Section {
                    Picker(selection: $selectedCuisineIndex, label: Text("Cuisine")) {
                        ForEach(0 ..< cuisines.count) {
                            Text(self.cuisines[$0].wrappedType).tag($0)
                        }
                    }
                }
                Section {
                    Button(action: addRestaurantAction) {
                        Text("Add Restaurant")
                    }
                }
            }
            .navigationBarTitle(Text("Add Restaurant"), displayMode: .inline)
        }
    }
    
    private func addRestaurantAction() {
        print("cuisein: \(cuisine)")
        onComplete(
            name,
            cuisines[selectedCuisineIndex].wrappedType
        )
    }
}

struct AddRestaurant_Previews: PreviewProvider {
    static var previews: some View {
        Text("Hello, world!")
    }
}
