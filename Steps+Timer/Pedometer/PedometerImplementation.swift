//
//  PedometerImplementation.swift
//  Steps+Timer
//
//  Created by Carmen Salvador on 17/09/20.
//  Copyright © 2020 Carmen Salvador. All rights reserved.
//

import Foundation
import CoreMotion

class PedometerImplementation: PedometerReporting {
    
    lazy private var pedometer = CMPedometer()
    lazy private var activityManager = CMMotionActivityManager()
    
    enum PedometerError: Error {
        case stepsCounterNotAvailable
        case activityUpdatesNotAvailable
        case distanceMeasureNotAvailable
        case unableToGetSteps
        case unableToGetDistance
    }
    
    func getStepsForLastSixMinutes(handler: @escaping (Result<Int, Error>) -> Void) {
        guard CMPedometer.isStepCountingAvailable() else {
            handler(.failure(PedometerError.stepsCounterNotAvailable))
            return
        }
        
        pedometer.queryPedometerData(from: Date(timeIntervalSinceNow: -180), to: Date()) { (pedometerData, error) in
            guard let steps = pedometerData?.numberOfSteps as? Int else {
                handler(.failure(PedometerError.unableToGetSteps))
                return
            }
            handler(.success(steps))
        }
    }
    
    func getDistanceForLastSixMinutes(handler: @escaping (Result<Int, Error>) -> Void) {
        guard CMPedometer.isDistanceAvailable() else {
            handler(.failure(PedometerError.distanceMeasureNotAvailable))
            return
        }
        pedometer.queryPedometerData(from: Date(timeIntervalSinceNow: -180), to: Date()) { (pedometerData, error) in
            guard let distance = pedometerData?.distance as? Int else {
                handler(.failure(PedometerError.unableToGetDistance))
                return
            }
            handler(.success(distance))
        }
    }
    
    func getStationaryUpdates() {
        // TODO - implement activity updater
    }
    
}
