//
//  ApiAddItemView.swift
//  MyGroceries
//
//  Created by Kristoffer Pedersen on 06/04/2022.
//

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
    
    @State var scannedCode: String?
    @State private var productResult = BarProduct(product_name: nil, imageURL: nil, code: nil, status_verbose: nil)
    
    func getJsonURL() -> String {
        let jsonURL = "https://world.openfoodfacts.org/api/v0/product/" + scannedCode! + ".json"
        return jsonURL
    }
    
    let jsonURL = "https://world.openfoodfacts.org/api/v0/product/5741000129623.json"
    //let jsonURL = "https://world.openfoodfacts.org/api/v0/product/5741000119020.json"
    
    
    var body: some View {
        
        NavigationView {
            VStack {
                Text(productResult.product_name ?? "Fetching product name...")
                Text(productResult.code ?? "Fetching barcode...")
                Text(productResult.status_verbose ?? "Fetching status...")
                AsyncImage(url: URL(string: productResult.imageURL ?? "Loading..."))
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
        }
        catch {
            print("Invalid Data")
        }
    }
}
