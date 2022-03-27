//
//  MyGroceriesApp.swift
//  MyGroceries
//
//  Created by KRTP Project on 03/03/2022.
//
//

import SwiftUI

@main
struct MyGroceriesApp: App {
    
    @Environment(\.managedObjectContext) var managedObjectContext
    
    let persistenceController = PersistenceController.shared
    
    @FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \GroceryItem.groceryType, ascending: true)], animation: .default)
    private var items: FetchedResults<GroceryItem>
    
    var body: some Scene {
        WindowGroup {
            TabView {
                FridgeView()
                    .tabItem {
                        Image(systemName: "1.magnifyingglass")
                        Text("Fridge")
                    }
                    .environment(\.managedObjectContext, persistenceController.container.viewContext)
                GroceryList()
                    .tabItem {
                        Image(systemName: "checklist")
                        Text("Grocery List")
                    }
                    .environment(\.managedObjectContext, persistenceController.container.viewContext)
                AddItemView()
                    .tabItem {
                        Image(systemName: "plus")
                        Text("Add item")
                    }
                    .environment(\.managedObjectContext, persistenceController.container.viewContext)
            }
            .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
        
    }
}
    
