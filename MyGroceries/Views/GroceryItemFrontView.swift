//
//  GroceryItemFrontView.swift
//  MyGroceries
//
//  Created by anton dong on 02/05/2022.
//

import SwiftUI

struct GroceryItemFrontView : View {
    
    
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
//                    .overlay(alignment: .bottom) {
//                            Button {
//                                withAnimation {
//                                    do {
//
//
//                                    } catch {
//
//                                    }
//
//                                }
//                            } label: {
//                                HStack {
//                                    Text(String(Int16(boughtItem?.quantity ?? 1)))
//                                    Text(boughtItem?.unit ?? "")
//                                }
//                                    .font(.system(size: 12))
//                                    .padding(2)
//                                    .background(.yellow)
//                                    .cornerRadius(30)
//                                    .accentColor(.white)
//                            }
//
//                    }
            } else {
                Text(boughtItem?.groceryType ?? "Grocery")
                    .frame(width: 85, height: 90, alignment: .center)
                    .cornerRadius(16.0)
            }
            if (boughtItem?.expirationDate != nil){
                Text(String(days) + " days to expiration")
                    .font(.system(size: 10))
            }
            
        }
        .padding(9)
        
        
    }
        .frame(width: 120, height: 160)
    }

    }
