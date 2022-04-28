
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
    @State var showContentView: Bool = false
    
    var body : some View {
            ZStack {
                if (!showContentView){
                    LandingPageFridgeView()
                    Button(action: {
                    showContentView = true

                    }){
                        HStack {
                            Text("Open my fridge")
                                .fontWeight(.bold)
                                .font(.title)
                            Image(systemName: "hand.tap")
                        }
                        .padding()
                        .background(.orange)
                        .cornerRadius(20.0)
                        .foregroundColor(.white)
                        .padding(10)
                    }
                } else {
                    ContentView()
                           .environment(\.managedObjectContext, persistenceController.container.viewContext)
                }

            }

        

        
        
        
        
        
        
        
    }
}
