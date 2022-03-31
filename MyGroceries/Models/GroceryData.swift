//
//  GroceryData.swift
//  MyGroceries
//
//  Created by anton dong on 31/03/2022.
//

import SwiftUI



extension BoughtItem {

    @FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \BoughtItem.groceryType, ascending: true)], animation: .default)
    static var boughtItems: FetchedResults<BoughtItem>
}

extension GroceryItem {
    @FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \GroceryItem.groceryType, ascending: true)], animation: .default)
    static var groceryItems: FetchedResults<GroceryItem>
}
