
import Foundation

final class JSONMapper {
    
    enum DecodingError: Error {
        case urlNotFound
        case dataNotFound
        case decodingDidNotWork
    }
    
    func decode() -> Result<Model, Error> {
        
        guard let url = Bundle.main.url(forResource: "JSONCountries", withExtension: "json") else {
            return .failure(DecodingError.urlNotFound)
        }
        
        guard let data = try? Data(contentsOf: url) else {
            return .failure(DecodingError.dataNotFound)
        }
        
        guard let jsonDecoded = try? JSONDecoder().decode(Model.self, from: data) else {
            return .failure(DecodingError.decodingDidNotWork)
        }
        
        return .success(jsonDecoded)
    }
}
