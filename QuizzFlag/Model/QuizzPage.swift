import Foundation

final class QuizzPage {
    
    
    func getTheCorrectResponse() {
        
    }
    
    // Permet d'avoir un array de 4 réponses, dont la bonne, et de manière aléatoire
    func getFourResponses(countries: [Country], correctResponse: String) -> [String] {
        let names = countries.map { $0.name }
        let namesWithoutCorrectResponse = names.filter {$0 != correctResponse}
        var getThreeWrongAnswers = Array(namesWithoutCorrectResponse.prefix(3))
        getThreeWrongAnswers.append(correctResponse)
        let finalArrayOfResponses = getThreeWrongAnswers.shuffled()
        return finalArrayOfResponses
    }
}
