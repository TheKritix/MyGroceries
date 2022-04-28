//
//  CameraScan.swift
//  MyGroceries
//
//  Created by Kristoffer Pedersen (s205354) on 31/03/2022.
//

// Source: https://www.hackingwithswift.com/books/ios-swiftui/scanning-qr-codes-with-swiftui
// Source: "https://github.com/twostraws/CodeScanner"

import SwiftUI
import CodeScanner

struct CameraScan : View {
    
    @State private var isPresentingScanner = true
    @State private var scannedCode: String?
    @State private var isActive = false
    
    var body: some View {
        NavigationView {
            VStack(spacing: 10) {
                if let code = scannedCode {
                    NavigationLink("AddItemApi", destination: ApiAddItemView(scannedCode: code), isActive: .constant(isActive)).hidden()
                        .navigationTitle("Barcode scanner")
                }
                Button {
                    isPresentingScanner = true
                } label: {
                    Text("Open Camera")
                }
                .onAppear{
                    isPresentingScanner = true
                    isActive = false
                    
                }
            }
        }
        .sheet(isPresented: $isPresentingScanner) {
            CodeScannerView(codeTypes: [.ean8, .ean13]) { response in
                if case let .success(result) = response {
                    isActive = true
                    scannedCode = result.string
                    isPresentingScanner = false
                    print(scannedCode ?? "unable to find code")
                }
            }
        }
    }
}
