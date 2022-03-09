//
//  FridgeGridView.swift
//  MyGroceries
//
//  Created by anton dong on 09/03/2022.
//

import Foundation
import SwiftUI

struct FridgeGridView : View {
    
    /*
     Just some dummy data
     */
    let data = (1...100).map {
        "Good no. \($0)"
    }
    
    let columns = [
        GridItem(.adaptive(minimum: 60))
    ]
    
    var body : some View {
        VStack {
            ZStack {
                RoundedRectangle(cornerRadius: 20.0)
                    .fill(.gray)
                VStack {
                    HStack {
                        Text("My fridge")
                    }
                    .padding()
                    ZStack {
                        RoundedRectangle(cornerRadius: 20.0)
                            .fill(.mint)
                        ScrollView {
                            LazyVGrid(columns: columns, spacing: 10) {
                                ForEach(data, id: \.self) { item in
                                    Text(item)
                                }
                                .padding()
                            }
                        }
                    }
                    .frame(width: 325)
                }
            }
        }
        
    }
}


struct FridgeGridView_Previews: PreviewProvider {
    static var previews: some View {
        FridgeGridView()
    }
}
