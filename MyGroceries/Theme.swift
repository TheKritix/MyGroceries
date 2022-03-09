//
//  Theme.swift
//  MyGroceries
//
//  Created by anton dong on 09/03/2022.
//

import SwiftUI

enum Theme : String, CaseIterable, Identifiable{
    case bubblegum
    case buttercup
    case indigo
    case lavender
    
    var accentColor : Color {
        switch self {
        case .bubblegum, .buttercup, .lavender: return .black
        case .indigo: return .white
        }
    }
    
    var mainColor : Color {
        Color(rawValue)
    }
    
    var name : String {
        rawValue.capitalized
    }
    
    var id : String {
        name
    }
}
