import Foundation

final class QuizzPage {
    
    
    var titleOfTheContinent: String?
    var lives = 3
    var numberOfTurn = 0
    
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
    
    func settingFourResponses(countries: [Country]?, countryNames: [String]?) -> [String] {
        let correctResponse = getTheCorrectResponse(ofTheCurrentCountry: countries)
        guard let restOfResponses = countryNames?.shuffled() else { return [] }
        let responses = getFourResponses(fakeResponses: restOfResponses, correctResponse: correctResponse)
        
        return responses
    }
    
    func getFilePathOfFlag(ofTheCurrentCountry: [Country]?) -> String {
        guard let country = ofTheCurrentCountry?.first else { return "" }
        let flag = country.flag
        
        return flag
    }
    
    func checkIfTheGameHasEnded() -> Bool {
        
        if numberOfTurn == 10 || lives == 0 {
            return true
        }
        return false
    }
    
    func setContinentName(name: String?) -> String? {
        return name
    }
    
    func settingLives() -> String {
        return "Vies : \(lives)/3"
    }
    
    func settingTurn() -> String {
        return "Tour : \(numberOfTurn + 1)/10"
    }
}
