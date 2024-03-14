import Foundation

final class MainScreenEngine {
    
    func randomizingCountries(countries: [Country]) -> [Country] {
        let randomCountries = countries.shuffled()
        let getElevenCountries = Array(randomCountries.prefix(11))
        return getElevenCountries
    }
    func randomizingCountriesNames(names: [Country]) -> [String] {
        let nameOfCountries = names.map {$0.name}.shuffled()
        return nameOfCountries
    }
}