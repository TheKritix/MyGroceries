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
            if (days <= 2) {
                RoundedRectangle(cornerRadius: 20)
                    .fill(.red).opacity(0.2)
            } else if (days >= 3 && days <= 5){
                RoundedRectangle(cornerRadius: 20)
                    .fill(.yellow).opacity(0.2)
            } else {
                RoundedRectangle(cornerRadius: 20)
                    .fill(.green).opacity(0.2)
            }
                
            VStack {
                if (boughtItem?.groceryType != nil){
                    Text(boughtItem?.groceryType ?? "")
                        .font(.system(size: 10))
                    Spacer()
                    Spacer()
                }
              
                    Text(String(days) + " days to expiration")
                        .font(.system(size: 10))
                    
                    if (boughtItem?.purchaseDate != nil){
                        Text("Purchased: \(dateFormatter.string(from: boughtItem?.purchaseDate ?? Date()))")
                            .font(.system(size: 10))
                    }
                    if (boughtItem?.expirationDate != nil){
                        Text("Expires: \(dateFormatter.string(from: boughtItem?.expirationDate ?? Date()))\n")
                        .font(.system(size: 10))
                        Spacer()

                    }
                
            }
            .padding(9)


        }
        .frame(width: 120, height: 160)
        

        
    }
}

