import Foundation
import UIKit

final class CountryDescriptionController: UIViewController {
    
    
    @IBOutlet weak var flagImageView: UIImageView!
    @IBOutlet weak var coatOfArmsImageView: UIImageView!
    
    @IBOutlet weak var countryNameLabel: UILabel!
    @IBOutlet weak var capitalNameLabel: UILabel!
    
    
    var countryToShow: CountryEntity?
    
    override func viewDidLoad() {
        settingDescriptionPage()
    }
    
    private func settingDescriptionPage() {
        
        guard let country = countryToShow else { return }
        
        guard let flag = country.flag else { return }
        guard let coatOfArms = country.coatOfArms else { return }
        
        flagImageView.image = UIImage(named: flag)
        coatOfArmsImageView.image = UIImage(named: coatOfArms)
        
        countryNameLabel.text = country.name
        capitalNameLabel.text = country.capital
        
    }
}
