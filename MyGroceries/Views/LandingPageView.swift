
//
//  FridgeGridView.swift
//  MyGroceries
//
//  Created by anton dong on 09/03/2022.
//

import Foundation
import SwiftUI

struct LandingPageView : View {
    
    let persistenceController = PersistenceController.shared
    
    var body : some View {
        ZStack {
            LandingPageFridgeView()
            NavigationLink(
                destination: ContentView()
                    .environment(\.managedObjectContext, persistenceController.container.viewContext)
                    .navigationBarBackButtonHidden(true)
            ){
                
                HStack {
                    Text("Open my fridge")
                        .fontWeight(.bold)
                        .font(.title)
                    Image(systemName: "hand.tap")
                }
                .padding()
                .background(Color.blue)
                .cornerRadius(20.0)
                .foregroundColor(Color.white)
                .padding(10)
                
                
                
            }
            
        }
        
        
        
        
        
        
        
    }
}
