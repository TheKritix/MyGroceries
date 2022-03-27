//
//  FridgeGridView.swift
//  MyGroceries
//
//  Created by anton dong on 09/03/2022.
//

import Foundation
import SwiftUI

struct FridgeGridView : View {
    
    @FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \BoughtItem.groceryType, ascending: true)], animation: .default)
    private var boughtItems: FetchedResults<BoughtItem>
    
    
    private var columns = [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())]
    
    private let dateFormatter: DateFormatter = {
        let df = DateFormatter()
        df.dateFormat = "MM/dd/yyyy"
        return df
    }()
    
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
                                ForEach(boughtItems, id: \.self) { item in
                                    HStack {
                                        VStack {
                                            Text((item.groceryType ?? "unknown item") as String)
                                            Text("Purchase date: \(dateFormatter.string(from: item.purchaseDate ?? Date())) \nExpiration Date: \(dateFormatter.string(from: item.expirationDate ?? Date()))")
                                                .font(.system(size: 12))
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
