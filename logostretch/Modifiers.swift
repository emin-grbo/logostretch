import SwiftUI

// MARK: Modifiers -----
struct xStandardDropShadow: ViewModifier {
    func body(content: Content) -> some View {
        content
            .shadow(color: .xpinkBaseShadow, radius: 5, x: 0, y: 0)
    }
}
