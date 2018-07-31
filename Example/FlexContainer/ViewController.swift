//
//  ViewController.swift
//  FlexContainer
//
//  Created by genkernel on 07/15/2018.
//  Copyright (c) 2018 genkernel. All rights reserved.
//

import UIKit
import FlexContainer

class ViewController: UIViewController {

	override func viewDidLoad() {
		super.viewDidLoad()
	}
	
	// MARK: - Actions

	@IBAction func toggleStyleClicked(_ sender: UIButton) {
		let app = UIApplication.shared.delegate as! AppDelegate
		
		app.toggleCurrentStyle()
	}
	
}

