//
//  QuestionsViewModel.swift
//  logostretch
//
//  Created by Emin Grbo on 04/07/2021.
//

import SwiftUI

class QuestionsViewModel: ObservableObject {
    
    @AppStorage("level") var level = 1
    @AppStorage("current") var current = 0
    
    @EnvironmentObject var dataController: DataController
    @Published var questions = [Int: [Logo]]()
    
    var currentQuestion: Logo?
    
    func fetchQuestions() {
        questions =
        [
            1 :
                [
                    Logo(imgString: "mcdonalds", names: ["mcdonalds", "mc", "aa"]),
                    Logo(imgString: "breitling", names: ["breitling", "aa"])
                ],
            2 :
                [
                    Logo(imgString: "logitech", names: ["logitech", "aa"])
                ]
        ]
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
