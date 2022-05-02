//
//  GroceryItemView.swift
//  MyGroceries
//
//  Created by anton dong on 31/03/2022.
//

import Foundation
import SwiftUI

struct InformationBoxView : View {
    

    let boughtItem : BoughtItem?
    
    private let dateFormatter: DateFormatter = {
        let df = DateFormatter()
        df.dateFormat = "MM/dd/yyyy"
        return df
    }()
    
    
    var body : some View {
        let days = Calendar.current.numberOfDaysBetween(boughtItem?.expirationDate ?? Date(), and: Date())
        ZStack {
                RoundedRectangle(cornerRadius: 20)
                .fill(.white)
                
            VStack {
                if (boughtItem?.groceryType != nil){
                    Text(boughtItem?.groceryType ?? "")
                        .fontWeight(.semibold)
                }
                VStack {
                    if (boughtItem?.purchaseDate != nil){
                        Text("Purchased: \(dateFormatter.string(from: boughtItem?.purchaseDate ?? Date()))")
                            .font(.system(size: 10))
                    }
                    if (boughtItem?.expirationDate != nil){
                        Text("\n\nExpires \(dateFormatter.string(from: boughtItem?.expirationDate ?? Date()))")
                        .font(.system(size: 10))
                        Text(String(days) + " days to expiration")
                            .font(.system(size: 10))
                    }
                    

                   
                }
                .padding(9)
            }
            .accentColor(.black)
        }

        

        
    }
}

