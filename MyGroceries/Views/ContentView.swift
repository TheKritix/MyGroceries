//
//  ContentView.swift
//  MyGroceries
//
//  Created by anton dong on 31/03/2022.
//

import SwiftUI


struct ContentView: View {

    @FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \GroceryItem.groceryType, ascending: true)], animation: .default)
     var groceryItems: FetchedResults<GroceryItem>

    @FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \BoughtItem.groceryType, ascending: true)], animation: .default)
     var boughtItems: FetchedResults<BoughtItem>

    
    var body: some View {
        TabView {
            FridgeView(boughtItems: boughtItems)
                .tabItem {
                    Image(systemName: "1.magnifyingglass")
                    Text("Fridge")
                }
            GroceryListView(boughtItems: boughtItems,groceryItems: groceryItems)
                .tabItem {
                    Image(systemName: "checklist")
                    Text("Grocery List")
                }
    
            AddItemView()
                .tabItem {
                    Image(systemName: "plus")
                    Text("Add item")
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
