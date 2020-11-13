//
//  RestaurantList.swift
//  SwiftUIExample
//
//  Created by Brian Tresedder on 11/10/20.
//

import SwiftUI

struct RestaurantList: View {
    @ObservedObject var viewModel = RestaurantListViewModel()
    
    //var used to determine if the add restaurant view is presented
    @State var isPresented = false
    
    var body: some View {
        NavigationView {
            VStack {
                Picker(selection: $viewModel.segmentedSelected, label: Text("Sort By")) {
                    Text("Name").tag(0)
                    Text("Last Review").tag(1)
                }.pickerStyle(SegmentedPickerStyle())
                List {
                    ForEach(viewModel.restaurants, id: \.id) { restaurant in
                        NavigationLink(destination: ReviewList(restaurant: restaurant)) {
                            RestaurantRow(restaurant: restaurant)
                        }
                    }
                    .onDelete(perform: self.viewModel.deleteRestaurant(at:))
                }
                .sheet(isPresented: $isPresented) {
                    AddRestaurant(onComplete: { name, cuisine in
                        self.viewModel.addRestaurant(name: name, cuisine: cuisine)
                        self.isPresented = false
                    })
                }
                .navigationBarTitle(Text("Foodie"))
                .navigationBarItems(trailing:
                                        Button(action: { self.isPresented.toggle() }) {
                                            Image(systemName: "plus")
                                        }
                )
            }
        }.onAppear {
            self.viewModel.fetchRestaurants()
            self.viewModel.populateCuisines()
        }
    }
}

struct RestaurantList_Previews: PreviewProvider {
    static var previews: some View {
        let context = CoreDataHelper.shared.persistentContainer.viewContext
        RestaurantList().environment(\.managedObjectContext, context)
    }
}
