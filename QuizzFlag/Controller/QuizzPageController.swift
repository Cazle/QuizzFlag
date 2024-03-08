import Foundation
import UIKit

final class QuizzPageController: UIViewController {
    
    let quizzEngine = QuizzEngine()
    let timerComponent = TimerComponent()
    let coreDataManager = CoreDataManager()
    
    
    var countries: [Country]?
    var countryNames: [String]?
    var titleContinent: String?
    var fetchedCountries: [CountryEntity]?
    
    
    @IBOutlet weak var gameOverScreen: UIView!
    @IBOutlet weak var mainView: UIView!
    
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
        mainViewDesign()
        fetchingCountries()
        titleLabel.text = quizzEngine.setContinentName(name: titleContinent)
        mainGame()
    }
    // MARK: - IBActions of the quizz
    
    @IBAction func tapBackButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
        timerComponent.stopTheTimer()
    }
    
    
    @IBAction func tapResponsesButtons(_ sender: UIButton) {
        
        guard countries != nil else { return }
        let correctResponse = quizzEngine.getTheCorrectResponse(ofTheCurrentCountry: countries)
        guard let title = sender.titleLabel?.text else { return }
        
        if title == correctResponse {
            checkingBeforeAddingCountry(countryName: correctResponse)
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
    
    
    // MARK: - Style of buttons and handling them and desing
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
    
    func mainViewDesign() {
        mainView.layer.cornerRadius = 30
    }
    
    // MARK: - Main methods for the quizz
    
    func mainGame() {
        fetchingCountries()
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
    
    func timerBar() {
        
        let correctResponse = quizzEngine.getTheCorrectResponse(ofTheCurrentCountry: countries)
        
        var progress: Float = 0.0
        
        progressBarView.progress =  progress
        
        timerComponent.timer {
            progress += 0.1
            self.progressBarView.setProgress(progress, animated: true)
            
            if self.progressBarView.progress == 1 {
                self.timerComponent.stopTheTimer()
                self.coloringTheCorrectResponse(correctResponse: correctResponse)
                progress = 0.0
                self.nextFlagButtonView.isHidden = false
                
            }
        }
    }
    
    func relaunchTheTurn() {
        timerComponent.stopTheTimer()
        countries?.remove(at: 0)
        quizzEngine.numberOfTurn += 1
        mainGame()
    }
    
    func updatingTheLabels() {
        turnLabel.text = quizzEngine.settingTurn()
        lifeLabel.text = quizzEngine.settingLives()
    }
    
    func displayGameOver() {
        gameOverScreen.isHidden = false
        mainView.isHidden = true
    }
    
    func checkIfTheGameHasEnded() {
        
        guard let guessedCountries = quizzEngine.guessedCountries else { return }
        
        switch quizzEngine.checkTheStateOfTheGame() {
        case .win:
            timerComponent.stopTheTimer()
            addingAllTheCountriesDiscovered(countriesDiscovered: guessedCountries)
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
    
    //MARK: - CoreData methods
    
    func fetchingCountries() {
        do {
            fetchedCountries = try coreDataManager.fetchingCountries()
        } catch {
            print("Error from fetched")
        }
    }
    
    func checkingBeforeAddingCountry(countryName: String) {
        if coreDataManager.countryIsExisting(named: countryName) == false {
            quizzEngine.addingCountryForCorrectResponse(addingCountryFrom: countries)
        }
    }
    
    func addingAllTheCountriesDiscovered(countriesDiscovered: [Country]) {
        
        for country in countriesDiscovered {
            let _ = coreDataManager.unlockNewCountries(guessedCountryIn: countriesDiscovered, name: country.name, history: country.flagHistory, flag: country.flag, coatOfArms: country.coatOfArms, capital: country.capital, continent: country.continent)
        }
        do {
            try coreDataManager.savingContext()
        } catch {
            print("Error from saving")
        }
    }
    
    func deletingAllCountries() {
        
        guard let countriesToDelete = fetchedCountries else { return }
        
        for countries in countriesToDelete {
            coreDataManager.deletingCountry(deleting: countries)
        }
        do {
            try coreDataManager.savingContext()
        } catch {
            print("Error deleting")
        }
        
    }
}



