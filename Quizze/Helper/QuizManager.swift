import Foundation

class QuizManager{
    
    private var allLanguage:[LanguageModel] = []
    
    func loadLanguageData()->[LanguageModel] {
        guard let path = Bundle.main.path(forResource: Constants.jsonFileName, ofType: Constants.jsonFileExtension) else {
            print("JSON file not found")
            return []
        }
        
        do {
            let data = try Data(contentsOf: URL(fileURLWithPath: path))
            allLanguage = try JSONDecoder().decode([LanguageModel].self, from: data)
            print("Successfully loaded languages")
        } catch {
            print("Failed to load or parse JSON: \(error.localizedDescription)")
        }
        return allLanguage
    }
    
    
}
