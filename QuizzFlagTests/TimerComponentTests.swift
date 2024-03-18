import Foundation
import XCTest
@testable import QuizzFlag

final class TimerComponentTests: XCTestCase {
    
    let sut = TimerComponent()

    func test_timerIsTriggered() {
        
        let exp = XCTestExpectation(description: "Timer is triggered")
        
        sut.timer {
            exp.fulfill()
        }
        
        wait(for: [exp], timeout: 0.5)
    }

    func test_stoppingTheTimer() {
        
        let exp = XCTestExpectation(description: "Timer will be stopped")
        
        sut.timer {
            XCTFail("It should not trigger")
        }
        sut.stopTheTimer()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            exp.fulfill()
        }
        
        wait(for: [exp], timeout: 0.5)
    }
}
