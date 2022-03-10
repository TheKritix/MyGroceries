//
//  Fridge.swift
//  MyGroceries
//
//  Created by mia dong & Kristoffer Pedersen on 03/03/2022.
//

//MARK: 06-03-2022 KTP created simple test data for Fridge, so we can test both UI components and backend firebase setup if needed this early. 

import Foundation

struct GroceryItemOld {
    var groceryItem: String
    var experationDate: String //TODO: Change to non primiative data type Foundation.Date, so it can be used with the calendar SwiftUI Component.
    var purchaseDate: String //TODO: Change to non primiative data type Foundation.Date, so it can be used with the calendar SwiftUI Component.
    var typeOfFood: String
    var quantity: String
}

//For testing of items when applicable to the application
//TODO: Implement saveable data for Firestore - JSON or XML.
extension GroceryItemOld {
    static let fridgeTestData: [GroceryItemOld] =
    [
        GroceryItemOld(groceryItem: "Sausage", experationDate: "12-03-2022", purchaseDate: "06-03-2022", typeOfFood: "meat", quantity: "8 kg"),
        GroceryItemOld(groceryItem: "Carrot", experationDate: "19-03-2022", purchaseDate: "05-03-2022", typeOfFood: "vegetable", quantity: "2 kg")
    ]
}

