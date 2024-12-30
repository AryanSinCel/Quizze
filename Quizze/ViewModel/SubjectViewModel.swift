import Foundation

class SubjectsViewModel {
    
    private(set) var allLanguages: [LanguageModel] = []
    private(set) var selectedIndex: Int?
    
    func loadLanguages(quizManager: QuizManager) {
        allLanguages = quizManager.loadLanguageData()
    }
    
    func numberOfLanguages() -> Int {
        return allLanguages.count
    }
    
    func getSelectedLanguage() -> LanguageModel? {
        guard let index = selectedIndex else { return nil }
        return allLanguages[index]
    }
    
    func setSelectedIndex(index: Int) {
        selectedIndex = index
    }
    
    func getTopicsForSelectedLanguage() -> [TopicModel]? {
        return getSelectedLanguage()?.topics
    }
}
