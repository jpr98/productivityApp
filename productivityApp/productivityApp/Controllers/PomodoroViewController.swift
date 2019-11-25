//
//  PomodoroViewController.swift
//  productivityApp
//
//  Created by Juan Pablo Ramos on 25/11/19.
//  Copyright © 2019 Juan Pablo Ramos. All rights reserved.
//

import UIKit
import SRCountdownTimer

class PomodoroViewController: UIViewController {
	
	static func makePomodoroViewController() -> PomodoroViewController {
		return UIStoryboard(name: "Pomodoro", bundle: nil).instantiateViewController(identifier: String(describing: PomodoroViewController.self)) as! PomodoroViewController
	}
	
	@IBOutlet weak var timerView: SRCountdownTimer!
	@IBOutlet weak var button: UIButton!
	
	private var workTime = true
	
	override func viewDidLoad() {
		
		super.viewDidLoad()
		
		configureWorkTimer()

	}
	
	func configureWorkTimer() {
		
		timerView.lineWidth = 3.0
		timerView.lineColor = .black
		timerView.trailLineColor = UIColor.lightGray.withAlphaComponent(0.5)
		timerView.isLabelHidden = false
		timerView.timerFinishingText = "Done. Tap to start break."
		timerView.useMinutesAndSecondsRepresentation = true
		timerView.delegate = self
		
		timerView.start(beginingValue: 10, interval: 1)
		
	}
	
	func configureBreakTimer() {
		
		timerView.lineWidth = 3.0
		timerView.lineColor = .black
		timerView.trailLineColor = UIColor.lightGray.withAlphaComponent(0.5)
		timerView.isLabelHidden = false
		timerView.timerFinishingText = "Done. Tap to start work."
		timerView.useMinutesAndSecondsRepresentation = true
		timerView.delegate = self
		
		timerView.start(beginingValue: 5, interval: 1)
		
	}
	
	@IBAction func buttonTapped(_ sender: Any) {
		if workTime {
			configureBreakTimer()
		} else {
			configureWorkTimer()
		}
	}
	
}
// MARK: - SRCountdownTimer
extension PomodoroViewController: SRCountdownTimerDelegate {
	
	func timerDidEnd() {
		workTime.toggle()
	}
	
}

// MARK: - Show VC Extension
extension UIViewController {
	
	func showPomodoroViewController() {
		let vc = PomodoroViewController.makePomodoroViewController()
		vc.modalPresentationStyle = .overFullScreen
		present(vc, animated: true, completion: nil)
	}
	
}
