
import Foundation

class StepsTimerPresenter {
    weak var view: StepsTimerView!
    var sixMinTimer: SixMinTimer
    var pedometer: PedometerReporting
    
    init(view: StepsTimerView, sixMinTimer: SixMinTimer, pedometer: PedometerReporting) {
        self.view = view
        self.sixMinTimer = sixMinTimer
        self.pedometer = pedometer
    }
    
    func startTest() {
        sixMinTimer.startTimer { [weak self] minutes, seconds, isTestFinished in
            self?.updateTime(minutes: minutes, seconds: seconds, isTestFinished: isTestFinished)
        }
    }
    
    private func updateTime(minutes:Int, seconds: Int, isTestFinished: Bool) {
        view?.updateTimer(time: makeTimePretty(minutes: minutes, seconds: seconds))
        if isTestFinished {
            pedometer.getStepsForLastSixMinutes { result in
                switch result {
                case .success(let steps):
                    self.view?.finishTest(steps: "Steps: \(steps)")
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
            
            pedometer.getDistanceForLastSixMinutes { result in
                switch result {
                case .success(let distance):
                    self.view?.finishTest(distance: "Distance: \(distance)")
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    private func makeTimePretty(minutes: Int, seconds: Int) -> String {
        var time = "0\(minutes):"
        time = seconds < 10 ? "\(time)0\(seconds)" : "\(time)\(seconds)"
        return time
    }
    
}

protocol StepsTimerView: class {
    func updateTimer(time: String)
    func updateActivity(activity: String)
    func finishTest(steps: String)
    func finishTest(distance: String)
}
