//
//  QuestionsViewModel.swift
//  logostretch
//
//  Created by Emin Grbo on 04/07/2021.
//

import SwiftUI

class QuestionsViewModel: ObservableObject {
    
    @AppStorage("level") var level = 0
    @AppStorage("current") var current = 0
    
    @Published var questions = [Logo]()
    
    var currentQuestion: Logo?
    
    func fetchQuestions() {
        questions = [
            Logo(imgString: "mcdonalds", names: ["mcdonalds", "mc", "aa"]),
            Logo(imgString: "breitling", names: ["breitling", "aa"]),
            Logo(imgString: "logitech", names: ["logitech", "aa"])
        ]
    }
    
    func getNextQuestion() {
        currentQuestion = questions.randomElement()
    }
}
