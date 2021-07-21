//
//  QuestionsViewModel.swift
//  logostretch
//
//  Created by Emin Grbo on 04/07/2021.
//

import SwiftUI

class QuestionsViewModel: ObservableObject {
    
    let maxLevel = 3
    
    @AppStorage(StorageKeys.level.rawValue) var level = 1
    @AppStorage(StorageKeys.badgeProgress.rawValue) var badgeProgress = 0
    @AppStorage(StorageKeys.badgeIndex.rawValue) var badgeIndex = 0
    
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
    
    func getNextQuestion() {
        questions.shuffle()
        guard let nextQuestion = questions.first(where: {!$0.isSolved && $0 != currentQuestion}) else {
            level += 1
            fetchQuestions()
            getNextQuestion()
            return
        }
        currentQuestion = nextQuestion
        currentAnswers = currentQuestion?.names?.components(separatedBy: ", ") ?? []
    }
    
    func markCorrectQuestion() {
        updateBadgeState()
        questions.first(where: {$0 == currentQuestion})?.isSolved = true
        dataController?.updateQuestion(currentQuestion?.imgString ?? "")
//        questions = dataController?.fetchQuestionsForLevel(level) ?? []
    }
    
    func updateBadgeState() {
        badgeProgress += 1
    }
    
    func checkBadgeProgress() -> Bool {
        let currentBadge = Badges.badges[badgeIndex]
        if badgeProgress == currentBadge.goal {
            if badgeIndex == Badges.badges.count { return false }
            badgeIndex += 1
            badgeProgress = 0
            return true
        }
        return false
    }
    
    func createMockQuestions() {
        dataController?.createSampleData()
    }
    
    func resetUserInfo() {
        badgeProgress = 0
        badgeIndex = 0
        level = 1
    }
}
