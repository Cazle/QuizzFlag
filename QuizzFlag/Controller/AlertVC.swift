import Foundation
import UIKit

extension UIViewController {
    func presentAlert() {
        let alertVC = UIAlertController(title: "Erreur", message: "An error occured", preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        present(alertVC, animated: true, completion: nil)
    }
}
