//
//  Theme.swift
//  MyGroceries
//
//  Created by Kristoffer Pedersen (s205354) on 06/03/2022.
//


// Quick attempt at creating basic theme. As of 06/03/2022 it does nothing yet.
// TODO: Implement use of Themes.

import SwiftUI

enum Theme: String {
    case fridge
    
    var accentColor: Color {
        switch self {
        case .fridge:
            return .black
        }
    }
    
    var mainColor: Color {
        Color(rawValue)
    }

}

