
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
                    RoundedRectangle(cornerRadius: 50)
                        .fill(.gray)
                        .brightness(0.35)
                    VStack {
                            Text("My fridge")
                                .padding(5)
                                .background(.white)
                                .cornerRadius(15)
                        ZStack {
                            RoundedRectangle(cornerRadius: 30.0)
                                .fill(.white)
                                .opacity(0.4)
                        }
                        .frame(width: 360, height: 200)
                        ZStack {
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
                                        .background(Color.orange)
                                        .cornerRadius(20.0)
                                        .foregroundColor(Color.white)
                                        .padding(10)

                                
                                    
                            }
                            
                            
                            RoundedRectangle(cornerRadius: 30.0)
                                .fill(.white)
                                .opacity(0.4)
                            
                            ZStack {
                                RoundedRectangle(cornerRadius: 30.0)
                                    .fill(.black)
                                    .opacity(0.2)

                            }.frame(width: 10, height: 550)
                        }
                        .frame(width: 360, height: 550)
                        .padding()

                    }
            }
            
            .navigationBarBackButtonHidden(true)
            }

}

struct LandingPageView_Previews: PreviewProvider {
    static var previews: some View {
        LandingPageView()
    }
}
