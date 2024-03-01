import Foundation
import UIKit

final class ListOfCountryController: UIViewController {
    
    
    @IBOutlet var tableView: UITableView!
    
    let listOfCountryCell = ListOfCountryCell()
    var coreDataManager = CoreDataManager()
    var storedCountries: [CountryEntity]?
    
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
}

extension ListOfCountryController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        guard let allCountries = storedCountries else { return 0}
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
