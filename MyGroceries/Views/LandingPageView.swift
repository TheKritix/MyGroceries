
//
//  FridgeGridView.swift
//  MyGroceries
//
//  Created by anton dong on 09/03/2022.
//

import Foundation
import SwiftUI

struct LandingPageView : View {
    
    
    
    var body : some View {
        ZStack {
            RoundedRectangle(cornerRadius: 50)
                .fill(.gray)
                .brightness(0.35)
            VStack {
                    Text("My fridge")
                        .padding(5)
                        .background(.white)
                        .cornerRadius(15)
                ZStack {
                    RoundedRectangle(cornerRadius: 16.0)
                        .fill(.teal)
                        .opacity(0.4)
                }
                .frame(width: 360)
            }
        }
        
    }
}


struct LandingPageView_Previews: PreviewProvider {
    static var previews: some View {
        LandingPageView()
    }
}
