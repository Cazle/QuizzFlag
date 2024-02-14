//
//  ViewController.swift
//  QuizzFlag
//
//  Created by Kyllian GUILLOT on 05/02/2024.
//

import UIKit

class ViewController: UIViewController {
    let decoder = DecodingJSON()
    var countries: [Country]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        loadCountries()
        
    }
    func loadCountries() {
        let decode = decoder.decode()
        
        switch decode {
        case .success(let success):
            countries = success.europe
            for (i, country) in success.europe.enumerated() {
                print("c'est le numéro \(i), et le pays est \(country.name) ")
            }
            print("Succeed")
        case .failure:
            print("it failed")
        }
    }

}

