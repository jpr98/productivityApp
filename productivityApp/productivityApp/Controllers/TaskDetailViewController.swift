//
//  TaskDetailViewController.swift
//  productivityApp
//
//  Created by Juan Pablo Ramos on 21/11/19.
//  Copyright © 2019 Juan Pablo Ramos. All rights reserved.
//

import UIKit

class TaskDetailViewController: UIViewController {
	
	static func makeTaskDetailViewController() -> TaskDetailViewController {
		return UIStoryboard(name: "TaskDetail", bundle: nil).instantiateViewController(withIdentifier: String(describing: TaskDetailViewController.self)) as! TaskDetailViewController
	}
}

extension UIViewController {
	func showTaskDetailViewController() {
		let vc = TaskDetailViewController.makeTaskDetailViewController()
		present(vc, animated: true, completion: nil)
	}
}
