
import XCTest
import CoreData
@testable import QuizzFlag

final class CoreDataManagerTests: XCTestCase {

    var coreDataManager: CoreDataManager!
     
     override func setUp() {
         loadingFakeCoreData()
     }
     override func tearDown() {
         coreDataManager = nil
     }
     
     func loadingFakeCoreData() {
         let container = NSPersistentContainer(name: "QuizzFlag")
         
         let description = NSPersistentStoreDescription()
         description.type = NSInMemoryStoreType
         
         container.persistentStoreDescriptions = [description]
         
         container.loadPersistentStores { (_, error) in
                 if let error = error as NSError? {
                     fatalError("Unresolved error \(error), \(error.userInfo)")
                 }
             }
         
         let backgroundContext = container.newBackgroundContext()
         coreDataManager = CoreDataManager(context: backgroundContext)
     }
    
    func test_fetchingCountries() {
            
        let _ = coreDataManager.unlockNewCountries(guessedCountryIn: nil, name: "France", history: "wikipedia", flag: "france.png", coatOfArms: "COA.france.png", capital: "Paris", continent: "Europe")
        
        try? coreDataManager.savingContext()
        
        guard let fetchedCountries = try? coreDataManager.fetchCountries() else { return }
        
        XCTAssertEqual(fetchedCountries.count, 1)
    }
  
    func test_deletingACountry() {
        let countryToDelete = coreDataManager.unlockNewCountries(guessedCountryIn: nil, name: "France", history: "wikipedia", flag: "france.png", coatOfArms: "COA.france.png", capital: "Paris", continent: "Europe")
        
        try? coreDataManager.savingContext()
        
        coreDataManager.deletingCountry(deleting: countryToDelete)
        
        guard let fetchedCountries = try? coreDataManager.fetchCountries() else { return }
        
        XCTAssertEqual(fetchedCountries, [])
    }
    
    func test_countryIsExistingAndReturnTrue() {
        let _ = coreDataManager.unlockNewCountries(guessedCountryIn: nil, name: "France", history: "wikipedia", flag: "france.png", coatOfArms: "COA.france.png", capital: "Paris", continent: "Europe")
        
        try? coreDataManager.savingContext()
        
        let countryExists = coreDataManager.countryIsExisting(named: "France")
        
        XCTAssertTrue(countryExists)
    }
    
    func test_countryIsNotExistingAndReturnFalse() {
        let _ = coreDataManager.unlockNewCountries(guessedCountryIn: nil, name: "France", history: "wikipedia", flag: "france.png", coatOfArms: "COA.france.png", capital: "Paris", continent: "Europe")
        
        try? coreDataManager.savingContext()
        
        let countryDontExists = coreDataManager.countryIsExisting(named: "Allemagne")
        
        XCTAssertFalse(countryDontExists)
    }
    func test_addingAllTheCountriesFromAnArray() {
        let countryToAdd1 = Country.init(name: "France", flag: "", history: "", coatOfArms: "", capital: "", continent: "")
        let countryToAdd2 = Country.init(name: "Allemagne", flag: "", history: "", coatOfArms: "", capital: "", continent: "")
        let countryToAdd3 = Country.init(name: "Belgique", flag: "", history: "", coatOfArms: "", capital: "", continent: "")
        let countryToAdd4 = Country.init(name: "Espagne", flag: "", history: "", coatOfArms: "", capital: "", continent: "")
        
        let allCountries: [Country] = [countryToAdd1, countryToAdd2, countryToAdd3, countryToAdd4]
        
        try? coreDataManager.addingAllTheCountriesDiscovered(countriesDiscovered: allCountries)
        
        guard let countriesRegistered = try? coreDataManager.fetchCountries() else { return }
        
        XCTAssertEqual(countriesRegistered.count, 4)
    }
    
    func test_deletingAllTheCountriesStored() {
        let country1 = coreDataManager.unlockNewCountries(guessedCountryIn: nil, name: "France", history: "", flag: "", coatOfArms: "", capital: "", continent: "")
        let country2 = coreDataManager.unlockNewCountries(guessedCountryIn: nil, name: "Allemagne", history: "", flag: "", coatOfArms: "", capital: "", continent: "")
        let country3 = coreDataManager.unlockNewCountries(guessedCountryIn: nil, name: "Turquie", history: "", flag: "", coatOfArms: "", capital: "", continent: "")
        
        let countriesToDelete: [CountryEntity] = [country1, country2, country3]
    
        try? coreDataManager.deletingAllCountries(countriesToDelete: countriesToDelete)
        
        guard let fetchedCountries = try? coreDataManager.fetchCountries() else { return }
        
        XCTAssertEqual(fetchedCountries, [])
        
    }
}
