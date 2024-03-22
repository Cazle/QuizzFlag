import Foundation

enum MainScreenEngine {
    
    // Randomizing an array of Countries, and return randomly 11 countries
    static func randomizingCountries(countries: [Country]) -> [Country] {
        let randomCountries = countries.shuffled()
        let getElevenCountries = Array(randomCountries.prefix(11))
        return getElevenCountries
    }
    
    // Randomizing an array of Country names, and return it randomly
    static func randomizingCountriesNames(names: [Country]) -> [String] {
        let nameOfCountries = names.map {$0.name}.shuffled()
        return nameOfCountries
    }
}

