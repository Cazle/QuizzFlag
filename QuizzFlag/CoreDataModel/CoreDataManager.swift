import Foundation
import CoreData

final class CoreDataManager {
    
    let context: NSManagedObjectContext
    
    init(context: NSManagedObjectContext = AppDelegate().backgroundContext) {
        self.context = context
    }
    // Method to add new countries
    func unlockNewCountries(name: String, history: String, flag: String, coatOfArms: String, capital: String, continent: String) -> CountryEntity {
        
        context.performAndWait {
            
            let newCountry = CountryEntity(context: context)
            newCountry.name = name
            newCountry.history = history
            newCountry.flag = flag
            newCountry.coatOfArms = coatOfArms
            newCountry.capital = capital
            newCountry.continent = continent
            
            return newCountry
        }
    }
    
    // Fetch the countries from CoreData
    func fetchCountries() throws -> [CountryEntity] {
        try context.performAndWait {
            try context.fetch(CountryEntity.fetchRequest())
        }
    }
    
    // Delete country from CoreData
    func deletingCountry(deleting: CountryEntity) {
        context.performAndWait {
            context.delete(deleting)
        }
    }
    
    // Saving the context in CoreData (Save objects)
    func savingContext() throws {
        try context.performAndWait {
            try context.save()
        }
    }
    // Method to verify if a country exists, and return a boolean
    func isCountryExisting(named: String) -> Bool {
        var isExisting = false
        
        context.performAndWait {
            let fetchRequest = CountryEntity.fetchRequest()
            let predicate = NSPredicate(format: "name == %@", named)
            fetchRequest.predicate = predicate
            if let fetchingNames = try? context.fetch(fetchRequest) {
                isExisting = !fetchingNames.isEmpty
            }
        }
        return isExisting
    }
    
    // Method to add all discovered countries by a player during a Quizz
    func addingAllTheCountriesDiscovered(countriesDiscovered: [Country]) throws {
        for country in countriesDiscovered {
            let _ = unlockNewCountries(name: country.name, history: country.history, flag: country.flag, coatOfArms: country.coatOfArms, capital: country.capital, continent: country.continent)
        }
        try savingContext()
    }
    
    // Method to delete all the country, it's used if the user wants to clean all flags in his list
    func deletingAllCountries(countriesToDelete: [CountryEntity]) throws {
        for countries in countriesToDelete {
            deletingCountry(deleting: countries)
        }
        try savingContext()
    }
}
