//
//  ViewController.swift
//  FlexContainer
//
//  Created by genkernel on 07/15/2018.
//  Copyright (c) 2018 genkernel. All rights reserved.
//

import UIKit
import FlexContainer

class MainViewController: UIViewController {
	
	deinit {
		print("\(className) dealloced")
	}

	override func viewDidLoad() {
		super.viewDidLoad()
		
		navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Logout", style: .done, target: self, action: #selector(logoutPressed))
	}
	
	// MARK: - Actions

	@IBAction
	func toggleStyleClicked(_ sender: UIButton) {
		let app = UIApplication.shared.delegate as! AppDelegate
		
		app.toggleCurrentStyle()
	}
	
	@objc
	func logoutPressed() {
		UIApplication.shared.presentWindow(with: LoginFlow())
	}
	
}

