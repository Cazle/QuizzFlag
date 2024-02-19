import Foundation
import UIKit

final class QuizzPageController: UIViewController {
    
    let quizzPage = QuizzPage()
    var countries: [Country]?
    
    var titleContinent: String?
    var countryOfTheFlag: String?
    var lives = 3
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var currentFlagImageView: UIImageView!
    @IBOutlet var allButtons: [UIButton]!
    
    override func viewWillAppear(_ animated: Bool) {
        setTheContinentName()
        mainGame()
    
    }
    
    func mainGame() {
        settingTheResponses()
        guard let correctResponse = getTheResponse() else { return }
        
        let flag = loadTheFlag()
        currentFlagImageView.image = flag
        
    }
    
    func getTheResponse() -> String? {
        guard let countries = countries else { return "" }
        let firstCountries = countries.first
        
        return firstCountries?.name
    }
    
    func loadTheFlag() -> UIImage {
        guard let countries = countries else { return UIImage() }
        let firstCountries = countries.first
        
        guard let getThePath = firstCountries?.flag else { return UIImage()}
        guard let image = UIImage(named: getThePath) else { return UIImage()}
        
        return image
    }
    
    func settingTheResponses() {
        guard let countries = countries else { return }
        guard let correctResponse = getTheResponse() else { return }
        let responses = quizzPage.getFourResponses(countries: countries, correctResponse: correctResponse)
        
        allButtons[0].setTitle(responses[0], for: .normal)
        allButtons[1].setTitle(responses[1], for: .normal)
        allButtons[2].setTitle(responses[2], for: .normal)
        allButtons[3].setTitle(responses[3], for: .normal)
    }
    
    @IBAction func tapResponsesButtons(_ sender: UIButton) {
                
        guard countries != nil else { return }
        guard let correctResponse = getTheResponse() else { return }
        guard let title = sender.titleLabel?.text else { return }
        
        if title == correctResponse {
            countries?.remove(at: 0)
            mainGame()
        } else {
            lives -= 1
            print("Lives = \(lives)")
            print("Meh...")
        }
    }
    
    func setTheContinentName() {
        guard let title = titleContinent else { return }
        titleLabel.text = title
    }
}
