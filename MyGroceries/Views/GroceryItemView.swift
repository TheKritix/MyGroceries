//
//  GroceryItemView.swift
//  MyGroceries
//
//  Created by anton dong on 31/03/2022.
//

import Foundation
import SwiftUI

struct GroceryItemView : View {
    
    let boughtItem : BoughtItem?
    
    private let dateFormatter: DateFormatter = {
        let df = DateFormatter()
        df.dateFormat = "MM/dd/yyyy"
        return df
    }()
    
    var body : some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .fill(.white).opacity(0.5)
                
                
            VStack {
                VStack {
                    Text(boughtItem?.groceryType ?? "Grocery")
                    Text("Purchased: \(dateFormatter.string(from: boughtItem?.purchaseDate ?? Date())) \n\nExpires: \(dateFormatter.string(from: boughtItem?.expirationDate ?? Date()))")
                        .font(.system(size: 10))
                   
                   
                    
                        
                }
                .padding()
            }
        }

        
    }
}


struct GroceryItemView_Previews : PreviewProvider {
    static var previews: some View {
        GroceryItemView(boughtItem:
                            BoughtItem.boughtItems.first ?? nil)
        .previewLayout(.sizeThatFits)
    }
}

