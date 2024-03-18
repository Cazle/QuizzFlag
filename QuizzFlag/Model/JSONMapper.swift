
import Foundation

final class JSONMapper {
    
    enum DecodingError: Error {
        case urlNotFound
        case dataNotFound
        case decodingDidNotWork
    }
    
    var jsonData = "JSONCountries"
    var data: Data
    
    init(data: Data = Data()) {
        self.data = data
    }
    
    func decode() -> Result<Model, Error> {
        
        guard let url = Bundle.main.url(forResource: jsonData, withExtension: "json") else {
            return .failure(DecodingError.urlNotFound)
        }
        do {
            self.data = try Data(contentsOf: url)
        } catch {
            return .failure(DecodingError.dataNotFound)
        }
        
        
        guard let jsonDecoded = try? JSONDecoder().decode(Model.self, from: data) else {
            return .failure(DecodingError.decodingDidNotWork)
        }
        
        return .success(jsonDecoded)
    }
}
