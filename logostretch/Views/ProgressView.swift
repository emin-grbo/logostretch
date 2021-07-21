import SwiftUI

struct ProgressView: View {
    
    @AppStorage(StorageKeys.level.rawValue) var level = 1
    @AppStorage(StorageKeys.medalIndex.rawValue) var medalIndex = 0
    @AppStorage(StorageKeys.medalProgress.rawValue) var medalProgress = 0
    
    @State private var showSheet = false
    
    let regularSize: CGFloat = UIScreen.main.bounds.width
    
    var body: some View {
        
        VStack {
            HStack {
                Text("BDG \(medalIndex)")
                    .font(.title_20)
                    .foregroundColor(.white)
                    ZStack {
                        RoundedRectangle(cornerRadius: 24)
                            .fill(Color.xpurpleDark)
                            .frame(height: 16)
                        GeometryReader { gr in
                        RoundedRectangle(cornerRadius: 24)
                            .fill(Color.white)
                            .padding(.leading, 4)
                            .padding(.trailing, 4)
                            .opacity(1)
                            .frame(width: progressSize(forWidth: gr.size.width))
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
            MedalsView()
        }
    }
    
    private func progressSize(forWidth size: CGFloat) -> CGFloat {
        
        let medals = Medals.medalsList

        guard medalIndex < medals.count else { return size }
        
        let currentMedal = medals[medalIndex]
        let progressRatio = CGFloat(medalProgress) / CGFloat(currentMedal.goal)
        
        if progressRatio == 1 { // all questions answered
            return size
        } else {
            return progressRatio*size
        }
    }
}
