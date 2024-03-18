import XCTest
import Foundation
@testable import QuizzFlag

final class MainScreenEngineTests: XCTestCase {
    
    let sut = MainScreenEngine()
    
    
    func test_randomizingCountriesAndGetElevenOfThem() {
        
        let countryOne = Country(name: "France", flag: "", history: "", coatOfArms: "", capital: "", continent: "")
        let countryTwo = Country(name: "Allemagne", flag: "", history: "", coatOfArms: "", capital: "", continent: "")
        let countryThree = Country(name: "Espagne", flag: "", history: "", coatOfArms: "", capital: "", continent: "")
        let countryFour = Country(name: "Belgique", flag: "", history: "", coatOfArms: "", capital: "", continent: "")
        let countryFive = Country(name: "Luxembourg", flag: "", history: "", coatOfArms: "", capital: "", continent: "")
        let countrySix = Country(name: "Bulgarie", flag: "", history: "", coatOfArms: "", capital: "", continent: "")
        let countrySeven = Country(name: "Grèce", flag: "", history: "", coatOfArms: "", capital: "", continent: "")
        let countryEight = Country(name: "Italie", flag: "", history: "", coatOfArms: "", capital: "", continent: "")
        let countryNine = Country(name: "Pologne", flag: "", history: "", coatOfArms: "", capital: "", continent: "")
        let countryTen = Country(name: "Swisse", flag: "", history: "", coatOfArms: "", capital: "", continent: "")
        let countryEleven = Country(name: "Suède", flag: "", history: "", coatOfArms: "", capital: "", continent: "")
        let countryTwelve = Country(name: "Kosovo", flag: "", history: "", coatOfArms: "", capital: "", continent: "")
        let countryThirteen = Country(name: "Pays-Bas", flag: "", history: "", coatOfArms: "", capital: "", continent: "")
        let countryFourteen = Country(name: "Royaume-Uni", flag: "", history: "", coatOfArms: "", capital: "", continent: "")
        let countryFiveteen = Country(name: "Norvège", flag: "", history: "", coatOfArms: "", capital: "", continent: "")
        let countrySixteen = Country(name: "Denmark", flag: "", history: "", coatOfArms: "", capital: "", continent: "")
        let countrySeventeen = Country(name: "Roumanie", flag: "", history: "", coatOfArms: "", capital: "", continent: "")
        
        
        let allCountries: [Country] = [countryOne, countryTwo, countryThree, countryFour, countryFive, countrySix, countrySeven, countryEight, countryNine, countryTen, countryEleven, countryTwelve, countryThirteen, countryFourteen, countryFiveteen, countrySixteen, countrySeventeen]
        
        let getElevenCountries = sut.randomizingCountries(countries: allCountries)
    
        let countriesNames = allCountries.map({$0.name})
        let elevenCountriesNames = getElevenCountries.map({$0.name})
        
        
        XCTAssertEqual(getElevenCountries.count, 11)
        XCTAssertTrue(elevenCountriesNames.allSatisfy({countriesNames.contains($0)}))
    }
    
    func test_gettingNameOfTheCountriesAndRandomizingAllOfThem() {
        
        let countryOne = Country(name: "France", flag: "", history: "", coatOfArms: "", capital: "", continent: "")
        let countryTwo = Country(name: "Allemagne", flag: "", history: "", coatOfArms: "", capital: "", continent: "")
        let countryThree = Country(name: "Espagne", flag: "", history: "", coatOfArms: "", capital: "", continent: "")
        let countryFour = Country(name: "Belgique", flag: "", history: "", coatOfArms: "", capital: "", continent: "")
        let countryFive = Country(name: "Luxembourg", flag: "", history: "", coatOfArms: "", capital: "", continent: "")
        let countrySix = Country(name: "Bulgarie", flag: "", history: "", coatOfArms: "", capital: "", continent: "")
        let countrySeven = Country(name: "Grèce", flag: "", history: "", coatOfArms: "", capital: "", continent: "")
        let countryEight = Country(name: "Italie", flag: "", history: "", coatOfArms: "", capital: "", continent: "")
        let countryNine = Country(name: "Pologne", flag: "", history: "", coatOfArms: "", capital: "", continent: "")
        let countryTen = Country(name: "Swisse", flag: "", history: "", coatOfArms: "", capital: "", continent: "")
        let countryEleven = Country(name: "Suède", flag: "", history: "", coatOfArms: "", capital: "", continent: "")
        let countryTwelve = Country(name: "Kosovo", flag: "", history: "", coatOfArms: "", capital: "", continent: "")
        let countryThirteen = Country(name: "Pays-Bas", flag: "", history: "", coatOfArms: "", capital: "", continent: "")
        
        let allCountries: [Country] = [countryOne, countryTwo, countryThree, countryFour, countryFive, countrySix, countrySeven, countryEight, countryNine, countryTen, countryEleven, countryTwelve, countryThirteen]
        
        let getAllTheNames = sut.randomizingCountriesNames(names: allCountries)
        
        XCTAssertEqual(getAllTheNames.count, 13)
        XCTAssertEqual(getAllTheNames, getAllTheNames as [String])
    }
}
