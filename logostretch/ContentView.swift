//
//  ContentView.swift
//  logostretch
//
//  Created by Emin Grbo on 30/05/2021.
//
import SwiftUI
import Combine

struct Logo {
    let logo: String
    let name: [String]
}

class Stretch: ObservableObject {
    @Published var state = true
}

let logos = [
    Logo(logo: "mcdonalds", name: ["mcdonalds", "mc", "aa"]),
    Logo(logo: "breitling", name: ["breitling", "aa"]),
    Logo(logo: "logitech", name: ["logitech", "aa"])
]

@available(iOS 15.0, *)
struct ContentView: View {
    
    @State var isStretched: Bool = true
    @State var logoGuess: String = ""
    @State private var visibility: Double = 1
    @State var currentLogo = logos.randomElement()
    
    @State private var keyboardHeight: CGFloat = 0
    @FocusState private var focusedField: Field?
    
    let regularSize = UIScreen.main.bounds.width
    let strechedSize = UIScreen.main.bounds.width / 2
    
    var body: some View {
        ZStack {
            Color.xpinkBase
            
            // MARK: TOP PROGRESS -----------------------------
            VStack {
                HStack {
                    Text("LVL 1")
                        .font(.title_20)
                        .foregroundColor(.white)
                    ZStack {
                        RoundedRectangle(cornerRadius: 24)
                            .fill(Color.xpinkDark)
                            .frame(height: 16)
                        RoundedRectangle(cornerRadius: 24)
                            .fill(Color.white)
                            .padding(.trailing, 80)
                            .frame(height: 16)
                    }
                    .padding()
                    Button {
                        print("skip")
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
                        print("skip")
                    } label: {
                        HStack {
                            Image(systemName: "t.bubble.fill")
                            Text("hint")
                        }
                    }
                    .buttonStyle(RoundedButtonStyle())
                    .fixedSize()
                    Spacer()
                    // MARK: Go around, button 􀱗
                    Button {
                        print("skip")
                    } label: {
                        HStack {
                            Image(systemName: "arrow.uturn.forward.square.fill")
                            Text("go around")
                        }
                    }
                    .buttonStyle(RoundedButtonStyle())
                    .fixedSize()
                }
                .padding()
                .zIndex(9)
                
                // MARK: MAIN STRETCH -----------------------------
                ZStack {
                    Rectangle()
                        .fill(Color.rubberGradient)
                        .frame(height: isStretched ? strechedSize : regularSize)
                    Image(currentLogo?.logo ?? "")
                        .resizable()
                        .padding(isStretched ? 0 : 120)
                        .frame(height: isStretched ? regularSize / 2 : regularSize)
                        .aspectRatio(isStretched ? 2 : 1,contentMode: .fit)
                    Image("stretch")
                        .resizable()
                        .frame(height: isStretched ? strechedSize * 0.9 : regularSize)
                        .foregroundColor(.xpinkBase)
                        .opacity(isStretched ? 1 : 0)
                }
                .onAppear {
                    focusedField = .field
                }
                .drawingGroup()
                .shadow(color: .xpinkBaseShadow, radius: 40)
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
            }
            .opacity(visibility)
            .animation(.spring(response: 0.5, dampingFraction: 0.5, blendDuration: 0.5))
            .keyboardAdaptive()
            .background(Color.green)
        }
        .edgesIgnoringSafeArea(.all)
    }
    
    private func updateDeleteButtonVisibility() {
        logoGuess = ""
    }
    
    private func checkAnswer() {
        let guessFormatted = logoGuess.lowercased().replacingOccurrences(of: " ", with: "")
        isStretched = !((currentLogo?.name ?? []).contains(guessFormatted))
        
        if !isStretched {
            focusedField = nil
        }
    }
    
    private func reloadGame() {
        isStretched = true
        visibility = 0
        logoGuess = ""
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            currentLogo = logos.randomElement()
            visibility = 1
            focusedField = .field
        }
    }
}

enum Field: Hashable {
    case field
}
