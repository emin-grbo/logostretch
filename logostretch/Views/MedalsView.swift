import SwiftUI

struct MedalsView: View {
    
    @AppStorage(StorageKeys.badgeIndex.rawValue) var badgeIndex = 0
    
    var body: some View {
        
        let columns = [
            GridItem(),
            GridItem(),
            GridItem(),
            GridItem()]
        
        ZStack {
            Color.xpurple
            ScrollView {
                LazyVGrid(columns: columns) {
                    ForEach(Badges.badges) { item in
                        Image(item.imgString)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(height: 80)
                            .padding(.bottom, 40)
                            .shadow(color: .xpurpleDark, radius: isUnlocked(item) ? 10 : 0, x: 0, y: 0)
                            .blendMode(isUnlocked(item) ? .normal : .luminosity)
                    }
                }
                .padding(.top, 60)
            }
        }
        .edgesIgnoringSafeArea(.all)
    }
    
    func isUnlocked(_ badge: Badge) -> Bool {
        let index = Badges.badges.firstIndex(of: badge) ?? 0
        return index < badgeIndex
    }
    
}

struct MedalsView_Previews: PreviewProvider {
    static var previews: some View {
        MedalsView()
    }
}
