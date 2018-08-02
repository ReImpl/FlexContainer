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

#if swift(>=4.2)
public typealias WindowLevel = UIWindow.Level
public var normalWindowLevel: WindowLevel {
	return .normal
}
#else
public typealias WindowLevel = UIWindowLevel
public var normalWindowLevel: WindowLevel {
	return UIWindowLevelNormal
}
#endif

public extension UIApplication {
	
//	#if swift(>=4.2)
//	@inlinable
//	#endif
//	public func presentWindow(with flow: Flow, windowLevel: WindowLevel = normalWindowLevel, windowRect: CGRect = UIScreen.main.bounds) {
	public func presentWindow(with flow: Flow, windowRect: CGRect = UIScreen.main.bounds) {
	
		let hasExistingWindow: Bool
		let existingWindow: UIWindow
		
		if let window = delegate?.window as? UIWindow {
			existingWindow = window
			hasExistingWindow = true
		} else {
			existingWindow = UIWindow(frame: windowRect)
			hasExistingWindow = false
		}
//		existingWindow.windowLevel = windowLevel
		
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
	
//	#if swift(>=4.2)
//	@usableFromInline
//	#endif
	static func load(_ storyboard: Storyboard) -> UIStoryboard {
		return UIStoryboard(name: storyboard.name, bundle: nil)
	}
	
}


extension UIViewController: FlowController {
	
//	#if swift(>=4.2)
//	@inlinable
//	#endif
	public var flow: Flow {
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
	
//	#if swift(>=4.2)
//	@usableFromInline
//	#endif
	func getFlowValue() -> Flow? {
		return objc_getAssociatedObject(self, &flowKey) as? Flow
	}
	
//	#if swift(>=4.2)
//	@usableFromInline
//	#endif
	func setFlowValue(_ flow: Flow) {
		objc_setAssociatedObject(self, &flowKey, flow, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
	}
	
}
