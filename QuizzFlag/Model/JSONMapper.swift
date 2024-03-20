
import Foundation

final class JSONMapper {
    
    enum DecodingError: Error {
        case urlNotFound
        case decodingDidNotWork
    }
    
    let jsonData: String
    
    init(jsonData: String = "JSONCountries") {
        self.jsonData = jsonData
    }
    
    func decode() -> Result<Continents, Error> {
        
        guard let url = Bundle.main.url(forResource: jsonData, withExtension: "json") else {
            return .failure(DecodingError.urlNotFound)
        }
        
        guard let jsonDecoded = try? JSONDecoder().decode(Continents.self, from: Data(contentsOf: url)) else {
            return .failure(DecodingError.decodingDidNotWork)
        }
        
        return .success(jsonDecoded)
    }
}
