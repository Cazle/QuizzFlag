import Foundation
import UIKit

final class QuizzPage: UIViewController {
    
    var titleOfTheContinent: String?
    var continentChosen: [Country]?
    
    @IBOutlet weak var titleLabel: UILabel!
    
    override func viewWillAppear(_ animated: Bool) {
        guard let title = titleOfTheContinent else { return }
        titleLabel.text = title
    }
    override func viewDidLoad() {
        guard let countries = continentChosen else { return }
        for country in countries {
            print(country.name)
        }
    }
}
