//
//  Colors+Extensions.swift
//  myroots
//
//  Created by Assistant on 13/06/25.
//

import SwiftUI

extension Color {
    // Paleta de colores Babel
    static let babelPrimary = Color(hex: "#479A94")
    static let babelSecondary = Color(hex: "#73BFBA") 
    static let babelLight = Color(hex: "#E3F2F1")
    static let babelMedium = Color(hex: "#ABD8D5")
    static let babelAccent = Color(hex: "#8FCCC8")
    static let babelDark = Color(hex: "#2D625E")
    static let babelDeepDark = Color(hex: "#132A28")
    static let babelVeryDark = Color(hex: "#060E0D")
    
    // Inicializador para colores hex
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (1, 1, 1, 0)
        }

        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue:  Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
}
