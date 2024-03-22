import Foundation

final class QuizzEngine {
    
    var lives = 3
    var numberOfTurn = 0
    var guessedCountries: [Country] = []
    
    let winMessage = "Tu as gagné !"
    let loseMessage = "Tu as perdu..."
    
    enum stateOfThegame {
        case win
        case lose
        case ongoing
    }
    
    // Get the name of the first country in an array
    func getTheCorrectResponse(ofTheCurrentCountry: [Country]) -> String {
        guard let country = ofTheCurrentCountry.first else { return "" }
        return country.name
    }
    
    // Method to filter all the country names exepect the good one, randomly
    private func getFourResponses(fakeResponses: [String], correctResponse: String) -> [String] {
        
        let namesWithoutCorrectResponse = fakeResponses.filter {$0 != correctResponse}.shuffled()
        
        var getThreeWrongResponses = Array(namesWithoutCorrectResponse.prefix(3))
        
        getThreeWrongResponses.append(correctResponse)
        
        let finalArrayOfResponses = getThreeWrongResponses.shuffled()
        
        return finalArrayOfResponses
    }
    
    //Method who use the two precedent methods, and get our final array of responses (3 wrongs, 1 correct) and shuffle it too
    func settingFourResponses(countries: [Country], countryNames: [String]) -> [String] {
        
        let correctResponse = getTheCorrectResponse(ofTheCurrentCountry: countries)
        
        let restOfResponses = countryNames.shuffled()
        
        let responses = getFourResponses(fakeResponses: restOfResponses, correctResponse: correctResponse)
        
        return responses
    }
    
    // Method to get the path of the flag, to put it on the UIImageView
    func getFilePathOfFlag(ofTheCurrentCountry: [Country]) -> String {
        guard let country = ofTheCurrentCountry.first else { return "" }
        
        return country.flag
    }
    
    // Method to check if the player has lost, win, or still playing the game
    func checkTheStateOfTheGame() -> stateOfThegame {
        if lives == 0 {
            return .lose
        }
        if numberOfTurn == 10 {
            return .win
        }
        return .ongoing
    }
    
    func setContinentName(name: String) -> String {
        return name
    }
    
    func settingLives() -> String {
        return "Vies : \(lives)/3"
    }
    
    func settingTurn() -> String {
        return "Tour : \(numberOfTurn + 1)/10"
    }
    
    func discoveryMessage() -> String {
        return "Nouveaux drapeaux découverts : \(guessedCountries.count)"
    }
    
    // Method to add to the "guessedCountries" empty array
    func addingCountryForCorrectResponse(addingCountryFrom: [Country]){
        guard let countryToAdd = addingCountryFrom.first else { return }
        guessedCountries.append(countryToAdd)
    }
}
