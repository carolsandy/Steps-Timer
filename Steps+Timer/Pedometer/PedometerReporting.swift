//
//  PedometerReporting.swift
//  Steps+Timer
//
//  Created by Carmen Salvador on 17/09/20.
//  Copyright © 2020 Carmen Salvador. All rights reserved.
//

protocol PedometerReporting {
    func getStepsForLastSixMinutes(handler: @escaping (Result<Int, Error>) -> Void)
    func getDistanceForLastSixMinutes(handler: @escaping (Result<Int, Error>) -> Void)
    func getStationaryUpdates()
}
