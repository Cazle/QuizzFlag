import Foundation
import UIKit

final class QuizzPageController: UIViewController {
    
    let quizzEngine = QuizzEngine()
    let timerComponent = TimerComponent()
    
    var countries: [Country]?
    var countryNames: [String]?
    var titleContinent: String?
    
    
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
        titleLabel.text = quizzEngine.setContinentName(name: titleContinent)
        mainGame()
    }
    
    func mainGame() {
        timerBar()
        checkIfTheGameHasEnded()
        updatingTheLabels()
        
        let responsesToDisplay = quizzEngine.settingFourResponses(countries: countries, countryNames: countryNames)
        for (index, button) in allButtons.enumerated() {
            button.setTitle(responsesToDisplay[index], for: .normal)
        }
        
        let flag = quizzEngine.getFilePathOfFlag(ofTheCurrentCountry: countries)
        guard let image = UIImage(named: flag) else { return }
        currentFlagImageView.image = image
    }
    
    @IBAction func tapBackButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
        timerComponent.stopTheTimer()
    }
    
    @IBAction func tapResponsesButtons(_ sender: UIButton) {
        
        guard countries != nil else { return }
        let correctResponse = quizzEngine.getTheCorrectResponse(ofTheCurrentCountry: countries)
        guard let title = sender.titleLabel?.text else { return }
        
        if title == correctResponse {
            quizzEngine.addingCountryForCorrectResponse(addingCountryFrom: countries)
            relaunchTheTurn()
        } else {
            timerComponent.stopTheTimer()
            coloringTheCorrectResponse(correctResponse: correctResponse)
            nextFlagButtonView.isHidden = false
        }
    }
    @IBAction func nextFlagButton(_ sender: Any) {
        nextFlagButtonView.isHidden = true
        resettingTheButtonsColorToNormal()
        quizzEngine.lives -= 1
        relaunchTheTurn()
    }
    
    func relaunchTheTurn() {
        timerComponent.stopTheTimer()
        countries?.remove(at: 0)
        quizzEngine.numberOfTurn += 1
        mainGame()
    }
    
    func timerBar() {
        
        let correctResponse = quizzEngine.getTheCorrectResponse(ofTheCurrentCountry: countries)
        
        var progress: Float = 0.0
        progressBarView.progress = progress
        
        timerComponent.timer {
            
            progress += 0.1
            self.progressBarView.progress = progress
            
            print("Progress = \(progress)")
            if self.progressBarView.progress == 1 {
                self.timerComponent.stopTheTimer()
                self.coloringTheCorrectResponse(correctResponse: correctResponse)
                progress = 0.0
                self.nextFlagButtonView.isHidden = false
                
            }
        }
    }
    
    
    func updatingTheLabels() {
        turnLabel.text = quizzEngine.settingTurn()
        lifeLabel.text = quizzEngine.settingLives()
    }
    
    func displayGameOver() {
        gameOverScreen.isHidden = false
    }
    
    func checkIfTheGameHasEnded() {
        switch quizzEngine.checkTheStateOfTheGame() {
        case .win:
            timerComponent.stopTheTimer()
                displayGameOver()
                gameOverLabel.text = quizzEngine.winMessage
                numberOfFlagsAddedLabel.isHidden = false
                numberOfFlagsAddedLabel.text = quizzEngine.discoveryMessage()
        case .lose:
            timerComponent.stopTheTimer()
                displayGameOver()
                numberOfFlagsAddedLabel.isHidden = true
                gameOverLabel.text = quizzEngine.loseMessage
        case .ongoing:
            break
        }
    }
    
    func coloringTheCorrectResponse(correctResponse: String) {
        for button in allButtons {
            button.isUserInteractionEnabled = false
            if button.titleLabel?.text == correctResponse {
                button.tintColor = .green
            } else {
                button.tintColor = .red
            }
        }
    }
    
    func resettingTheButtonsColorToNormal() {
        for button in allButtons {
            button.isUserInteractionEnabled = true
            button.tintColor = .systemBlue
        }
    }
}
