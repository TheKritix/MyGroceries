//
//  AddItem.swift
//  MyGroceries
//
//  Created by Kristoffer Pedersen (s205354) on 15/03/2022.
//  Dealing with menus Source: https://stackoverflow.com/questions/56513339/is-there-a-way-to-create-a-dropdown-menu-button-in-swiftui
//  Dates Source: https://developer.apple.com/documentation/swiftui/datepicker
// Modified by Mia Dong (s205353) on 24/03/2022.

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
    
    @State var isClickedOnce = false

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
                

                Button(action: {
                    isClickedOnce = true
                }){
                    HStack {
                        Text("🔔")
                        Text("Get expiration date reminder")
                    }
                }
                .disabled(isClickedOnce)
                
                    
                
                Button (action: {
                    UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
                        if success {
                            print("Permission granted")
                        } else if let error = error {
                            print(error.localizedDescription)
                        }
                    }
                    
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
                    
                    var dateComponent = DateComponents()
                    dateComponent.calendar = Calendar.current
                    let dateComponents = Calendar.current.dateComponents([.year,.month,.day,.hour,.minute], from: expirationDate)

                }
                )
                    if (!(setGrocery == "" || setQuantity == "" || setUnit == "Unit" || setCategory == "Category")) {
                    do {
                        try moc.save()
                        print("Bought record updated")
                      if (isClickedOnce){
                        let content = UNMutableNotificationContent()
                        content.title = "Expiration date reminder"
                        content.subtitle = "Your grocery is about to expire!"
                        content.sound = UNNotificationSound.default

                        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
                       // let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
                        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
                        UNUserNotificationCenter.current().add(request)
                        
                        isClickedOnce = false
                      
                    } catch {
                        print("something went wrong")
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

