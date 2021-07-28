import SwiftUI

class MainOO: ObservableObject {
    
    @AppStorage(StorageKeys.level.rawValue) var level = 1
    @AppStorage(StorageKeys.medalProgress.rawValue) var medalProgress = 0
    @AppStorage(StorageKeys.medalIndex.rawValue) var medalIndex = 0
    
    @Published var questions: [Logo] = []
    
    var currentQuestion: Logo?
    var currentAnswers: [String] = []
    let maxLevel = 3
    
    private var mainDO = MainDO()
    
    func fetchQuestions() {
        questions = mainDO.fetchQuestionsForLevel(level)
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
        mainDO.updateQuestion(currentQuestion?.imgString ?? "")
//        questions = dataController?.fetchQuestionsForLevel(level) ?? []
    }
    
    func updateBadgeState() {
        medalProgress += 1
    }
    
    func resetData() {
        mainDO.deleteAll()
    }
    
    func checkMedalProgress() -> Bool {
        let currentBadge = Medals.medalsList[medalIndex]
        if medalProgress == currentBadge.goal {
            if medalIndex == Medals.medalsList.count { return false }
            medalIndex += 1
            medalProgress = 0
            return true
        }
        return false
    }
    
    func createMockQuestions() {
        mainDO.createSampleData()
    }
    
    func resetUserInfo() {
        medalProgress = 0
        medalIndex = 0
        level = 1
    }
}
