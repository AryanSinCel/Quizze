import Foundation

class ResultViewModel {
    
    private(set) var answered: [String] = []
    private(set) var question: [QuizModel] = []
    private(set) var result: Int = 0
    private(set) var answers: [String] = []
    var mainIndex: Int?
    var subjectIndex: Int?
    
    func loadData(questions: [QuizModel], answered: [String]) {
        print("Subject : \(subjectIndex!) and Topic : \(mainIndex!)")
        self.question = questions
        self.answered = answered
        self.answers = questions.map { $0.answer }
        calculateResult()
    }
    
    private func calculateResult() {
        result = 0
        var remainingAnswers = answers
        
        for ans in answered {
            if let index = remainingAnswers.firstIndex(of: ans) {
                remainingAnswers.remove(at: index)
                result += 1
            }
        }
    }
    
    func numberOfRows() -> Int {
        return answered.count
    }
    
    func resultText() -> String {
        let percentage = Float(result) / Float(question.count)
        print("Result: \(String(format: "%.1f", percentage * 100))%")
        
        if let mainIndex = mainIndex, let subjectIndex = subjectIndex {
            updateProgressData(progress: percentage, mainIndex: mainIndex, topicIndex: subjectIndex)
        } else {
            print("Indexes are not set. Unable to update progress.")
        }
        
        return "\(result)/\(question.count)"
    }
    
    func getAnswer(for index: Int) -> (question: String, expectedAnswer: String, userAnswer: String, isCorrect: Bool) {
        let question = self.question[index]
        let userAnswer = answered[index]
        let isCorrect = question.answer == userAnswer
        return (question: question.question, expectedAnswer: question.answer, userAnswer: userAnswer, isCorrect: isCorrect)
    }
    
    private func updateProgressData(progress: Float, mainIndex: Int, topicIndex: Int) {
        var progressData = UserDefaults.standard.array(forKey: Constants.userDefaultKey) as? [[String: Any]] ?? []
        
        if let index = progressData.firstIndex(where: {
            $0[Constants.subjectString] as? Int == topicIndex && $0[Constants.chapterString] as? Int == mainIndex
        }) {
            if let existingProgress = progressData[index][Constants.userDefaultKey] as? Float, progress > existingProgress {
                progressData[index][Constants.userDefaultKey] = progress
            }
        } else {
            let newEntry: [String: Any] = [
                Constants.subjectString: topicIndex,
                Constants.chapterString: mainIndex,
                Constants.progressString: progress
            ]
            progressData.append(newEntry)
        }
        
        UserDefaults.standard.set(progressData, forKey: Constants.userDefaultKey)
        print("Saved")
    }


    
}
