import Foundation

final class QuizzPage {
    
    
    func getTheCorrectResponse(ofTheCurrentCountry: [Country]?) -> String {
        guard let country = ofTheCurrentCountry?.first else { return "" }
        
        return country.name
    }
    
    func getFourResponses(fakeResponses: [String], correctResponse: String) -> [String] {
        
        let namesWithoutCorrectResponse = fakeResponses.filter {$0 != correctResponse}
        
        var getThreeWrongResponses = Array(namesWithoutCorrectResponse.prefix(3))
        
        getThreeWrongResponses.append(correctResponse)
        
        let finalArrayOfResponses = getThreeWrongResponses.shuffled()
        
        return finalArrayOfResponses
    }
    
    func getFilePathOfFlag(ofTheCurrentCountry: [Country]?) -> String {
        guard let country = ofTheCurrentCountry?.first else { return "" }
        let flag = country.flag
        
        return flag
    }
    
    func checkIfTheGameHasEnded(numberOfTurn: Int, numberOfLives: Int) -> Bool {
        
        if numberOfTurn == 10 || numberOfLives == 0 {
            return true
        }
        return false
    }
}
