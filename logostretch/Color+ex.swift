//
//  Color+ex.swift
//  logostretch
//
//  Created by Emin Grbo on 30/05/2021.
//

import SwiftUI

extension Color {
    // MARK: Accents
    static var xpinkBase         : Color { return Color(hex: "#FF7676") }
    static var xpinkBaseDark     : Color { return Color(hex: "#FF6F6F") }
    static var xpinkBaseLight    : Color { return Color(hex: "#FF8585") }
    static var xpinkBaseShadow   : Color { return Color(hex: "#DD4444") }
    static var xpinkLight        : Color { return Color(hex: "#FF9D9D") }
    static var xpinkDark         : Color { return Color(hex: "#E45151") }
    static var xpurple           : Color { return Color(hex: "#7406FF") }
    static var xpurpleDark       : Color { return Color(hex: "#3E008D") }
    
    static var linearRubber = Gradient(stops: [
        .init(color: .xpinkBase, location: 0),
        .init(color: .xpinkBaseLight, location: 0.03),
        .init(color: .xpinkBaseDark, location: 0.05),
        
        .init(color: .xpinkBase, location: 0.2),
        .init(color: .xpinkBaseLight, location: 0.25),
        .init(color: .xpinkBase, location: 0.29),
        
        .init(color: .xpinkBase, location: 0.4),
        .init(color: .xpinkBaseLight, location: 0.43),
        .init(color: .xpinkBase, location: 0.5),
        
        .init(color: .xpinkBase, location: 0.6),
        .init(color: .xpinkBaseLight, location: 0.7),
        .init(color: .xpinkBaseDark, location: 0.85),
        
        .init(color: .xpinkBaseDark, location: 0.92),
        .init(color: .xpinkBaseLight, location: 0.97),
        .init(color: .xpinkBase, location: 1),
    ])
    
    static var rubberGradient = LinearGradient(gradient: linearRubber, startPoint: .top, endPoint: .bottom)
}

extension Color {
    // MARK: Hex converter
    init(hex: String) {
        let r, g, b: CGFloat

        if hex.hasPrefix("#") {
            let start = hex.index(hex.startIndex, offsetBy: 1)
            let hexColor = String(hex[start...])

            if hexColor.count == 6 {
                let scanner = Scanner(string: hexColor)
                var hexNumber: UInt64 = 0

                if scanner.scanHexInt64(&hexNumber) {
                    r = CGFloat((hexNumber & 0xff0000) >> 16) / 255
                    g = CGFloat((hexNumber & 0x00ff00) >> 8) / 255
                    b = CGFloat((hexNumber & 0x0000ff)) / 255

                    self.init(.displayP3, red: Double(r), green: Double(g), blue: Double(b), opacity: 1)
                    return
                }
            }
        }
        self.init(.displayP3, red: 1, green: 1, blue: 1, opacity: 1)
    }
}
