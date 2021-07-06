//
//  QuestionsViewModel.swift
//  logostretch
//
//  Created by Emin Grbo on 04/07/2021.
//

import SwiftUI

class QuestionsViewModel: ObservableObject {
    
    func setupData(_ dataController: DataController) {
        self.dataController = dataController
    }
    
    @AppStorage("level") var level = 1
    @AppStorage("current") var current = 0
    
    var dataController: DataController?
    @Published var questions = [Logo]()
    
    var currentQuestion: Logo?
    
    func fetchQuestions() {
        questions =
        pokupiti ovo iz data controllera
    }
    
    func getCurrentQuestion() {
        guard let currentLevelQuestions = questions[level] else { return }
        
        guard current < currentLevelQuestions.count else {
            if currentLevelQuestions.first(where: {!$0.isSolved}) == nil {
                level += 1
                getCurrentQuestion()
            } else {
                currentQuestion = currentLevelQuestions.first(where: {!$0.isSolved})
            }
            
            return
        }
        
        currentQuestion = currentLevelQuestions[current]
    }
    
    func nextQuestion() {
        current += 1
    }
    
    func resetUserInfo() {
        level = 1
        current = 0
    }
}
