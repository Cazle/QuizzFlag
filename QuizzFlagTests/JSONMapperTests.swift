import Foundation
@testable import QuizzFlag
import XCTest

final class JSONMapperTests: XCTestCase {
    
    let sut = JSONMapper()
    
    func test_whenTheJSONIsEmptyAndThrowAUrlNotFoundError() {
        
        sut.jsonData = "noData"
        
        switch sut.decode() {
        case .success(let success):
            XCTFail("This should not happen \(success)")
        case .failure(let error):
            XCTAssertEqual(error as! JSONMapper.DecodingError, .urlNotFound)
        }
    }
    
    func test_whenTheDecodingIsNotSuccessfulAndReturnADecodingErrorDecodingDidNotWork() {
        sut.jsonData = "ErrorJSON"
        
        switch sut.decode() {
        case .success(let success):
            XCTFail("This should not happen \(success)")
        case .failure(let error):
            XCTAssertEqual(error as! JSONMapper.DecodingError, .decodingDidNotWork)
        }
    }
    
    func test_whenTheDecodingIsSuccessfullAndReturnTheCountry() {
        sut.jsonData = "FakeJSON"
        
        switch sut.decode() {
        case .success(let success):
            let europe = success.europe
            XCTAssertEqual(europe[0].name, "Albanie")
            XCTAssertEqual(europe[0].capital, "Tirana")
            XCTAssertEqual(europe[0].history, "https://fr.wikipedia.org/wiki/Albanie#Histoire")
            XCTAssertEqual(europe[0].coatOfArms, "COA_Albanie.png")
            XCTAssertEqual(europe[0].flag, "Albanie.png")
            XCTAssertEqual(europe[0].continent, "Europe")
        case .failure(let error):
            XCTFail("This should not happen \(error)")
        }
    }
}
