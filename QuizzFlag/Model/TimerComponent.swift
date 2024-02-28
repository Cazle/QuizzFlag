import Foundation

final class TimerComponent {
    
    private var timer: Timer?
    
    func timer(completion: @escaping () -> Void) {
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) {timer in
            completion()
        }
    }
    
    func stopTheTimer() {
        timer?.invalidate()
    }
}
