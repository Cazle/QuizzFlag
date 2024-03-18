
import Foundation

final class JSONMapper {
    
    enum DecodingError: Error {
        case urlNotFound
        case decodingDidNotWork
    }
    
    var jsonData = "JSONCountries"
  
    func decode() -> Result<Model, Error> {
        
        guard let url = Bundle.main.url(forResource: jsonData, withExtension: "json") else {
            return .failure(DecodingError.urlNotFound)
        }
        
        guard let jsonDecoded = try? JSONDecoder().decode(Model.self, from: Data(contentsOf: url)) else {
            return .failure(DecodingError.decodingDidNotWork)
        }
        
        return .success(jsonDecoded)
    }
}
