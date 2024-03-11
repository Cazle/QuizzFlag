import Foundation
import UIKit

final class ListOfCountryController: UIViewController {
    
    
    @IBOutlet var tableView: UITableView!
    @IBOutlet weak var purpleViewCell: UIView!
    
    let listOfCountryCell = ListOfCountryCell()
    var coreDataManager = CoreDataManager()
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
            storedCountries = try coreDataManager.fetchingCountries()
            tableView.reloadData()
        } catch {
            print("error from the tableview")
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "listToDescription", let destination = segue.destination as? CountryDescriptionController else { return }
        destination.countryToShow = selectedCountry
    }
    func settingBackgroundImage() {
        tableView.backgroundView = UIImageView(image: UIImage(named: "List_Description.png"))
    }
}

extension ListOfCountryController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let storedCountries = storedCountries else { return }
        let currentCountry = storedCountries[indexPath.row]
        selectedCountry = currentCountry
    
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
        
        let country = countries[indexPath.row]
        
        cell.settingCell(country: country)
        
        return cell
    }

}
