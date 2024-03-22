import Foundation
import UIKit

final class ListOfCountryCell: UITableViewCell {
    
    
    @IBOutlet weak var purlpleViewCell: UIView!
    @IBOutlet weak var flagView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    //Identifier needed for the cell
    let identifier = "countryCell"
    
    // Setting the infos and the design on the cell
    func settingCell(country: CountryEntity){
        
        nameLabel.text = country.name
        
        guard let flagPath = country.flag else { return }
        let image = UIImage(named: flagPath)
        
        flagView.image = image
        
        purlpleViewCell.layer.cornerRadius = 30
    }
}
