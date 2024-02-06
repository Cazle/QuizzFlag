//
//  ViewController.swift
//  QuizzFlag
//
//  Created by Kyllian GUILLOT on 05/02/2024.
//

import UIKit

class ViewController: UIViewController {
    let europeanCountries = European().countries
    
    override func viewDidLoad() {
        super.viewDidLoad()
       test()
    }
   
    
    func test() {
        for country in europeanCountries {
            print(country.name)
        }
    }

}

