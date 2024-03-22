import UIKit
import FirebaseCore
import FirebaseAnalytics

final class MainScreenController: UIViewController {
    
    
    
    var buttonTitle: String?
    var continentModel: Continents?
    var countriesEntity: [CountryEntity]?
    
    let decoder = JSONMapper()
    let coreDataManager = CoreDataManager()
    
    
    @IBOutlet weak var mainButtonsView: UIView!
    
    override func viewWillAppear(_ animated: Bool) {
        fetchingCountries()
        analytics()
    }
    
    override func viewDidLoad() {
        loadingCountries()
        setupUI()
    }
    
    // Getting the name of the button/ Analyse the name/ Perform segue to Quizz
    @IBAction func tapButtons(_ sender: UIButton) {
        guard let getNameFromButton = sender.titleLabel?.text else { return }
        buttonTitle = getNameFromButton
        
        Analytics.logEvent(getNameFromButton, parameters: [:])
        
        performSegue(withIdentifier: "goToQuizz", sender: self)
    }
    
    // Reset all the flags unlocked in the ListOfCountryController/CoreData
    @IBAction func tapResetFlags(_ sender: Any) {
        let alertVC = UIAlertController(title: "Supprimer", message: "Vous êtes sûr de vouloir reinitialiser vos dreapeaux à zéro ? Cette action est definitive. ", preferredStyle: UIAlertController.Style.alert)
        
        alertVC.addAction(UIAlertAction(title: "Non", style: UIAlertAction.Style.cancel, handler: nil))
        alertVC.addAction(UIAlertAction(title: "Oui", style: UIAlertAction.Style.destructive, handler:{ [weak self] action in
            do {
                guard let countriesToDelete = self?.countriesEntity else { return }
                try self?.coreDataManager.deletingAllCountries(countriesToDelete: countriesToDelete)
            } catch {
                self?.presentAlert()
            }
        }))
        self.present(alertVC, animated: true, completion: nil)
    }
    
    // Decoding the JSON with all our data (Continents, countries...)
    func loadingCountries() {
        let decoding = decoder.decode()
        switch decoding {
        case .success(let success):
            continentModel = success
        case .failure(_):
            presentAlert()
        }
    }
    
    // Fetching countries from CoreData
    func fetchingCountries() {
        do {
            countriesEntity = try coreDataManager.fetchCountries()
        } catch {
            presentAlert()
        }
    }
    
    // Method who handle's the correct data to send to the quizz (If the player click the "Europe" button, he gets a quizz with all the countries of Europe)
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let quizzController = segue.destination as? QuizzPageController else { return }
        guard let continent = continentModel else { return }
        
        switch buttonTitle {
        case "Europe":
            quizzController.titleContinent = "Europe"
            quizzController.countries = MainScreenEngine.randomizingCountries(countries: continent.europe)
            quizzController.countryNames = MainScreenEngine.randomizingCountriesNames(names: continent.europe)
        case "Amérique":
            quizzController.titleContinent = "Amérique"
            quizzController.countries = MainScreenEngine.randomizingCountries(countries: continent.amerique)
            quizzController.countryNames = MainScreenEngine.randomizingCountriesNames(names: continent.amerique)
        case "Asie":
            quizzController.titleContinent = "Asie"
            quizzController.countries = MainScreenEngine.randomizingCountries(countries: continent.asie)
            quizzController.countryNames = MainScreenEngine.randomizingCountriesNames(names: continent.asie)
        case "Afrique":
            quizzController.titleContinent = "Afrique"
            quizzController.countries = MainScreenEngine.randomizingCountries(countries: continent.afrique)
            quizzController.countryNames = MainScreenEngine.randomizingCountriesNames(names: continent.afrique)
        case "Océanie":
            quizzController.titleContinent = "Océanie"
            quizzController.countries = MainScreenEngine.randomizingCountries(countries: continent.oceanie)
            quizzController.countryNames = MainScreenEngine.randomizingCountriesNames(names: continent.oceanie)
        default:
            quizzController.titleContinent = "None"
        }
    }
    
    // Design for the border of the menu
    func setupUI() {
        mainButtonsView.layer.cornerRadius = 30
    }
    
    //Analytics to know stats on the player's behavior
    func analytics() {
        Analytics.logEvent(AnalyticsEventSelectContent, parameters: [
          AnalyticsParameterContentType: "cont",
        ])
    }
}

