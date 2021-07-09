//
//  QuestionsViewModel.swift
//  logostretch
//
//  Created by Emin Grbo on 04/07/2021.
//

import SwiftUI

class QuestionsViewModel: ObservableObject {
    
    let maxLevel = 3
    
    @AppStorage("level") var level = 1
    @AppStorage("current") var current = 0
    
    var dataController: DataController?
    
    @Published var questions: [Logo] = []
    
    var currentQuestion: Logo?
    var currentAnswers: [String] = []
    
    func setupData(_ dataController: DataController) {
        self.dataController = dataController
    }
    
    func fetchQuestions() {
        questions = dataController?.fetchQuestionsForLevel(level) ?? []
    }
    
    func getCurrentQuestion() {
        guard current < questions.count else {
            questions = []
            currentQuestion = nil
            currentAnswers = []
            level = maxLevel
            return
        }
        currentQuestion = questions[current]
        currentAnswers = currentQuestion?.names?.components(separatedBy: ", ") ?? []
    }
    
    func checkIfLevelDone() -> Bool {
        if questions.first(where: {!$0.isSolved}) == nil {
            // If there are no unsolved questions, move to next level
            level += 1
            current = 0
            fetchQuestions()
            getCurrentQuestion()
            return true
        }
        return false
    }
    
    func nextQuestion() {
        current += 1
    }
    
    func markCorrectQuestion() {
        questions[current].isSolved = true
        dataController?.updateQuestion(currentQuestion?.imgString ?? "")
        questions = dataController?.fetchQuestionsForLevel(level) ?? []
    }
    
    func resetUserInfo() {
        level = 1
        current = 0
    }
    
    func createMockQuestions() {
        dataController?.createSampleData()
    }
    
    func progressRatio() -> CGFloat {
        let solved = questions.filter({$0.isSolved}).count
        let total = questions.count
        return CGFloat(solved)/CGFloat(total)
    }
}
