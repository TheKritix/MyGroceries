//
//  CameraScan.swift
//  MyGroceries
//
//  Created by Kristoffer Pedersen (s205354) on 31/03/2022.
//

// Source: https://www.hackingwithswift.com/books/ios-swiftui/scanning-qr-codes-with-swiftui

import SwiftUI
import CodeScanner

struct CameraScan : View {
    
    @State private var isPresentingScanner = true
    @State private var scannedCode: String?
    
    var body: some View {
        VStack(spacing: 10) {
           if let code = scannedCode {
               ApiAddItemView(scannedCode: code)
            }
        }
        .sheet(isPresented: $isPresentingScanner) {
            CodeScannerView(codeTypes: [.ean8, .ean13]) { response in
                if case let .success(result) = response {
                    scannedCode = result.string
                    isPresentingScanner = false
                    print(scannedCode)
                }
            }
        }
    }
}
