import SwiftUI

struct LogoView: View {
    
    @Binding var isStretched: Bool
    
    let regularSize: CGFloat
    let strechedSize: CGFloat
    let imgString: String
    
    var body: some View {
        ZStack {
            Rectangle()
                .fill(Color.rubberGradient)
                .frame(height: isStretched ? strechedSize : regularSize)
            Image(imgString)
                .resizable()
                .padding(isStretched ? 0 : 120)
                .frame(height: isStretched ? regularSize / 2 : regularSize)
                .aspectRatio(isStretched ? 2 : 1,contentMode: .fit)
            Image("stretch")
                .resizable()
                .frame(height: isStretched ? strechedSize * 0.9 : regularSize)
                .foregroundColor(.xrubberBase)
                .opacity(isStretched ? 1 : 0)
        }
        .drawingGroup()
        .shadow(color: .xpurpleDark, radius: 40)
        .padding(.bottom, 40)
    }
}
