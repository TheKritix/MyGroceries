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
                VStack {
                    if (boughtItem?.groceryType != nil){
                        Text(boughtItem?.groceryType ?? "Unknown grocery type")
                        .font(.system(size: 10))
                        .bold()
                    }
                    if (boughtItem?.image != nil){
                        let image = UIImage(data: boughtItem!.image!)
                        Image(uiImage: image!)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 85, height: 90, alignment: .center)
                            .clipped()
                            .cornerRadius(16.0)
                    } else {
                        Text(boughtItem?.groceryType ?? "Grocery")
                            .frame(width: 85, height: 90, alignment: .center)
                            .cornerRadius(16.0)
                    }
                    
                    if (boughtItem?.expirationDate != nil){
                        Text("Expires \(dateFormatter.string(from: boughtItem?.expirationDate ?? Date()))")
                        .font(.system(size: 10))
                        Text(String(days) + " days to expiration")
                            .font(.system(size: 10))
                    }
                    
                    //Text("Purchased: \(dateFormatter.string(from: boughtItem?.purchaseDate ?? Date())) \n\nExpires: \(dateFormatter.string(from: boughtItem?.expirationDate ?? Date()))")
                        //.font(.system(size: 10))
                   
                }
                .padding(9)
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

/*
 https://sarunw.com/posts/getting-number-of-days-between-two-dates/
 */
extension Calendar {
    func numberOfDaysBetween(_ from: Date, and to: Date) -> Int {
        let fromDate = startOfDay(for: from)
        let toDate = startOfDay(for: to)
        let numberOfDays = dateComponents([.day], from: fromDate, to: toDate)
        
        return numberOfDays.day! // <1>
    }
}
