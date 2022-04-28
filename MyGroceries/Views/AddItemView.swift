//
//  AddItem.swift
//  MyGroceries
//
//  Created by Kristoffer Pedersen (s205354) on 15/03/2022.
//  Dealing with menus Source: https://stackoverflow.com/questions/56513339/is-there-a-way-to-create-a-dropdown-menu-button-in-swiftui
//  Dates Source: https://developer.apple.com/documentation/swiftui/datepicker
// Modified by Mia Dong (s205353) on 24/03/2022.
// ImagePicker implementation
//https://www.hackingwithswift.com/books/ios-swiftui/importing-an-image-into-swiftui-using-phpickerviewcontroller


import SwiftUI
import CoreData

struct AddItemView : View {
    
    @Environment(\.managedObjectContext) var moc

    @State var setGrocery: String = ""
    @State var setQuantity: String = ""
    @State var setUnit: String = "Unit"
    @State var setCategory: String = "Category"
    @State var setPurchaseDate: Date = Date()
    @State var setExpirationDate: Date = Date()
    
    @State private var showingImagePicker = false
    
    @State private var inputImage: UIImage?
    @State var showFieldAlert = false
    @State var image = Image("person.fill.badge")
 
    func loadImage() {
        guard let inputImage = inputImage else { return }
        image = Image(uiImage: inputImage)
    }
    
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
                    Label(setUnit, systemImage: "list.dash")
                        .frame(width: 290, height: 50, alignment: .center)
                }
                .accessibilityIdentifier("unitMenu")
                
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
                        Button {
                            setCategory = "Snack"
                        } label: {
                            Text("Snack")
                        }
                    } label: {
                        Label(setCategory, systemImage: "list.dash")
                            .frame(width: 290, height: 50, alignment: .center)
                    }
                    .accessibilityIdentifier("categoryMenu")
                }
                
                
                Section {
                    Button(action: {
                        showingImagePicker = true
                    }){
                        Text("Select image")
                    }
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 150, height: 150, alignment: .center)
                            .clipped()
                }
                
                Button (action: {
        
                    let newGrocery = GroceryItem(context: moc)
                    
                    newGrocery.groceryType = setGrocery
                    newGrocery.quantity = Int16(setQuantity) ?? 0
                    newGrocery.unit = setUnit
                    newGrocery.purchaseDate = setPurchaseDate
                    newGrocery.expirationDate = setExpirationDate
                    newGrocery.foodCategory = setCategory
                    newGrocery.image = inputImage?.pngData()
                  
                    
                    if (setCategory == "") {
                        setCategory = "Other"
                    }
                
                
                    if (!(setGrocery == "" || setQuantity == "" || setUnit == "Unit" || setCategory == "Category")) {
                        
                    do {
                        try moc.save()
                        print("Bought record updated")
                        
                    } catch {
                        print("something went wrong")
                    }
                    
                    setGrocery = ""
                    setQuantity = ""
                    setUnit = "Unit"
                    setCategory = "Category"
                    setPurchaseDate = Date()
                    setExpirationDate = Date()
                    image = Image("person.fill.badge")
                    }
                    else {
                        showFieldAlert = true
                    }
                    
                } )
                {
                    Text("Add Item")
                        .bold()
                }
                .navigationTitle("Add Item to List")
            }
        
                .alert(isPresented: $showFieldAlert) {
                    Alert(
                        title: Text("Empty fields detected"),
                        message: Text("Please fill out all the available options.")
                    )
                }

                
            }
        .onChange(of: inputImage) {
            _ in loadImage()
        }
        .sheet(isPresented: $showingImagePicker) {
        ImagePicker(image: $inputImage)
        }


    }

       
        }
    



struct AddItem_Previews: PreviewProvider {
    
    //Using the test data provided in the model Fridge.Swift
    /* static var fridgeData1 = GroceryItemOld.fridgeTestData[0]
     */
    
    static var previews: some View {
        AddItemView()
        /*FridgeCardView(fridgeCard: fridgeData1)
         .background(Color("aqua"))
         .previewLayout(.fixed(width: 400, height: 60))*/
    }
}

