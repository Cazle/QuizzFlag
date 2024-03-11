import Foundation
import UIKit

final class ListOfCountryCell: UITableViewCell {
    
    
    @IBOutlet weak var purlpleViewCell: UIView!
    @IBOutlet weak var flagView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    let identifier = "countryCell"
    
    func settingCell(country: CountryEntity){
        
        nameLabel.text = country.name
        
        guard let flagPath = country.flag else { return }
        let image = UIImage(named: flagPath)
        
        flagView.image = image
        
        purlpleViewCell.layer.cornerRadius = 30
    }
}
