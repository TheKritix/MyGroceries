import Foundation
import SwiftUI
import JSONParser

struct BarProduct: Codable {
    var product_name: String?
    var imageURL: String?
    var code: String?
    var status_verbose: String?
}

// Source: https://www.hackingwithswift.com/books/ios-swiftui/sending-and-receiving-codable-data-with-urlsession-and-swiftui
// Source: https://github.com/Gerzer/JSONParser


struct ApiAddItemView: View {
    
    @Environment(\.managedObjectContext) var moc
    
    @State var scannedCode: String?
    @State private var productResult = BarProduct(product_name: nil, imageURL: nil, code: nil, status_verbose: nil)
    
    func getJsonURL() -> String {
        let jsonURL = "https://world.openfoodfacts.org/api/v0/product/" + scannedCode! + ".json"
        return jsonURL
    }
    
    let jsonURL = "https://world.openfoodfacts.org/api/v0/product/5741000129623.json"
    //let jsonURL = "https://world.openfoodfacts.org/api/v0/product/5741000119020.json"
    
    
    @State var setGrocery: String = ""
    @State var setQuantity: String = ""
    @State var setUnit: String = "Unit"
    @State var setCategory: String = "Category"
    @State var setPurchaseDate: Date = Date()
    @State var setExpirationDate: Date = Date()
    
    @State private var inputImage: UIImageView?
    
    @State var unableToFindProduct = false
    
    
    
    var body: some View {
        
        
        
        NavigationView {
            TitleTextView(titleText: "Add Items to Grocery List")
            Form {
                if (unableToFindProduct) {
                    Text("Unable to find product. Please add manually, or scan another item")
                    Text("Scanned Barcode: " + (productResult.code ?? "Unable to find Barcode"))
                }
                else {
                    
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
                            setUnit = "N/A"
                        } label: {
                            Text("N/A")
                        }
                    } label: {
                        Label(setUnit, systemImage: "list.dash")
                            .frame(width: 290, height: 50, alignment: .center)
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
                            Button {
                                setCategory = "Snack"
                            } label: {
                                Text("Snack")
                            }
                            Button {
                                setCategory = "Other"
                            } label: {
                                Text("Other")
                            }
                        } label: {
                            Label(setCategory, systemImage: "list.dash")
                                .frame(width: 290, height: 50, alignment: .center)
                        }
                    }
                    AsyncImage(url: URL(string: productResult.imageURL ?? "Loading..."))
                        .frame(width: 150, height: 400, alignment: .center)
                    let asyncImage = AsyncImage(url: URL(string: productResult.imageURL ?? "Loading..."))
                    Section {}
                    
                    Button (action: {
                        let newGrocery = GroceryItem(context: moc)
                        
                        newGrocery.groceryType = setGrocery
                        newGrocery.quantity = Int16(setQuantity) ?? 0
                        newGrocery.unit = setUnit
                        newGrocery.purchaseDate = setPurchaseDate
                        newGrocery.expirationDate = setExpirationDate
                        newGrocery.foodCategory = setCategory
                        
                        
                        newGrocery.image = asyncImage.snapshot().pngData();
                        
                        
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
                        }
                        
                    } )
                    {
                        Text("Add Item")
                            .bold()
                    }
                }
            }
        }
        .task{await loadData()}
    }
    
    func loadData() async {
        guard let url = URL(string: getJsonURL()) else {
            print("Invalid URL")
            return
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            print(data)
            
            let parser = data.dictionaryParser
            productResult.product_name = parser![dictionaryAt: "product"]?["product_name", as: String.self] ?? "Unable to fetch product name"
            productResult.imageURL = parser![dictionaryAt: "product"]?["image_url", as: String.self] ?? "Unable to fetch barcode"
            productResult.code = parser!["code", as: String.self] ?? "Unable to fetch code"
            productResult.status_verbose = parser!["status_verbose", as: String.self] ?? "Unable to fetch status"
            
            setGrocery = productResult.product_name ?? "Fetching product name..."
            
            await inputImage?.loadFrom(URLAddress: productResult.imageURL ?? "localhost")
            
            if (productResult.status_verbose == "product not found") {
                unableToFindProduct = true
            }
        }
        catch {
            print("Invalid Data")
        }
    }
}

//TODO: Make it work with UIImage
// Used following solution: https://www.codingem.com/swift-load-image-from-url/
extension UIImageView {
    func loadFrom(URLAddress: String) {
        guard let url = URL(string: URLAddress) else {
            return
        }
        
        DispatchQueue.main.async { [weak self] in
            if let imageData = try? Data(contentsOf: url) {
                if let loadedImage = UIImage(data: imageData) {
                    self?.image = loadedImage
                }
            }
        }
    }
}

extension View {
    func snapshot() -> UIImage {
        let controller = UIHostingController(rootView: self)
        let view = controller.view
        
        let targetSize = controller.view.intrinsicContentSize
        view?.bounds = CGRect(origin: .zero, size: targetSize)
        view?.backgroundColor = .clear
        
        let renderer = UIGraphicsImageRenderer(size: targetSize)
        
        return renderer.image { _ in
            view?.drawHierarchy(in: controller.view.bounds, afterScreenUpdates: true)
        }
    }
}





