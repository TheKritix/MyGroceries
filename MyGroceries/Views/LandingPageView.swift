
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
    
    @State private var animationAmount = 1.0
    
    var body : some View {
            ZStack {
                if (!showContentView){
                    LandingPageFridgeView()
                        .rotation3DEffect(.degrees(animationAmount), axis: (x: 1, y: 0, z: 0))
                    Button(action: {
                       
                    showContentView = true
                        withAnimation(.easeInOut(duration: 1)) {
                                animationAmount += 180
                            
                                
                            }
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
                        .accessibilityIdentifier("landingButton")
                    }
                } else {
                    ContentView()
                           .environment(\.managedObjectContext, persistenceController.container.viewContext)
                           
                }

                
                
                
            }

        

        
        
        
        
        
        
        
    }
}
