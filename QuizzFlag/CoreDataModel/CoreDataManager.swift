import Foundation
import CoreData

final class CoreDataManager {
    
    let context: NSManagedObjectContext
    
    init(context: NSManagedObjectContext = AppDelegate().backgroundContext) {
        self.context = context
    }
    
}
