//
//  ContentView.swift
//  logostretch
//
//  Created by Emin Grbo on 30/05/2021.
//
import SwiftUI
import Combine

class Stretch: ObservableObject {
    @Published var state = true
}

//@available(iOS 15.0, *)
struct ContentView: View {
    
    @AppStorage(StorageKeys.level.rawValue) var level = 1
    
    @EnvironmentObject var dataController: DataController
    @StateObject var vm = QuestionsViewModel()

    @State var didCompleteReward = false
    @State var isShowingAd = false
    
    @State var isStretched: Bool = true
    @State var logoGuess: String = ""
    @State private var visibility: Double = 1
    
    @State private var showEndLevelSheet = false
    
    @State private var keyboardHeight: CGFloat = 0
//    @FocusState private var focusedField: Field?
    
    let regularSize = UIScreen.main.bounds.width
    let strechedSize = UIScreen.main.bounds.width / 2
    
    var body: some View {
        if isShowingAd {
            AdView(didComplete: $didCompleteReward)
                .onChange(of: didCompleteReward) { newValue in
                    if didCompleteReward {
                        isShowingAd = false
                        vm.getNextQuestion()
                    }
                }
        } else {
            ZStack {
                Color.xpurple
                
                ProgressView()
                    .opacity(level == vm.maxLevel ? 0 : 1)
                
                VStack {
                    
                    HStack {
                        // MARK: Hint, button 􀌱
                        Button {
                            print("HINT")
                        } label: {
                            HStack {
                                Image(systemName: "t.bubble.fill")
                                Text("hint")
                            }
                        }
                        .buttonStyle(RoundedButtonStyle())
                        .fixedSize()
                        .opacity(isStretched ? 1 : 0)
                        Spacer()
                        
                        // MARK: Go around, button 􀱗
                        Button {
                            print("go around")
                            isShowingAd = true
                        } label: {
                            HStack {
                                Image(systemName: "arrow.uturn.forward.square.fill")
                                Text("go around")
                            }
                        }
                        .buttonStyle(RoundedButtonStyle())
                        .fixedSize()
                        .opacity(isStretched ? 1 : 0)
                    }
                    .padding()
                    .zIndex(9)
                    
                    // MARK: MAIN STRETCH -----------------------------
                    LogoView(isStretched: $isStretched,
                             regularSize: regularSize,
                             strechedSize: strechedSize,
                             imgString: vm.questions.count == 0 ? "theEnd" : vm.currentQuestion?.imgString ?? "")
                    .onAppear {
//                        focusedField = .field
                    }
                    
                    if isStretched {
                        
                        // MARK: Textfield entry
                        TextFieldGuesser(logoGuess: $logoGuess, isStretched: $isStretched, vm: vm)
                        
                    } else {
                        // MARK: END BUTTON ------------------------
                        Button {
                            reloadGame()
                        } label: {
                            Image(systemName: "arrow.forward.square.fill")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .foregroundColor(.white)
                        }
                        .frame(height: 80)
                        .padding(.top, 40)
                        .opacity(isStretched ? 0 : 1)
                    }
                    
                    Text("\(vm.level)")
                        .font(.title)
                        .foregroundColor(Color.white)
                        .fontWeight(.black)
                    
                    // MARK: DELETE
                    Button("dlt all") {
                        dataController.deleteAll()
                        vm.resetUserInfo()
                        loadGame()
                    }
                    .foregroundColor(.white)
                    
                }
                .opacity(visibility)
                .animation(.spring(response: 0.5, dampingFraction: 0.5, blendDuration: 0.5), value: isStretched)
                .keyboardAdaptive()
            }
            .edgesIgnoringSafeArea(.all)
            .onAppear {
                loadGame()
            }
            .sheet(isPresented: $showEndLevelSheet) {
                isStretched = vm.questions.count > 0
            } content: {
                Text("LEVEL COMPLETE!")
            }
        }
    }
    
    private func loadGame() {
        vm.setupData(dataController)
        vm.createMockQuestions()
        vm.fetchQuestions()
        vm.getNextQuestion()
        isStretched = vm.questions.count > 0
    }
    
    private func reloadGame() {
        isStretched = vm.questions.count > 0
        visibility = 0
        logoGuess = ""
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            showEndLevelSheet = vm.checkBadgeProgress()
            vm.getNextQuestion()
            visibility = 1
//            focusedField = .field
        }
    }
}

enum Field: Hashable {
    case field
}

