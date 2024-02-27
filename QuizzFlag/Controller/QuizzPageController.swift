import Foundation
import UIKit

final class QuizzPageController: UIViewController {
    
    let quizzPage = QuizzPage()
    var countries: [Country]?
    var countryNames: [String]?
    
    var titleContinent: String?
    var timer: Timer?
    
    @IBOutlet weak var quizzScreenStackView: UIStackView!
    @IBOutlet weak var gameOverScreen: UIView!
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var turnLabel: UILabel!
    @IBOutlet weak var lifeLabel: UILabel!
    @IBOutlet weak var gameOverLabel: UILabel!
    @IBOutlet weak var numberOfFlagsAddedLabel: UILabel!
    
    
    @IBOutlet weak var currentFlagImageView: UIImageView!
    @IBOutlet weak var progressBarView: UIProgressView!
    
    @IBOutlet weak var nextFlagButtonView: UIButton!
    @IBOutlet var allButtons: [UIButton]!
    
    
    override func viewWillAppear(_ animated: Bool) {
        titleLabel.text = quizzPage.setContinentName(name: titleContinent)
        mainGame()
    }
    
    func mainGame() {
        timerBar()
        checkIfTheGameHasEnded()
        updatingTheLabels()
        
        let responsesToDisplay = quizzPage.settingFourResponses(countries: countries, countryNames: countryNames)
        for (index, button) in allButtons.enumerated() {
            button.setTitle(responsesToDisplay[index], for: .normal)
        }
        
        let flag = quizzPage.getFilePathOfFlag(ofTheCurrentCountry: countries)
        guard let image = UIImage(named: flag) else { return }
        currentFlagImageView.image = image
    }
    
    @IBAction func tapBackButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
        timer?.invalidate()
    }
    
    @IBAction func tapResponsesButtons(_ sender: UIButton) {
        
        guard countries != nil else { return }
        let correctResponse = quizzPage.getTheCorrectResponse(ofTheCurrentCountry: countries)
        guard let title = sender.titleLabel?.text else { return }
        
        if title == correctResponse {
            quizzPage.addingCountryForCorrectResponse(addingCountryFrom: countries)
            relaunchTheTurn()
        } else {
            timer?.invalidate()
            coloringTheCorrectResponse(correctResponse: correctResponse)
            nextFlagButtonView.isHidden = false
        }
    }
    @IBAction func nextFlagButton(_ sender: Any) {
        resettingTheButtonsColorToNormal()
        quizzPage.lives -= 1
        relaunchTheTurn()
    }
    
    func relaunchTheTurn() {
        timer?.invalidate()
        countries?.remove(at: 0)
        quizzPage.numberOfTurn += 1
        mainGame()
    }
    
    func timerBar() {
        var progress: Float = 0.0
        progressBarView.progress = progress
        
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) {[weak self] timer in
            
            progress += 0.1
            
            self?.progressBarView.progress = progress
            
            if self?.progressBarView.progress == 1 {
                print ("10 sec")
                progress = 0.0
                self?.quizzPage.lives -= 1
                self?.relaunchTheTurn()
                timer.invalidate()
            }
        }
    }
    
    func updatingTheLabels() {
        turnLabel.text = quizzPage.settingTurn()
        lifeLabel.text = quizzPage.settingLives()
    }
    
    func displayGameOver() {
        gameOverScreen.isHidden = false
    }
    
    func checkIfTheGameHasEnded() {
        switch quizzPage.checkTheStateOfTheGame() {
        case .win:
                timer?.invalidate()
                displayGameOver()
                gameOverLabel.text = quizzPage.winMessage
                numberOfFlagsAddedLabel.isHidden = false
                numberOfFlagsAddedLabel.text = quizzPage.discoveryMessage()
        case .lose:
            timer?.invalidate()
                displayGameOver()
                numberOfFlagsAddedLabel.isHidden = true
                gameOverLabel.text = quizzPage.loseMessage
        case .ongoing:
            break
        }
    }
    
    func coloringTheCorrectResponse(correctResponse: String) {
        for button in allButtons {
            if button.titleLabel?.text == correctResponse {
                button.tintColor = .green
            } else {
                button.tintColor = .red
            }
        }
    }
    func resettingTheButtonsColorToNormal() {
        for button in allButtons {
            button.tintColor = .systemBlue
        }
    }
}
