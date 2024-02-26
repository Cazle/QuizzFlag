import Foundation
import UIKit

final class QuizzPageController: UIViewController {
    
    let quizzPage = QuizzPage()
    var countries: [Country]?
    var countryNames: [String]?
    
    var titleContinent: String?
    var timer: Timer?
    
    @IBOutlet weak var progressBarView: UIProgressView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var currentFlagImageView: UIImageView!
    @IBOutlet var allButtons: [UIButton]!
    @IBOutlet weak var turnLabel: UILabel!
    @IBOutlet weak var lifeLabel: UILabel!
    
    
    override func viewWillAppear(_ animated: Bool) {
        titleLabel.text = quizzPage.setContinentName(name: titleContinent)
        mainGame()
    }
    
    func mainGame() {
        if quizzPage.checkIfTheGameHasEnded() {
            print("The game has ended in the main game !")
        }
        timer?.invalidate()
        timerBar()

        let responsesToDisplay = quizzPage.settingFourResponses(countries: countries, countryNames: countryNames)
        for (index, button) in allButtons.enumerated() {
            button.setTitle(responsesToDisplay[index], for: .normal)
        }
        
        let flag = quizzPage.getFilePathOfFlag(ofTheCurrentCountry: countries)
        guard let image = UIImage(named: flag) else { return }
        currentFlagImageView.image = image
        
        updatingTheLabels()
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
            quizzPage.lives -= 1
            relaunchTheTurn()
        }
    }
    
    func relaunchTheTurn() {
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
}
