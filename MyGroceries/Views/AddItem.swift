//
//  AddItem.swift
//  MyGroceries
//
//  Created by Kristoffer Pedersen (s205354) on 15/03/2022.
//  Dealing with menus Source: https://stackoverflow.com/questions/56513339/is-there-a-way-to-create-a-dropdown-menu-button-in-swiftui
//  Dates Source: https://developer.apple.com/documentation/swiftui/datepicker

import SwiftUI

struct AddItem : View {
    
    @Environment(\.managedObjectContext) var moc
    
    @State var grocery: String = ""
    @State var quantity: String = "0"
    @State var unit: String = "Unit"
    @State var category: String = "Category"
    @State var purchaseDate: Date = Date()
    @State var expirationDate: Date = Date()
    @State var bought: Bool = false
    
    var body : some View {
        NavigationView {
            Form {
                TextField("Grocery", text: $grocery)
                TextField("Quantity", text: $quantity)
                    .keyboardType(.numberPad)
                
                //Unit
                Menu {
                    Button {
                        unit = "kg"
                    } label: {
                        Text("Kilogram")
                    }
                    Button {
                        unit = "g"
                    } label: {
                        Text("Gram")
                    }
                    Button {
                        unit = "mL"
                    } label: {
                        Text("Mililiter")
                    }
                    Button {
                        unit = "cL"
                    } label: {
                        Text("Centiliter")
                    }
                    Button {
                        unit = "L"
                    } label: {
                        Text("Liter")
                    }
                    Button {
                        unit = "pcs"
                    } label: {
                        Text("Pieces")
                    }
                    Button {
                        unit = ""
                    } label: {
                        Text("N/A")
                    }
                } label: {
                    Text(unit)
                }
                
                Section {
                    //Category
                    Menu {
                        Button {
                            category = "Protein"
                        } label: {
                            Text("Protein")
                        }
                        Button {
                            category = "Vegetable"
                        } label: {
                            Text("Vegetable")
                        }
                        Button {
                            category = "Fruit"
                        } label: {
                            Text("Fruit")
                        }
                        Button {
                            category = "Grain"
                        } label: {
                            Text("Grain")
                        }
                    } label: {
                        Text(category)
                    }
                }
                
                Section {
                    //PurchaseDate
                    DatePicker (
                        "Purchase Date",
                        selection: $purchaseDate,
                        displayedComponents: [.date]
                    )
                    
                    //Expiration date
                    DatePicker (
                        "Expiration Date",
                        selection: $expirationDate,
                        displayedComponents: [.date]
                    )
                }
                
                Button (action: {
                    let newGrocery = GroceryItem(context: moc)
                    
                    newGrocery.groceryType = grocery
                    newGrocery.quantity = Int16(quantity) ?? 0
                    newGrocery.unit = unit
                    newGrocery.purchaseDate = purchaseDate
                    newGrocery.expirationDate = expirationDate
                    newGrocery.foodCategory = category
                    newGrocery.bought = bought
                    
                    do {
                        try moc.save()
                    } catch {
                        print("something went wrong")
                    }
                } )
                {
                    Text("Add")
                        .bold()
                }
                .frame(width: 200)
                .background(Color.green)
                
//                Button {
//                    let newGrocery = GroceryItem(context: moc)
//
//                    newGrocery.groceryType = grocery
//                    newGrocery.quantity = Int16(quantity) ?? 0
//                    newGrocery.unit = unit
//                    newGrocery.purchaseDate = purchaseDate
//                    newGrocery.expirationDate = expirationDate
//                    newGrocery.foodCategory = category
//
//                    PersistenceController.shared.save()
//                } label : {
//                    Text("Add")
//                        .bold()
//                }
            
                
            }
            .navigationTitle("Add Item to Grocery List")
        }
        
        
    }
}

struct AddItem_Previews: PreviewProvider {
    
    //Using the test data provided in the model Fridge.Swift
    /* static var fridgeData1 = GroceryItemOld.fridgeTestData[0]
     */
    
    static var previews: some View {
        AddItem()
        /*FridgeCardView(fridgeCard: fridgeData1)
         .background(Color("aqua"))
         .previewLayout(.fixed(width: 400, height: 60))*/
    }
}

