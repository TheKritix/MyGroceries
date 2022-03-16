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
    
    let persistenceController = PersistenceController.shared
    
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
                AddItem()
                    .tabItem {
                        Image(systemName: "plus")
                        Text("Add item")
                    }
                    .environment(\.managedObjectContext, persistenceController.container.viewContext)
            }
            .onChange(of: scenePhase) { _ in
                persistenceController.save()
            }
            
        }
    }
}
