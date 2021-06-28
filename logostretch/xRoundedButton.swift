//
//  xRoundedButton.swift
//  logostretch
//
//  Created by Emin Grbo on 06/06/2021.
//

import SwiftUI

struct RoundedButtonStyle: ButtonStyle {
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .padding(8)
            .padding(.horizontal, 8)
            .foregroundColor(.xpinkBase)
            .frame(maxWidth: .infinity)
            .font(.small_12)
            .background(configuration.isPressed ? Color.xpinkDark : Color.white)
            .cornerRadius(24)
    }
}
