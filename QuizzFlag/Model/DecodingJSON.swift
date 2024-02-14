
import Foundation

final class DecodingJSON {
    
    enum DecodingError: Error {
        case dataNotFound
        case decodingDidNotWork
    }
    
    func decode() -> Result<Model, Error> {
        
        guard let data = JSONCountries.data(using: .utf8) else {
            print("data failed")
            return .failure(DecodingError.dataNotFound)
        }
        
        guard let jsonDecoded = try? JSONDecoder().decode(Model.self, from: data) else {
            print("decode failed")
            return .failure(DecodingError.decodingDidNotWork)
        }
        return .success(jsonDecoded)
    }
}
