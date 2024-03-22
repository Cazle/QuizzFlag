import Foundation
import UIKit
import FirebaseAnalytics

final class QuizzPageController: UIViewController {
    
    let quizzEngine = QuizzEngine()
    let timerComponent = TimerComponent()
    let coreDataManager = CoreDataManager()
    
    
    var countries: [Country] = []
    var countryNames: [String] = []
    var titleContinent: String = ""
    var fetchedCountries: [CountryEntity]?
    
    
    @IBOutlet weak var gameOverScreen: UIView!
    @IBOutlet weak var mainView: UIView!
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var turnLabel: UILabel!
    @IBOutlet weak var lifeLabel: UILabel!
    @IBOutlet weak var gameOverLabel: UILabel!
    @IBOutlet weak var numberOfFlagsAddedLabel: UILabel!
    @IBOutlet weak var returnToMenuButton: UIButton!
    
    @IBOutlet weak var currentFlagImageView: UIImageView!
    @IBOutlet weak var progressBarView: UIProgressView!
    
    @IBOutlet weak var nextFlagButtonView: UIButton!
    @IBOutlet var allButtons: [UIButton]!
    
    
    override func viewWillAppear(_ animated: Bool) {
        Analytics.logEvent("QuizzLaunched", parameters: [:])
        setupUI()
        fetchingCountries()
        titleLabel.text = quizzEngine.setContinentName(name: titleContinent)
        mainGame()
    }
    
    // MARK: - IBActions of the quizz
    
    // Go back to main menu and stops timer
    @IBAction func tapBackButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
        timerComponent.stopTheTimer()
    }
    
    // Handle the case where the player gets a correct or wrong response
    @IBAction func tapResponsesButtons(_ sender: UIButton) {
        
        let correctResponse = quizzEngine.getTheCorrectResponse(ofTheCurrentCountry: countries)
        guard let title = sender.titleLabel?.text else { return }
        
        Analytics.logEvent(title, parameters: [:])
        
        if title == correctResponse {
            checkingBeforeAddingCountry(countryName: correctResponse, countries: countries)
            relaunchTheTurn()
        } else {
            timerComponent.stopTheTimer()
            coloringTheCorrectResponse(correctResponse: correctResponse)
            nextFlagButtonView.isHidden = false
        }
    }
    
    // This button is hidden and is showed if the player gets a bad answer, or runs out of time. Resets buttons to normal, the player lose a life, and relaunch a turn
    @IBAction func nextFlagButton(_ sender: Any) {
        nextFlagButtonView.isHidden = true
        resettingTheButtonsColorToNormal()
        quizzEngine.lives -= 1
        relaunchTheTurn()
    }
    
    
    // MARK: - Style of buttons and handling them and desing
    
    // Show the correct response in green, and the bad ones in red, and disable all the buttons
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
    
    // Resetting the buttons to blue, and re-enable all the buttons
    func resettingTheButtonsColorToNormal() {
        for button in allButtons {
            button.isUserInteractionEnabled = true
            button.tintColor = .systemBlue
        }
    }
    // Design for borders
    func setupUI() {
        mainView.layer.cornerRadius = 30
        gameOverScreen.layer.cornerRadius = 30
    }
    
    // MARK: - Main methods for the quizz
    
    // Fetch the countries from CoreData/ Start Timer/ Check the state of the game/ Update lives and turns/ Display responses on the buttons/ Set the image of the current country to guess
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
    
    //Function to handle timer and the progressView. Duration : 10 Seconds
    func timerBar() {
        
        let correctResponse = quizzEngine.getTheCorrectResponse(ofTheCurrentCountry: countries)
        
        var progress: Float = 0.0
        
        progressBarView.progress = progress
        
        timerComponent.timer {[weak self] in
            guard let self = self else { return }
            progress += 0.01
            self.progressBarView.setProgress(progress, animated: true)
            
            if self.progressBarView.progress == 1 {
                self.timerComponent.stopTheTimer()
                self.coloringTheCorrectResponse(correctResponse: correctResponse)
                progress = 0.0
                self.nextFlagButtonView.isHidden = false
                
            }
        }
    }
    
    // Stops the timer / Remove a country from the array to go to the next country / Plus 1 turn / Relaunch MainGame()
    func relaunchTheTurn() {
        timerComponent.stopTheTimer()
        countries.remove(at: 0)
        quizzEngine.numberOfTurn += 1
        mainGame()
    }
    
    // Updates lives and turns
    func updatingTheLabels() {
        turnLabel.text = quizzEngine.settingTurn()
        lifeLabel.text = quizzEngine.settingLives()
    }
    
    // Check on each turn if the player has lose or won
    func checkIfTheGameHasEnded() {
        switch quizzEngine.checkTheStateOfTheGame() {
        case .win:
            winningTheGame(withThoseCountryDiscovered: quizzEngine.guessedCountries)
        case .lose:
            losingTheGame()
        case .ongoing:
            break
        }
    }
    
    // Stops timer, display the game over screen and hiding the rests of the views
    func displayGameOver() {
        timerComponent.stopTheTimer()
        gameOverScreen.isHidden = false
        mainView.isHidden = true
        titleLabel.isHidden = true
        returnToMenuButton.isHidden = true
    }
    
    // Method to add all the countries the player guessed, and tell him how many flags he won
    func winningTheGame(withThoseCountryDiscovered: [Country]) {
        do {
            try coreDataManager.addingAllTheCountriesDiscovered(countriesDiscovered: withThoseCountryDiscovered)
        } catch {
            presentAlert()
        }
        displayGameOver()
        gameOverLabel.text = quizzEngine.winMessage
        numberOfFlagsAddedLabel.isHidden = false
        numberOfFlagsAddedLabel.text = quizzEngine.discoveryMessage()
    }
    
    // Tell the player that he lost
    func losingTheGame() {
        displayGameOver()
        numberOfFlagsAddedLabel.isHidden = true
        gameOverLabel.text = quizzEngine.loseMessage
    }
    
    //MARK: - CoreData methods
    
    //Fetching countries from CoreData
    func fetchingCountries() {
        do {
            fetchedCountries = try coreDataManager.fetchCountries()
        } catch {
            presentAlert()
        }
    }
    
    //If the player has already found a country in the previous quizz, he doesn't unlock it again. Otherwise, he discovers it
    func checkingBeforeAddingCountry(countryName: String, countries: [Country]) {
        if coreDataManager.isCountryExisting(named: countryName) == false {
            quizzEngine.addingCountryForCorrectResponse(addingCountryFrom: countries)
        }
    }
}



