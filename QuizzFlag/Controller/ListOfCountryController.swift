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
    
    func fetchingCountries() {
        do {
            storedCountries = try coreDataManager.fetchCountries()
            tableView.reloadData()
        } catch {
            presentAlert()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "listToDescription", let destination = segue.destination as? CountryDescriptionController else { return }
        destination.countryToShow = selectedCountry
    }
    
    func settingBackgroundImage() {
        tableView.backgroundView = UIImageView(image: UIImage(named: "country_description.png"))
    }
}

extension ListOfCountryController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let storedCountries = storedCountries else { return }
        let sortedCountries = storedCountries.sorted {$0.name ?? "" < $1.name ?? ""}
        let currentCountry = sortedCountries[indexPath.row]
        selectedCountry = currentCountry
        
        Analytics.logEvent(currentCountry.name ?? "", parameters: [:])
        
        performSegue(withIdentifier: "listToDescription", sender: self)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let allCountries = storedCountries else { return 0 }
        return allCountries.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: listOfCountryCell.identifier, for: indexPath) as? ListOfCountryCell else { return UITableViewCell() }
        
        guard let countries = storedCountries else { return UITableViewCell()}
        
        let sortedCountries = countries.sorted {$0.name ?? "" < $1.name ?? ""}
        
        let country = sortedCountries[indexPath.row]
        
        cell.settingCell(country: country)
        
        return cell
    }
    
}
