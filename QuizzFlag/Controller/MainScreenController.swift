//
//  ViewController.swift
//  QuizzFlag
//
//  Created by Kyllian GUILLOT on 05/02/2024.
//

import UIKit

final class MainScreenController: UIViewController {
    
    var buttonTitle: String?
    var continentModel: Model?
    var countriesEntity: [CountryEntity]?
    
    let decoder = JSONMapper()
    let coreDataManager = CoreDataManager()
    let mainScreenEngine = MainScreenEngine()
    
    @IBOutlet weak var mainButtonsView: UIView!
    
    override func viewWillAppear(_ animated: Bool) {
        fetchingCountries()
    }
    
    override func viewDidLoad() {
        loadingCountries()
        setupUI()
    }
   
    
    @IBAction func tapButtons(_ sender: UIButton) {
        guard let getNameFromButton = sender.titleLabel?.text else { return }
        buttonTitle = getNameFromButton
        performSegue(withIdentifier: "goToQuizz", sender: self)
    }
    
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
    
    func loadingCountries() {
        let decoding = decoder.decode()
        switch decoding {
        case .success(let success):
            continentModel = success
        case .failure(_):
            presentAlert()
        }
    }
    func fetchingCountries() {
        do {
          countriesEntity = try coreDataManager.fetchCountries()
        } catch {
            presentAlert()
        }
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let quizzController = segue.destination as? QuizzPageController else { return }
        guard let continent = continentModel else { return }
            
        switch buttonTitle {
        case "Europe":
            quizzController.titleContinent = "Europe"
            quizzController.countries = mainScreenEngine.randomizingCountries(countries: continent.europe)
            quizzController.countryNames = mainScreenEngine.randomizingCountriesNames(names: continent.europe)
        case "Amérique":
            quizzController.titleContinent = "Amérique"
            quizzController.countries = mainScreenEngine.randomizingCountries(countries: continent.amerique)
            quizzController.countryNames = mainScreenEngine.randomizingCountriesNames(names: continent.amerique)
        case "Asie":
            quizzController.titleContinent = "Asie"
            quizzController.countries = mainScreenEngine.randomizingCountries(countries: continent.asie)
            quizzController.countryNames = mainScreenEngine.randomizingCountriesNames(names: continent.asie)
        case "Afrique":
            quizzController.titleContinent = "Afrique"
            quizzController.countries = mainScreenEngine.randomizingCountries(countries: continent.afrique)
            quizzController.countryNames = mainScreenEngine.randomizingCountriesNames(names: continent.afrique)
        case "Océanie":
            quizzController.titleContinent = "Océanie"
            quizzController.countries = mainScreenEngine.randomizingCountries(countries: continent.oceanie)
            quizzController.countryNames = mainScreenEngine.randomizingCountriesNames(names: continent.oceanie)
        default:
            quizzController.titleContinent = "None"
        }
    }

    
    func setupUI() {
        mainButtonsView.layer.cornerRadius = 30
    }
}

