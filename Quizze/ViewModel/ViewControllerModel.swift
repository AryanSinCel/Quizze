import Foundation

class ViewControllerModel {
    
    private(set) var questions: [QuizModel] = []
    private(set) var answered: [String] = []
    private(set) var currentQuestionSet: [QuizModel] = []
    private(set) var index: Int = 0
    
    
    func prepareQuestions(questions: [QuizModel]) {
        guard questions.count >= 15 else {
            fatalError("Insufficient questions to start the quiz. Ensure at least 16 questions are provided.")
        }
        self.questions = questions
        self.currentQuestionSet = questions.shuffled().prefix(15).map { $0 }
        self.index = 0
        self.answered.removeAll()
    }

    func loadCurrentQuestion() -> QuizModel? {
        guard index < currentQuestionSet.count else { return nil }
        return currentQuestionSet[index]
    }
 
    func nextQuestion() {
        index += 1
    }
    
    func isQuizFinished() -> Bool {
        return index == currentQuestionSet.count
    }
    
    func addAnswer(selectedAnswer: String) {
        answered.append(selectedAnswer)
    }
    
    func getCurrentQuestionIndex() -> Int {
        return index + 1
    }
    
    func resetQuiz() {
        self.index = 0
        currentQuestionSet = getRandomQuestion()
        self.answered.removeAll()
    }
    
    func getRandomQuestion()->[QuizModel]{
        return questions.shuffled().prefix(15).map { $0 }
    }
}
