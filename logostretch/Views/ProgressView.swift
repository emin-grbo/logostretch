import SwiftUI

struct ProgressView: View {
    
    @State private var showSheet = false
    
    let regularSize: CGFloat
    let level: Int
    
    var body: some View {
        VStack {
            HStack {
                Text("LVL \(level + 1)")
                    .font(.title_20)
                    .foregroundColor(.white)
                ZStack {
                    RoundedRectangle(cornerRadius: 24)
                        .fill(Color.xpurpleDark)
                        .frame(height: 16)
                    RoundedRectangle(cornerRadius: 24)
                        .fill(Color.white)
                        .padding(.trailing, 80)
                        .padding(.leading, 4)
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
            print("")
        } content: {
            EmptyView()
        }

    }
}
