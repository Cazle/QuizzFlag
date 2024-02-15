//
//  ViewController.swift
//  QuizzFlag
//
//  Created by Kyllian GUILLOT on 05/02/2024.
//

import UIKit

class MainScreenController: UIViewController {
    
    var buttonTitle: String?
    var continentModel: Model?
    
    let decoder = DecodingJSON()
    
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
        guard let quizzController = segue.destination as? QuizzPage else { return }
        
            
        switch buttonTitle {
        case "Europe":
            quizzController.titleOfTheContinent = "Europe"
            guard let continent = continentModel else { return }
            quizzController.continentChosen = continent.europe
            
        case "Amérique":
            quizzController.titleOfTheContinent = "Amérique"
        default:
            quizzController.titleOfTheContinent = "None"
        }
    }
}

