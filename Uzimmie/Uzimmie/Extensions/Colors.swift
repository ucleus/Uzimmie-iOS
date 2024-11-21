//
//  Colors.swift
//  Uzimmie
//
//  Created by SEAN BLAKE on 3/7/24.
//

import SwiftUI

extension Color {
    // A simple method to convert string color names to SwiftUI Colors.
    // You may need to customize this method to match all your color names.
    static func getColor(from colorName: String) -> Color {
        switch colorName.lowercased() {
        case "black":
            return .black
        case "white":
            return .white
        case "red":
            return .red
        case "blue":
            return .blue
        case "green":
            return .green
        case "yellow":
            return .yellow
        case "orange":
            return .orange
        case "purple":
            return .purple
        case "pink":
            return .pink
        case "gray":
            return .gray
        default:
            return .clear // An undefined color defaults to clear
        }
    }
}
