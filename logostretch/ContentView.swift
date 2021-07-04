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

@available(iOS 15.0, *)
struct ContentView: View {
    
    
    
    @StateObject var vm = QuestionsViewModel()

    @State var didCompleteReward = false
    @State var isShowingAd = false
    
    @State var isStretched: Bool = true
    @State var logoGuess: String = ""
    @State private var visibility: Double = 1
    
    @State private var keyboardHeight: CGFloat = 0
    @FocusState private var focusedField: Field?
    
    let regularSize = UIScreen.main.bounds.width
    let strechedSize = UIScreen.main.bounds.width / 2
    
    var body: some View {
        if isShowingAd {
            AdView(didComplete: $didCompleteReward)
                .onChange(of: didCompleteReward) { newValue in
                    if didCompleteReward {
                        isShowingAd = false
                    }
                }
        } else {
            ZStack {
                Color.xpurple
//                Color.purple
                // MARK: TOP PROGRESS -----------------------------
                VStack {
                    HStack {
                        Text("LVL 1")
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
                        } label: {
                            Image(systemName: "square.grid.2x2.fill")
                                .foregroundColor(.white)
                        }
                    }
                    .padding(.top, 40)
                    .padding(.horizontal, 24)
                    Spacer()
                }
                .frame(width: regularSize)
                
                Spacer()
                
                VStack {
                    HStack {
                        // MARK: Skip, button 􀌱
                        Button {
                            print("hint")
                            vm.current += 1
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
                    ZStack {
                        Rectangle()
                            .fill(Color.rubberGradient)
                            .frame(height: isStretched ? strechedSize : regularSize)
                        Image(vm.currentQuestion?.imgString ?? "")
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
                    .onAppear {
                        focusedField = .field
                    }
                    .drawingGroup()
                    .shadow(color: .xpurpleDark, radius: 40)
                    .padding(.bottom, 40)
                    
                    if isStretched {
                        // MARK: Textfield entry
                        ZStack {
                            TextField("", text: $logoGuess,
                                      onCommit: {
                                print("commited")
                            })
                                .focused($focusedField, equals: .field)
                                .frame(height: 50)
                                .multilineTextAlignment(.center)
                                .accentColor(.xpurple)
                                .foregroundColor(.white)
                                .font(.body_16)
                                .onChange(of: logoGuess) { text in
                                    checkAnswer()
                                }
                                .background(VStack {
                                    Spacer()
                                    RoundedRectangle(cornerRadius: 24, style: .continuous)
                                        .frame(height: 4)
                                        .foregroundColor(.white)
                                })
                            HStack {
                                Spacer()
                                Button(action: {
                                    updateDeleteButtonVisibility()
                                }) {
                                    Image(systemName: "delete.left")
                                        .font(.body_16)
                                }
                                .foregroundColor(.white)
                                .padding(.trailing, 16)
                            }
                            .zIndex(9)
                            .offset(x: logoGuess == "" ? 100 : 0, y: 0)
                            .animation(.spring(response: 0.2, dampingFraction: 0.5, blendDuration: 1))
                        }
                        .padding(.horizontal, 40)
                        
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
                        //-------------------------------------------------
                    }
                    
                    Text("\(vm.level) \(vm.current)")
                        .font(.title)
                        .foregroundColor(Color.white)
                        .fontWeight(.black)
                    
                }
                .opacity(visibility)
                .animation(.spring(response: 0.5, dampingFraction: 0.5, blendDuration: 0.5))
                .keyboardAdaptive()
            }
            .edgesIgnoringSafeArea(.all)
            .onAppear {
                vm.fetchQuestions()
                vm.getNextQuestion()
            }
        }
    }
    
    private func updateDeleteButtonVisibility() {
        logoGuess = ""
    }
    
    private func checkAnswer() {
        let guessFormatted = logoGuess.lowercased().replacingOccurrences(of: " ", with: "")
        isStretched = !((vm.currentQuestion?.names ?? []).contains(guessFormatted))
        
        if !isStretched {
            focusedField = nil
        }
    }
    
    private func reloadGame() {
        isStretched = true
        visibility = 0
        logoGuess = ""
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            vm.getNextQuestion()
            visibility = 1
            focusedField = .field
        }
    }
}

enum Field: Hashable {
    case field
}
