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
                Rectangle()
                .fill(.white).opacity(0.8)
                
            VStack {
                VStack {
                    if (boughtItem?.purchaseDate != nil){
                        Text("Purchased: \(dateFormatter.string(from: boughtItem?.purchaseDate ?? Date())) \n\nExpires: \(dateFormatter.string(from: boughtItem?.expirationDate ?? Date()))")
                            .font(.system(size: 10))
                    }
                    if (boughtItem?.expirationDate != nil){
                        Text("Expires \(dateFormatter.string(from: boughtItem?.expirationDate ?? Date()))")
                        .font(.system(size: 10))
                        Text(String(days) + " days to expiration")
                            .font(.system(size: 10))
                    }
                    

                   
                }
                .padding(9)
            }
        }
        .overlay(alignment: .top) {
                Button {
   
                } label: {
                    Rectangle()
                        .fill(.white)
                        .frame(width: 30, height: 30, alignment: .center)
                }
                .offset(y: -20)
        }
        

        
    }
}

