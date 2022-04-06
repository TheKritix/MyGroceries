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
                .fill(.white).opacity(0.3)
                
            VStack {
                VStack {
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
                    }
                    
                    if (boughtItem?.expirationDate != nil){
                        Text("Expires \(dateFormatter.string(from: boughtItem?.expirationDate ?? Date()))")
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
        
        return numberOfDays.day! + 1 // <1>
    }
}
