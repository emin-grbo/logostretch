import SwiftUI

struct ProgressView: View {
    
    @AppStorage(StorageKeys.level.rawValue) var level = 1
    @AppStorage(StorageKeys.badgeIndex.rawValue) var badgeIndex = 0
    @AppStorage(StorageKeys.badgeProgress.rawValue) var badgeProgress = 0
    
    @State private var showSheet = false
    
    let regularSize: CGFloat = UIScreen.main.bounds.width
    
    var body: some View {
        
        VStack {
            HStack {
                Text("BDG \(badgeIndex)")
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
        
        let badges = Badges.badges

        guard badgeIndex < badges.count else { return size }
        
        let currentBadge = badges[badgeIndex]
        let progressRatio = CGFloat(badgeProgress) / CGFloat(currentBadge.goal)
        
        if progressRatio == 1 { // all questions answered
            return size
        } else {
            return progressRatio*size
        }
    }
}
