import Foundation

class TopicsViewModel {
    
    private(set) var allTopics: [TopicModel] = []
    private(set) var selectedIndex: Int = 0
    
    func loadTopics(topics: [TopicModel]) {
        self.allTopics = topics
    }
    
    func numberOfTopics() -> Int {
        return allTopics.count
    }
    
    func getSelectedTopic() -> TopicModel? {
        return allTopics[selectedIndex]
    }
    
    func setSelectedIndex(index: Int) {
        selectedIndex = index
    }
    
    func hasSufficientQuestions() -> Bool {
        return (allTopics[selectedIndex].quiz.count != 0)
    }
}
