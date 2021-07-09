//
//  TextFieldGuesser.swift
//  logostretch
//
//  Created by Emin Grbo on 04/07/2021.
//

import SwiftUI

struct TextFieldGuesser: View {
    
    @Binding var logoGuess: String
    @Binding var isStretched: Bool
    @StateObject var vm: QuestionsViewModel
    @FocusState private var focusedField: Field?
    
    var body: some View {
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
            .animation(.spring(response: 0.2, dampingFraction: 0.5, blendDuration: 1), value: logoGuess)
        }
        .padding(.horizontal, 40)
    }
    
    private func checkAnswer() {
        let guessFormatted = logoGuess.lowercased().replacingOccurrences(of: " ", with: "")
        isStretched = !(vm.currentAnswers.contains(guessFormatted))
        
        if !isStretched {
            focusedField = nil
            vm.markCorrectQuestion()
        }
    }
    
    private func updateDeleteButtonVisibility() {
        logoGuess = ""
    }
}
