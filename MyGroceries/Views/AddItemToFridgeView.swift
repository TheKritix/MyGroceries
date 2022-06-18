//  Dealing with menus Source: https://stackoverflow.com/questions/56513339/is-there-a-way-to-create-a-dropdown-menu-button-in-swiftui
//  Dates Source: https://developer.apple.com/documentation/swiftui/datepicker

// ImagePicker implementation
//https://www.hackingwithswift.com/books/ios-swiftui/importing-an-image-into-swiftui-using-phpickerviewcontroller


import SwiftUI
import CoreData

struct AddItemToFridgeView : View {
    
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
        VStack {
            Form {
                
                Section{
                    TextField("Grocery", text: $setGrocery)
                }
                
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
                    
                    if (setGrocery != "") {
                        
                        if (setCategory == "Category") {
                            setCategory = "Other"
                        }
                        
                        if (setQuantity == "") {
                            setQuantity = "1"
                        }
                        else if (setQuantity == "0") {
                            setQuantity = "1"
                        }
                        
                        let newGrocery = BoughtItem(context: moc)
                        
                        newGrocery.groceryType = setGrocery
                        newGrocery.quantity = Int16(setQuantity) ?? 0
                        newGrocery.unit = setUnit
                        newGrocery.purchaseDate = setPurchaseDate
                        newGrocery.expirationDate = setExpirationDate
                        newGrocery.image = inputImage?.pngData()
                        
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



