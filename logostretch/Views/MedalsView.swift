import SwiftUI

struct MedalsView: View {
    
    @AppStorage(StorageKeys.medalIndex.rawValue) var medalIndex = 0
    
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
                    ForEach(Medals.medalsList) { item in
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
    
    func isUnlocked(_ medal: Medal) -> Bool {
        let index = Medals.medalsList.firstIndex(of: medal) ?? 0
        return index < medalIndex
    }
    
}

struct MedalsView_Previews: PreviewProvider {
    static var previews: some View {
        MedalsView()
    }
}
