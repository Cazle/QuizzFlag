import Foundation
import UIKit

final class QuizzPageController: UIViewController {
    
    let quizzPage = QuizzPage()
    var countries: [Country]?
    var countryNames: [String]?
    
    var titleContinent: String?
    var lives = 3
    var numberOfTurn = 0
    var timer: Timer?
    
    @IBOutlet weak var progressBarView: UIProgressView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var currentFlagImageView: UIImageView!
    @IBOutlet var allButtons: [UIButton]!
    @IBOutlet weak var turnLabel: UILabel!
    @IBOutlet weak var lifeLabel: UILabel!
    
    
    override func viewWillAppear(_ animated: Bool) {
        setTheContinentName()
        mainGame()
    }
    
    func mainGame() {
        if quizzPage.checkIfTheGameHasEnded(numberOfTurn: numberOfTurn, numberOfLives: lives) {
            print("The game has ended in the main game !")
        }
        timerBar()
        settingTheResponses()
        
        let flag = quizzPage.getFilePathOfFlag(ofTheCurrentCountry: countries)
        guard let image = UIImage(named: flag) else { return }
        currentFlagImageView.image = image
        
        turnLabel.text = "Tour : \(numberOfTurn + 1)/10"
        lifeLabel.text = "Vies : \(lives)/3"
        
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
    
    @IBAction func tapBackButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
        timer?.invalidate()
    }
    
    @IBAction func tapResponsesButtons(_ sender: UIButton) {
        
        guard countries != nil else { return }
        let correctResponse = quizzPage.getTheCorrectResponse(ofTheCurrentCountry: countries)
        guard let title = sender.titleLabel?.text else { return }
        
        if title == correctResponse {
            relaunchTheTurn()
        } else {
            lives -= 1
            print("Lives = \(lives)")
            if quizzPage.checkIfTheGameHasEnded(numberOfTurn: numberOfTurn, numberOfLives: lives) {
                print("game has ended !")
            }
            relaunchTheTurn()
        }
    }
    
    func setTheContinentName() {
        guard let title = titleContinent else { return }
        titleLabel.text = title
    }
    func relaunchTheTurn() {
        countries?.remove(at: 0)
        numberOfTurn += 1
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
                self?.lives -= 1
                self?.relaunchTheTurn()
                timer.invalidate()
            }
        }
    }
}
