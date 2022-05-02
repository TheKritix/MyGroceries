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
            .accentColor(.black)

        }
        .frame(width: 120, height: 160)
        

        
    }
}

