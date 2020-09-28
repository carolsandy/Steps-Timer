//
//  ViewController.swift
//  Steps+Timer
//
//  Created by Carmen Salvador on 17/09/20.
//  Copyright © 2020 Carmen Salvador. All rights reserved.
//

import UIKit

class ViewController: UIViewController, StepsTimerView {

    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var stepsLabel: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var activitylabel: UILabel!
    @IBOutlet weak var startButton: UIButton!
    
    lazy var sixMinTimer = SixMinTimer()
    lazy var pedometer = PedometerImplementation()
    lazy var presenter = StepsTimerPresenter(view: self, sixMinTimer: sixMinTimer, pedometer: pedometer)
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func startWalking(_ sender: Any) {
        presenter.startTest()
        startButton.isEnabled = false
    }
    
    func updateTimer(time: String) {
        timeLabel.text = time
    }
    
    func updateActivity(activity: String) {
        //  TODO - update activityLabel
    }
    
    func finishTest(steps: String) {
        DispatchQueue.main.async {
            self.stepsLabel.text = steps
        }
    }
    
    func finishTest(distance: String) {
        DispatchQueue.main.async {
            self.distanceLabel.text = distance
        }
    }
}

