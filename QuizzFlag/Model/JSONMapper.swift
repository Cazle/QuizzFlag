
import Foundation

final class JSONMapper {
    
    enum DecodingError: Error {
        case urlNotFound
        case decodingDidNotWork
    }
    
    let jsonData: String
    
    // Init to pass the JSON name of our choice, useful for tests
    init(jsonData: String = "JSONCountries") {
        self.jsonData = jsonData
    }
    
    // Decoding our JSON and return it
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
