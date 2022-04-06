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
            ContentView()
            .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
        
    }
}
    
