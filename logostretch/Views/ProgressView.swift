import SwiftUI

struct ProgressView: View {
    
    @State private var showSheet = false
    @AppStorage("level") var level = 1
    let regularSize: CGFloat = UIScreen.main.bounds.width
    
    let progressRatio: CGFloat
    
    var body: some View {
        
        VStack {
            HStack {
                Text("LVL \(level)")
                    .font(.title_20)
                    .foregroundColor(.white)
                    ZStack {
                        RoundedRectangle(cornerRadius: 24)
                            .fill(Color.xpurpleDark)
                            .frame(height: 16)
                        GeometryReader { gr in
                        RoundedRectangle(cornerRadius: 24)
                            .fill(Color.white)
                            .padding(.trailing, paddingProgress(forWidth: gr.size.width))
                            .padding(.leading, 4)
                            .padding(.trailing, 4)
                            .opacity(progressRatio != 0 ? 1 : 0)
                        }
                        .frame(height: 8)
                    }
                    .padding()
                Button {
                    print("levels")
                    showSheet.toggle()
                } label: {
                    Image(systemName: "square.grid.2x2.fill")
                        .foregroundColor(.white)
                }
            }
            .padding(.top, 40)
            .padding(.horizontal, 24)
            Spacer()
            .frame(width: regularSize)
        }
        .sheet(isPresented: $showSheet) {
            print("DISMISSED")
        } content: {
            EmptyView()
        }
    }
    
    private func paddingProgress(forWidth size: CGFloat) -> CGFloat {
        if progressRatio == 1 { // all questions answered
            return 0
        } else {
            return progressRatio*size
        }
    }
}
