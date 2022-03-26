//
//  FridgeGridView.swift
//  MyGroceries
//
//  Created by anton dong on 09/03/2022.
//

import Foundation
import SwiftUI

struct FridgeGridView : View {
    
    @FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \GroceryItem.groceryType, ascending: true)], animation: .default)
    private var groceryItems: FetchedResults<GroceryItem>
    
    private var columns = [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())]
    
   
    var body : some View {
        VStack {
            ZStack {
                RoundedRectangle(cornerRadius: 50)
                    .fill(.gray)
                    .brightness(0.35)
                VStack {
                    HStack {
                        Text("My fridge")
                            .padding(5)
                            .background(.white)
                            .cornerRadius(15)
                    }
                    .padding(10)
                    ZStack {
                        RoundedRectangle(cornerRadius: 16.0)
                            .fill(.teal)
                            .opacity(0.4)
                        ScrollView {
                            LazyVGrid(columns: columns, spacing: 10) {
                                ForEach(groceryItems, id: \.self) { item in
                                    HStack {
                                        if (item.bought){
                                            Text((item.groceryType ?? "unknown item") as String)
                                        }
                                        
                                    }
                                }
                                .padding()
                            }
                        }
                    }
                    .frame(width: 360)
                }
            }
        }
        .padding(.top)
        
    }
}


struct FridgeGridView_Previews: PreviewProvider {
    static var previews: some View {
        FridgeGridView()
    }
}
