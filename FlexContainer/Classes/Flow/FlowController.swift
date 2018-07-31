//
//  FlexibleContainerView.swift
//  FlowController
//
//  Created by kernel on 12/23/16.
//  Copyright © 2016 ReImpl. All rights reserved.
//

import UIKit

public protocol FlowController {
	
	var flow: Flow { get }
	
}

public extension UIApplication {
	
	@inlinable public
	func presentWindow(with flow: Flow, windowLevel: UIWindow.Level = .normal, windowRect: CGRect = UIScreen.main.bounds) {
		let hasExistingWindow: Bool
		let existingWindow: UIWindow
		
		if let window = delegate?.window as? UIWindow {
			existingWindow = window
			hasExistingWindow = true
		} else {
			existingWindow = UIWindow(frame: windowRect)
			hasExistingWindow = false
		}
		existingWindow.windowLevel = windowLevel
		
		let storyboard = UIStoryboard.load(flow.initialStoryboard)
		let ctrl = storyboard.instantiateInitialViewController()!
		
		ctrl.setFlowValue(flow)
		
		existingWindow.rootViewController = ctrl
		
		if !hasExistingWindow {
			existingWindow.makeKeyAndVisible()
		}
	}
	
}

extension UIStoryboard {
	
	@usableFromInline static
		func load(_ storyboard: Storyboard) -> UIStoryboard {
		return UIStoryboard(name: storyboard.name, bundle: nil)
	}
	
}


extension UIViewController: FlowController {
	
	@inlinable public
	var flow: Flow {
		let flow: Flow
		
		if let thisFlow = getFlowValue() {
			flow = thisFlow
		} else {
			flow = parent!.flow
		}
		
		return flow
	}
	
}

// MARK: - Internal

fileprivate var flowKey = "flow"

extension UIViewController {
	
	// MARK: - 'flow'
	
	@usableFromInline
	func getFlowValue() -> Flow? {
		return objc_getAssociatedObject(self, &flowKey) as? Flow
	}
	
	@usableFromInline
	func setFlowValue(_ flow: Flow) {
		objc_setAssociatedObject(self, &flowKey, flow, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
	}
	
}
