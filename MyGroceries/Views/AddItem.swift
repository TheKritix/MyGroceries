//
//  AddItem.swift
//  MyGroceries
//
//  Created by Kristoffer Pedersen (s205354) on 15/03/2022.
//  Dealing with menus Source: https://stackoverflow.com/questions/56513339/is-there-a-way-to-create-a-dropdown-menu-button-in-swiftui
//  Dates Source: https://developer.apple.com/documentation/swiftui/datepicker

import SwiftUI
import CoreData

struct AddItem : View {
    
    @Environment(\.managedObjectContext) var moc
    
    @State var setGrocery: String = ""
    @State var setQuantity: String = ""
    @State var setUnit: String = "Unit"
    @State var setCategory: String = "Category"
    @State var setPurchaseDate: Date = Date()
    @State var setExpirationDate: Date = Date()
    @State var setBought: Bool = false
    
    @State var showFieldAlert = false
    
    var body : some View {
        
        NavigationView {
            
            Form {
                Section{
                    //Empty for whitespace in UI.
                }
                TextField("Grocery", text: $setGrocery)
                TextField("Quantity", text: $setQuantity)
                    .keyboardType(.decimalPad)
                
                //Unit
                Menu {
                    Button {
                        setUnit = "kg"
                    } label: {
                        Text("Kilogram")
                    }
                    Button {
                        setUnit = "g"
                    } label: {
                        Text("Gram")
                    }
                    Button {
                        setUnit = "mL"
                    } label: {
                        Text("Mililiter")
                    }
                    Button {
                        setUnit = "cL"
                    } label: {
                        Text("Centiliter")
                    }
                    Button {
                        setUnit = "L"
                    } label: {
                        Text("Liter")
                    }
                    Button {
                        setUnit = "pcs"
                    } label: {
                        Text("Pieces")
                    }
                    Button {
                        setUnit = ""
                    } label: {
                        Text("N/A")
                    }
                } label: {
                    Text(setUnit)
                }
                
                Section {
                    //Category
                    Menu {
                        Button {
                            setCategory = "Protein"
                        } label: {
                            Text("Protein")
                        }
                        Button {
                            setCategory = "Vegetable"
                        } label: {
                            Text("Vegetable")
                        }
                        Button {
                            setCategory = "Fruit"
                        } label: {
                            Text("Fruit")
                        }
                        Button {
                            setCategory = "Grain"
                        } label: {
                            Text("Grain")
                        }
                    } label: {
                        Text(setCategory)
                    }
                }
                
                Section {
                    //PurchaseDate
                    DatePicker (
                        "Purchase Date",
                        selection: $setPurchaseDate,
                        displayedComponents: [.date]
                    )
                    
                    //Expiration date
                    DatePicker (
                        "Expiration Date",
                        selection: $setExpirationDate,
                        displayedComponents: [.date]
                    )
                }
                
                Button (action: {
                    let newGrocery = GroceryItem(context: moc)
                    
                    newGrocery.groceryType = setGrocery
                    newGrocery.quantity = Int16(setQuantity) ?? 0
                    newGrocery.unit = setUnit
                    newGrocery.purchaseDate = setPurchaseDate
                    newGrocery.expirationDate = setExpirationDate
                    newGrocery.foodCategory = setCategory
                    newGrocery.bought = setBought
                    
                    if (setCategory == "") {
                        setCategory = "Other"
                    }
                    
                    if (!(setGrocery == "" || setQuantity == "" || setUnit == "Unit" || setCategory == "Category")) {
                    do {
                        try moc.save()
                        print("Bought record updated")
                    } catch {
                        //SOMETHING
                    }
                    
                    setGrocery = ""
                    setQuantity = ""
                    setUnit = "Unit"
                    setCategory = "Category"
                    setPurchaseDate = Date()
                    setExpirationDate = Date()
                    }
                    else {
                        showFieldAlert = true
                    }
                    
                } )
                {
                    Text("Add")
                        .bold()
                }
                .alert(isPresented: $showFieldAlert) {
                    Alert(
                        title: Text("Empty fields detected"),
                        message: Text("Please fill out all the available options.")
                    )
                }
                .foregroundColor(Color.green)
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
