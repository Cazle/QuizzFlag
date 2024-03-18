import XCTest
import Foundation
@testable import QuizzFlag

final class QuizzEngineTests: XCTestCase {

    let sut = QuizzEngine()
    
    func test_whenGetTheCorrectResponseIsCalledAndReturnTheCorrectResponse() {
        
        let countryOne = Country(name: "France", flag: "France.png", history: "www.france.fr", coatOfArms: "COA_France.png", capital: "Paris", continent: "Europe")
        let countryTwo = Country(name: "Allemagne", flag: "Allemagne.png", history: "www.allemagne.de", coatOfArms: "COA_Allemagne.png", capital: "Berlin", continent: "Europe")
        
        let arrayOfCountry: [Country] = [countryOne, countryTwo]
        
        let correctResponse = sut.getTheCorrectResponse(ofTheCurrentCountry: arrayOfCountry)
        
        XCTAssertEqual(correctResponse, "France")
    }
    
    func test_settingFourResponsesAndGettingFourResponsesWithTheCorrectResponseInIt() {
        let countryOne = Country(name: "France", flag: "", history: "", coatOfArms: "", capital: "", continent: "")
        let countryTwo = Country(name: "Allemagne", flag: "", history: "", coatOfArms: "", capital: "", continent: "")
        
        
        let allCountries: [Country] = [countryOne, countryTwo]
        let countriesNames: [String] = ["Belgique", "Luxembourg", "Royaume-Uni", "Espagne", "Italie", "Portugal"]
        
        
        let finalResults = sut.settingFourResponses(countries: allCountries, countryNames: countriesNames)
        
        XCTAssertEqual(finalResults.count, 4)
        XCTAssertTrue(finalResults.contains(countryOne.name))
        
    }
    
    func test_gettingTheFilePathToShowTheFlagImage() {
        let countryOne = Country(name: "Allemagne", flag: "Allemagne.png", history: "", coatOfArms: "", capital: "", continent: "")
        let countryTwo = Country(name: "France", flag: "France.png", history: "", coatOfArms: "", capital: "", continent: "")
        
        let countries: [Country] = [countryOne, countryTwo]
        
        let flagFile = sut.getFilePathOfFlag(ofTheCurrentCountry: countries)
        
        XCTAssertEqual(flagFile, "Allemagne.png")
        
    }
    
    func test_whenTheNumberOfTurnIs10AndTheGameFinishes() {
        
        sut.numberOfTurn = 10
        sut.lives = 2
        
        let endGame = sut.checkTheStateOfTheGame()
        
        XCTAssertEqual(endGame, .win)
    }
    
    func test_whenTheNumberOfLivesIs0SoThePlayerLoseTheGame() {
        sut.lives = 0
        sut.numberOfTurn = 8
        
        let endGame = sut.checkTheStateOfTheGame()
        
        XCTAssertEqual(endGame, .lose)
    }
    
    func test_theUserDidNotLostOrFinishTheGameSoTheGameIsOngoing() {
        sut.lives = 2
        sut.numberOfTurn = 7
        
        let endGame = sut.checkTheStateOfTheGame()
        
        XCTAssertEqual(endGame, .ongoing)
    }
    
    func test_whenThereIsAContinentNameToDisplay() {
        
        let contientName = sut.setContinentName(name: "Asie")
        
        XCTAssertEqual(contientName, "Asie")
    
    }
    
    func test_settingTheLivesToDisplay() {
        
        sut.lives = 2
        
        let textLives = sut.settingLives()
        
        XCTAssertEqual(textLives, "Vies : 2/3")
    }
    
    func test_settingTheTurnsToDisplay() {
        
        sut.numberOfTurn = 5
        
        let textTurns = sut.settingTurn()
        
        XCTAssertEqual(textTurns, "Tour : 6/10")
    }
    
    func test_messageToDisplayTheNumberOfFlagsDiscovered() {
        
        let countryOne = Country(name: "Allemagne", flag: "Allemagne.png", history: "", coatOfArms: "", capital: "", continent: "")
        let countryTwo = Country(name: "France", flag: "France.png", history: "", coatOfArms: "", capital: "", continent: "")
        
        sut.guessedCountries?.append(countryOne)
        sut.guessedCountries?.append(countryTwo)
        
        let textDiscovery = sut.discoveryMessage()
        
        XCTAssertEqual(textDiscovery, "Nouveaux drapeaux découverts : 2")
    }
    
    func test_addingTheFirstCountryOnTheGuessedCountriesWhenThePlayerHasACorrectResponse() {
        
        var countries: [Country] = []
        
        let countryOne = Country(name: "Allemagne", flag: "Allemagne.png", history: "", coatOfArms: "", capital: "", continent: "")
        let countryTwo = Country(name: "France", flag: "France.png", history: "", coatOfArms: "", capital: "", continent: "")
        
        countries.append(countryOne)
        countries.append(countryTwo)
        
        sut.addingCountryForCorrectResponse(addingCountryFrom: countries)
        
        XCTAssertEqual(sut.guessedCountries?[0].name, "Allemagne")
    }
}
