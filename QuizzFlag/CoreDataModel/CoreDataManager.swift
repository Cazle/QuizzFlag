import Foundation
import CoreData

final class CoreDataManager {
    
    let context: NSManagedObjectContext
    
    init(context: NSManagedObjectContext = AppDelegate().backgroundContext) {
        self.context = context
    }
    
    func unlockNewCountries(guessedCountryIn: [Country]?, name: String, history: String, flag: String, coatOfArms: String, capital: String, continent: String) -> CountryEntity {
        
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
    
    func fetchCountries() throws -> [CountryEntity] {
        try context.performAndWait {
            try context.fetch(CountryEntity.fetchRequest())
        }
    }
    
    func deletingCountry(deleting: CountryEntity) {
        context.performAndWait {
            context.delete(deleting)
        }
    }
    
    func savingContext() throws {
        try context.performAndWait {
            try context.save()
        }
    }
    
    func countryIsExisting(named: String) -> Bool {
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
    
    func addingAllTheCountriesDiscovered(countriesDiscovered: [Country]) {
        
        for country in countriesDiscovered {
            let _ = unlockNewCountries(guessedCountryIn: countriesDiscovered, name: country.name, history: country.history, flag: country.flag, coatOfArms: country.coatOfArms, capital: country.capital, continent: country.continent)
        }
        do {
            try savingContext()
        } catch {
            print("Error from saving")
        }
    }
    
    func deletingAllCountries(countriesToDelete: [CountryEntity]) {
        for countries in countriesToDelete {
            deletingCountry(deleting: countries)
        }
        do {
            try savingContext()
        } catch {
            print("Error deleting")
        }
    }
}
