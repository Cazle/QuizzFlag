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
    
    @IBOutlet weak var mainButtonsView: UIView!
    
    override func viewWillAppear(_ animated: Bool) {
        fetchingCountriesFromCoreData()
    }
    
    override func viewDidLoad() {
        loadingCountries()
        design()
    }
   
    
    @IBAction func tapButtons(_ sender: UIButton) {
        guard let getNameFromButton = sender.titleLabel?.text else { return }
        buttonTitle = getNameFromButton
        performSegue(withIdentifier: "goToQuizz", sender: self)
    }
    
    @IBAction func tapResetFlags(_ sender: Any) {
        guard let countriesToDelete = countriesEntity else { return }
        coreDataManager.deletingAllCountries(countriesToDelete: countriesToDelete)
    }
    
    func loadingCountries() {
        let decoding = decoder.decode()
        switch decoding {
        case .success(let success):
            continentModel = success
        case .failure(let error):
            print("This \(error) occured.")
            
        }
    }
    func fetchingCountriesFromCoreData() {
        do {
          countriesEntity = try coreDataManager.fetchingCountries()
        } catch {
            print("Error from fetched")
        }
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let quizzController = segue.destination as? QuizzPageController else { return }
        guard let continent = continentModel else { return }
            
        switch buttonTitle {
        case "Europe":
            quizzController.titleContinent = "Europe"
            
            let randomCountries = continent.europe.shuffled()
            let getElevenCountries = Array(randomCountries.prefix(11))
            quizzController.countries = getElevenCountries
            
            let nameOfCountries = continent.europe.map {$0.name}.shuffled()
            quizzController.countryNames = nameOfCountries
        case "Amérique":
            quizzController.titleContinent = "Amérique"
        default:
            quizzController.titleContinent = "None"
        }
    }
    
    func design() {
        mainButtonsView.layer.cornerRadius = 30
    }
}

