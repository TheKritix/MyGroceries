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
    var body: some Scene {
        WindowGroup {
            TabView {
                FridgeView()
                    .tabItem {
                        Image(systemName: "1.magnifyingglass")
                        Text("Fridge")
                    }
                Text("Add more items to your grocery list here.")
                    .tabItem {
                        Image(systemName: "plus")
                        Text("Add item")
                    }
            }
            
        }
    }
}
