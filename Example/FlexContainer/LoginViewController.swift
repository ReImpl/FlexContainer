//
//  LoginViewController.swift
//  Example
//
//  Created by Anthony on 8/13/18.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import UIKit
import FlexContainer

final class LoginViewController: UIViewController {
	
	deinit {
		print("\(className) dealloced")
	}
	
	@IBAction
	private func loginClicked(_ sender: UIButton) {
		#if swift(>=4.2)
		let overlayLevel = WindowLevel(rawValue: UIWindow.Level.alert.rawValue - 1)
		#else
		let overlayLevel = UIWindowLevelAlert - 1
		#endif
		
		let loadingWindow = UIApplication.shared.presentWindow(with: OverlayFlow(), level: overlayLevel, mode: .new)
		
		onMainQueue(afterDelay: 4) {
			UIApplication.shared.presentWindow(with: MainFlow())
			
			onMainQueue(afterDelay: 2.5) {
				loadingWindow.isHidden = true
			}
			
		}
	}
	
}
