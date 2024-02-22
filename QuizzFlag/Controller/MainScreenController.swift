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
    let decoder = DecodingJSON()
    
    @IBOutlet weak var backGroundImage: UIImageView!
    
    override func viewDidLoad() {
        loadingCountries()
    }
   
    
    @IBAction func tapButtons(_ sender: UIButton) {
        guard let getNameFromButton = sender.titleLabel?.text else { return }
        buttonTitle = getNameFromButton
        performSegue(withIdentifier: "goToQuizz", sender: self)
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
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let quizzController = segue.destination as? QuizzPageController else { return }
        guard let continent = continentModel else { return }
            
        switch buttonTitle {
        case "Europe":
            quizzController.titleContinent = "Europe"
            
            let randomCountries = continent.europe.shuffled()
            let getTenCountries = Array(randomCountries.prefix(10))
            quizzController.countries = getTenCountries
            
            let nameOfCountries = continent.europe.map {$0.name}.shuffled()
            quizzController.countryNames = nameOfCountries
        case "Amérique":
            quizzController.titleContinent = "Amérique"
        default:
            quizzController.titleContinent = "None"
        }
    }
}

