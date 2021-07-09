import SwiftUI

struct ProgressView: View {
    
    @State private var showSheet = false
    @State private var hasProgress = true
    
    let regularSize: CGFloat
    let level: Int
    
    @StateObject var vm: QuestionsViewModel
    
    var body: some View {
        GeometryReader { gr in
        VStack {
            HStack {
                Text("LVL \(level)")
                    .font(.title_20)
                    .foregroundColor(.white)
                ZStack {
                    RoundedRectangle(cornerRadius: 24)
                        .fill(Color.xpurpleDark)
                        .frame(height: 16)
                    RoundedRectangle(cornerRadius: 24)
                        .fill(Color.white)
                        .padding(.trailing, getProgress(width: gr.size.width))
                        .padding(.leading, 4)
                        .padding(.trailing, 4)
                        .opacity(hasProgress ? 1 : 0)
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
        .onAppear {
            hasProgress = true
            if vm.questions.filter({$0.isSolved}).count == 0 {
                hasProgress = false
            }
        }
    }
    }
    
    func getProgress(width: CGFloat) -> CGFloat {
        let numOfQuestions = CGFloat(vm.questions.count)
        let segmentWidth = width / numOfQuestions
        let padding = CGFloat(vm.questions.filter({!$0.isSolved}).count) * segmentWidth
        
        guard vm.questions.filter({$0.isSolved}).count > 0 else {
            return 0
        }

        return padding
    }
}
