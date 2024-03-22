import Foundation

final class TimerComponent {
    
    private var timer: Timer?
    
    // Method to launch the timer
    func timer(completion: @escaping () -> Void) {
        timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) {timer in
            completion()
        }
    }
    
    //Stopping the timer
    func stopTheTimer() {
        timer?.invalidate()
    }
}
