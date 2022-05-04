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
    let days : Int
    private let dateFormatter: DateFormatter = {
        let df = DateFormatter()
        df.dateFormat = "MM/dd/yyyy"
        return df
    }()
    
    
    var body : some View {
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
                Spacer()
                if (boughtItem?.groceryType != nil){
                    Text(boughtItem?.groceryType ?? "Unknown grocery type")
                        .font(.system(size: 10))
                        .bold()
                }
                Spacer()
                Spacer()
                
                
                Text(String(days) + " days to expiration")
                    .font(.system(size: 10))
                Spacer()
                if (boughtItem?.purchaseDate != nil){
                    Text("Purchased: \(dateFormatter.string(from: boughtItem?.purchaseDate ?? Date()))")
                        .font(.system(size: 10))
                }
                Spacer()
                if (boughtItem?.expirationDate != nil){
                    if days >= 0 {
                        Text(String(days) + " days to expiration")
                            .font(.system(size: 10))
                    } else {
                        Text(String(days) + " past expiration")
                            .font(.system(size: 10))
                    }
                    
                }
                
            }
            .padding(9)
            //to secure that text does not become mirrored when it flips
            .rotation3DEffect(.degrees(180), axis: (x: 0, y: 1, z: 0))
            
            
        }
        .frame(width: 120, height: 160)
        
        
        
    }
}

