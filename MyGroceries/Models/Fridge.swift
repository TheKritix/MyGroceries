//
//  Fridge.swift
//  MyGroceries
//
//  Created by mia dong & Kristoffer Pedersen on 03/03/2022.
//

import Foundation

struct Fridge {
    var groceryItem: String
    var experationDate: String //TODO: Change to non primiative data type Foundation.Date, so it can be used with the calendar SwiftUI Component.
    var purchaseDate: String //TODO: Change to non primiative data type Foundation.Date, so it can be used with the calendar SwiftUI Component.
    var typeOfFood: String
    var numberOfItem: Int
}

//For testing of items when applicable to the application
//TODO: Implement saveable data for Firestore - JSON or XML.
extension Fridge {
    static let fridgeTestData: [Fridge] =
    [
    Fridge(groceryItem: "Sausage", experationDate: "12-03-2022", purchaseDate: "06-03-2022", typeOfFood: "meat", numberOfItem: 8),
    Fridge(groceryItem: "Carrot", experationDate: "19-03-2022", purchaseDate: "05-03-2022", typeOfFood: "vegetable", numberOfItem: 6)
    ]
}
