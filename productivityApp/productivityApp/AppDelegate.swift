//
//  AppDelegate.swift
//  productivityApp
//
//  Created by Juan Pablo Ramos on 19/11/19.
//  Copyright © 2019 Juan Pablo Ramos. All rights reserved.
//

import UIKit
import UserNotifications

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

	let notificationCenter = UNUserNotificationCenter.current()

	func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
		// Override point for customization after application launch.
		let options: UNAuthorizationOptions = [.alert, .sound, .badge]
		
		notificationCenter.requestAuthorization(options: options) {
			(didAllow, error) in
			if !didAllow {
				print("User has declined notifications")
			}
		}
		
		return true
	}
	
	func scheduleNotification(for task: Task) {
		
		let content = UNMutableNotificationContent()
		
		content.title = task.title
		content.body = "Hey! Don't forget your to-do: \(task.title)"
		content.sound = UNNotificationSound.default
		content.badge = 1
		
		let date = task.dueDate
		let triggerDate = Calendar.current.dateComponents([.year,.month,.day,.hour,.minute,.second,], from: date)
		let trigger = UNCalendarNotificationTrigger(dateMatching: triggerDate, repeats: false)
		
		let identifier = "Local Notification"
		let request = UNNotificationRequest(identifier: identifier, content: content, trigger: trigger)

		notificationCenter.add(request) { (error) in
			if let error = error {
				print("Error \(error.localizedDescription)")
			}
		}
	}
	
	// MARK: UISceneSession Lifecycle

	func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
		// Called when a new scene session is being created.
		// Use this method to select a configuration to create the new scene with.
		return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
	}

	func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
		// Called when the user discards a scene session.
		// If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
		// Use this method to release any resources that were specific to the discarded scenes, as they will not return.
	}


}

