//
//  FridgeView.swift
//  MyGroceries
//
//  Created by mia dong on 03/03/2022.
//

import SwiftUI

struct FridgeView : View {
    
    let title = "Fridge Content"
    
    var body : some View {
        FridgeGridView()
    }
}

struct FridgeCardView : View {
    
    let fridgeCard: GroceryItemOld
    var body: some View {
        Text(fridgeCard.groceryItem)
            .font(.headline)
        Spacer()
        HStack {
            Label("\(fridgeCard.quantity)", systemImage: "person.3")
            Spacer()
            Label("\(fridgeCard.experationDate)", systemImage: "clock")
        }
        
    }
}

struct FridgeView_Previews: PreviewProvider {
    
    //Using the test data provided in the model Fridge.Swift
   /* static var fridgeData1 = GroceryItemOld.fridgeTestData[0]
    */
    
    static var previews: some View {
        FridgeView()
        /*FridgeCardView(fridgeCard: fridgeData1)
            .background(Color("aqua"))
            .previewLayout(.fixed(width: 400, height: 60))*/
    }
}
