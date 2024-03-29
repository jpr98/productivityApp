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
	
	@IBOutlet weak var titleLabel: UILabel!
	@IBOutlet weak var detailLabel: UILabel!
	@IBOutlet weak var infoLabel: UILabel!
	@IBOutlet weak var timerView: SRCountdownTimer!
	@IBOutlet weak var button: UIButton!
	@IBOutlet weak var saveButton: UIButton!
	@IBOutlet weak var doneButton: UIButton!
	
	var task = Task()
	private var workTime = true
	private var canTap = false
	private var paused = false
	private var counterValue = 0 // in seconds
	
	private var time = 1500
	
	override func viewDidLoad() {
		
		super.viewDidLoad()
		
		configureWorkTimer()
		configureLabels()
		configureButtons()
		
	}
	
	func configureWorkTimer() {
		
		let minutes = task.timeToComplete / 60
		if minutes < 25 {
			time = Int(minutes * 60)
		}
		
		timerView.lineWidth = 3.0
		timerView.lineColor = .black
		timerView.trailLineColor = UIColor.lightGray.withAlphaComponent(0.5)
		timerView.isLabelHidden = false
		timerView.timerFinishingText = "Done. Tap to start break."
		timerView.labelFont = UIFont.getFont(with: .medium, size: 20)
		timerView.useMinutesAndSecondsRepresentation = true
		timerView.delegate = self
		
		timerView.start(beginingValue: time, interval: 1)
		
	}
	
	func configureBreakTimer() {
		
		timerView.lineWidth = 3.0
		timerView.lineColor = .black
		timerView.trailLineColor = UIColor.lightGray.withAlphaComponent(0.5)
		timerView.isLabelHidden = false
		timerView.timerFinishingText = "Done. Tap to start work."
		timerView.labelFont = UIFont.getFont(with: .medium, size: 30)
		timerView.useMinutesAndSecondsRepresentation = true
		timerView.delegate = self
		
		timerView.start(beginingValue: 300, interval: 1)
		
	}
	
	func configureLabels() {
		
		titleLabel.text = "Working on \(task.title)"
		titleLabel.font = UIFont.getFont(with: .medium, size: 30)
		
		let cycles = Int(task.timeToComplete / 1500)
		if cycles <= 0 {
			detailLabel.text = "You have to do less than 1 cycle to complete this task"
		} else if cycles == 1 {
			detailLabel.text = "You have to do about 1 cycle to complete this task"
		} else {
			detailLabel.text = "You still have to do about \(cycles) cycles to complete this task"
		}
		detailLabel.font = UIFont.getFont(with: .light, size: 16)
		
		infoLabel.font = UIFont.getFont(with: .book, size: 13)
		
	}
	
	func configureButtons() {
		
		saveButton.layer.cornerRadius = 10
		saveButton.layer.backgroundColor = UIColor.color(for: .save)?.cgColor
		saveButton.setTitleColor(.white, for: .normal)
		
		doneButton.layer.cornerRadius = 10
		doneButton.layer.backgroundColor = UIColor.color(for: .complete)?.cgColor
		doneButton.setTitleColor(.white, for: .normal)
		
	}
	
	// MARK: - IBActions
	@IBAction func buttonTapped(_ sender: Any) {
		
		if canTap {
			
			if workTime {
				configureBreakTimer()
			} else {
				configureWorkTimer()
			}
			
		} else {
			
			if paused {
				timerView.resume()
			} else {
				timerView.pause()
			}
			
		}
		
	}
	
	@IBAction func saveButtonTapped(_ sender: Any) {
		task.timeToComplete -= TimeInterval(time - counterValue)
		RealmHandler.shared.save(task)
		self.dismiss(animated: true, completion: nil)
	}
	
	@IBAction func doneButtonTapped(_ sender: Any) {
		
		if task.timeToComplete != 0 {
			let alertVC = UIAlertController(title: "Wait", message: "It looks like you are still missing \(task.timeToComplete.getHoursMinutes()) to complete this task. Do you wish to mark it as completed anyways?", preferredStyle: .alert)
			
			let okAction = UIAlertAction(title: "Complete task", style: .default) { _ in
				self.task.completed = true
				RealmHandler.shared.save(self.task)
				self.dismiss(animated: true, completion: nil)
			}
			
			let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
			
			alertVC.addAction(okAction)
			alertVC.addAction(cancelAction)
			
			present(alertVC, animated: true, completion: nil)
		}
		
	}
	
}
// MARK: - SRCountdownTimer
extension PomodoroViewController: SRCountdownTimerDelegate {
	
	func timerDidStart() {
		canTap = false
	}
	
	func timerDidPause() {
		paused = true
	}
	
	func timerDidResume() {
		paused = false
	}
	
	func timerDidEnd() {
		
		canTap = true
		workTime.toggle()
		
		task.timeToComplete -= TimeInterval(time)
		
		configureLabels()
		
	}
	
	func timerDidUpdateCounterValue(newValue: Int) {
		counterValue = newValue
	}
	
}

// MARK: - Show VC Extension
extension UIViewController {
	
	func showPomodoroViewController(task: Task) {
		let vc = PomodoroViewController.makePomodoroViewController()
		
		vc.modalPresentationStyle = .overFullScreen
		vc.task = task
		
		present(vc, animated: true, completion: nil)
	}
	
}
