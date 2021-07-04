//
//  xRoundedRect.swift
//  logostretch
//
//  Created by Emin Grbo on 31/05/2021.
//

import Foundation

import SwiftUI

struct xRoundedRect: View {
    
    var radius: CGFloat = 20
    
    var body: some View {
        RoundedRectangle(cornerRadius: radius, style: .continuous)
            .fill(Color.white)
            .modifier(xStandardDropShadow())
    }
}
