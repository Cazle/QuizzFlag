import Foundation
import UIKit
import FirebaseAnalytics

final class CountryDescriptionController: UIViewController {
    
    
    @IBOutlet weak var flagImageView: UIImageView!
    @IBOutlet weak var coatOfArmsImageView: UIImageView!
    
    @IBOutlet weak var countryNameLabel: UILabel!
    @IBOutlet weak var capitalNameLabel: UILabel!
    
    
    var countryToShow: CountryEntity?
    
    override func viewDidLoad() {
        settingDescriptionPage()
        analytics()
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
    
    @IBAction func tapToGoWebsite(_ sender: Any) {
        guard let receivedUrl = countryToShow?.history else { return }
        
        guard let url = URL(string: receivedUrl) else { return }
        
        UIApplication.shared.open(url)
    }
    
    func analytics() {
        Analytics.logEvent(AnalyticsEventSelectContent, parameters: [
          AnalyticsParameterContentType: "cont",
        ])
    }
}
