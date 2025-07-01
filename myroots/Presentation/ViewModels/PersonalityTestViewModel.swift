import Foundation
import SwiftUI

final class PersonalityTestViewModel: ObservableObject {
    @Published var selectedPersonality: PersonalityType?
    @Published var showQuickTest: Bool = false
    @Published var isFinished: Bool = false
    
    func choosePersonality(_ type: PersonalityType) {
        selectedPersonality = type
    }
    
    func startQuickTest() {
        showQuickTest = true
    }
    
    func finish() {
        isFinished = true
    }
}

// MARK: - Quick Test ViewModel

final class QuickPersonalityTestViewModel: ObservableObject {
    struct Question {
        let text: String
        let options: [String]
    }
    
    @Published private(set) var currentQuestionIndex: Int = 0
    @Published private(set) var answers: [Int] = []
    
    let questions: [Question]
    
    init(questions: [Question]) {
        self.questions = questions
    }
    
    var isLastQuestion: Bool {
        currentQuestionIndex == questions.count - 1
    }
    
    func selectAnswer(_ index: Int) {
        answers.append(index)
        if !isLastQuestion {
            currentQuestionIndex += 1
        }
    }
} 