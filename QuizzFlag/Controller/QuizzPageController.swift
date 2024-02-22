import Foundation
import UIKit

final class QuizzPageController: UIViewController {
    
    let quizzPage = QuizzPage()
    var countries: [Country]?
    var countryNames: [String]?
    
    var titleContinent: String?
    var lives = 3
    var numberOfTurn = 0
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var currentFlagImageView: UIImageView!
    @IBOutlet var allButtons: [UIButton]!
    @IBOutlet weak var turnLabel: UILabel!
    
    override func viewWillAppear(_ animated: Bool) {
        setTheContinentName()
        mainGame()
    }
    
    func mainGame() {
        checkIfTheGameIsFinished()
        
        settingTheResponses()
        
        let flag = quizzPage.getFilePathOfFlag(ofTheCurrentCountry: countries)
        guard let image = UIImage(named: flag) else { return }
        currentFlagImageView.image = image
        
        turnLabel.text = "Tour : \(numberOfTurn + 1)/10"
        
    }
    
    
    func settingTheResponses() {
        let correctResponse = quizzPage.getTheCorrectResponse(ofTheCurrentCountry: countries)
        guard let restOfResponses = countryNames?.shuffled() else { return }
        let responses = quizzPage.getFourResponses(fakeResponses: restOfResponses, correctResponse: correctResponse)
        
        allButtons[0].setTitle(responses[0], for: .normal)
        allButtons[1].setTitle(responses[1], for: .normal)
        allButtons[2].setTitle(responses[2], for: .normal)
        allButtons[3].setTitle(responses[3], for: .normal)
    }
    
    @IBAction func tapResponsesButtons(_ sender: UIButton) {
        
        guard countries != nil else { return }
        let correctResponse = quizzPage.getTheCorrectResponse(ofTheCurrentCountry: countries)
        guard let title = sender.titleLabel?.text else { return }
        
        if title == correctResponse {
            countries?.remove(at: 0)
            numberOfTurn += 1
            mainGame()
        } else {
            checkIfTheGameIsFinished()
            lives -= 1
            print("Lives = \(lives)")
        }
    }
    
    func setTheContinentName() {
        guard let title = titleContinent else { return }
        titleLabel.text = title
    }
    
    func checkIfTheGameIsFinished() {
        if numberOfTurn == 10 || lives == 0 {
            print("Do something to finish the game")
        }
    }
}
