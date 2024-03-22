import Foundation
import UIKit
import FirebaseAnalytics

final class ListOfCountryController: UIViewController {
    
    
    @IBOutlet var tableView: UITableView!
    
    let listOfCountryCell = ListOfCountryCell()
    let coreDataManager = CoreDataManager()
    
    var storedCountries: [CountryEntity]?
    var selectedCountry: CountryEntity?
    
    override func viewDidLoad() {
        settingBackgroundImage()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        fetchingCountries()
    }
    
    // Fetching countries from CoreData
    func fetchingCountries() {
        do {
            storedCountries = try coreDataManager.fetchCountries()
            tableView.reloadData()
        } catch {
            presentAlert()
        }
    }
    
    // Prepare the segue and change the value of countryToShow in CountryDescriptionController
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "listToDescription", let destination = segue.destination as? CountryDescriptionController else { return }
        destination.countryToShow = selectedCountry
    }
    
    // Setting the background image of the tableView
    func settingBackgroundImage() {
        tableView.backgroundView = UIImageView(image: UIImage(named: "country_description.png"))
    }
}

extension ListOfCountryController: UITableViewDelegate, UITableViewDataSource {
    
    //When the user click on a country, he gets redirected with the selected country with the correct infos etc / Get the name of country and send it to Firebase / Perform segue to CountryDescriptionController
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let storedCountries = storedCountries else { return }
        let sortedCountries = storedCountries.sorted {$0.name ?? "" < $1.name ?? ""}
        let currentCountry = sortedCountries[indexPath.row]
        selectedCountry = currentCountry
        
        Analytics.logEvent(currentCountry.name ?? "", parameters: [:])
        
        performSegue(withIdentifier: "listToDescription", sender: self)
    }
    
    // The number of countries to display in the tableView
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let allCountries = storedCountries else { return 0 }
        return allCountries.count
    }
    
    // One section needed
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    // Configure the cell, display them in an alphabetical order
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: listOfCountryCell.identifier, for: indexPath) as? ListOfCountryCell else { return UITableViewCell() }
        
        guard let countries = storedCountries else { return UITableViewCell()}
        
        let sortedCountries = countries.sorted {$0.name ?? "" < $1.name ?? ""}
        
        let country = sortedCountries[indexPath.row]
        
        cell.settingCell(country: country)
        
        return cell
    }
    
}
