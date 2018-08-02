//
//  FlexibleContainerView.swift
//
//  Created by kernel on 12/23/16.
//  Copyright © 2016 ReImpl. All rights reserved.
//

import UIKit

// MARK: - oversimplified UIStackView with dynamic constraints.

///
/// For removeSubview operation to work properly - set 'subviewsBottomConstraints' constraints for all subviews.
///
open class VerticalContainerView: FlexibleContainerView {
	
	@IBOutlet public var subviewsBottomConstraints: [NSLayoutConstraint] {
		get {
			return subviewsConstraints
		}
		set {
			subviewsConstraints = newValue
		}
	}
	
	override public var flexibleRule: FlexibleContainerView.FlexibleRule {
		return .vertical
	}
	
}

///
/// For removeSubview operation to work properly - set 'subviewsRightConstraints' constraints for all subviews.
///
open class HorizontalContainerView: FlexibleContainerView {
	
	@IBOutlet public var subviewsRightConstraints: [NSLayoutConstraint] {
		get {
			return subviewsConstraints
		}
		set {
			subviewsConstraints = newValue
		}
	}
	
	override public var flexibleRule: FlexibleContainerView.FlexibleRule {
		return .horizontal
	}
	
}

open class FlexibleContainerView: UIView {
	
	public enum FlexibleRule {
		case horizontal
		case vertical
	}
	
	public var flexibleRule: FlexibleRule? {
		return nil
	}
	
	@IBInspectable public var offsetMargin: CGFloat = 0
	
	override open func addSubview(_ view: UIView) {
		guard let _ = flexibleRule else {
			super.addSubview(view)
			
			return
		}
		
		let lastView = subviews.last
		super.addSubview(view)
		
		if view.translatesAutoresizingMaskIntoConstraints {
			view.translatesAutoresizingMaskIntoConstraints = false
			
			constraintSubview(view, after: lastView)
		}
	}
	
	override open func willRemoveSubview(_ subview: UIView) {
		defer {
			super.willRemoveSubview(subview)
			
			subview.translatesAutoresizingMaskIntoConstraints = true
		}
		
		guard let rule = flexibleRule else {
			return
		}
		
		if subviewsConstraints.count == subviews.count {
			let index = subviews.index(of: subview)!
			
			removeConstraint(subviewsConstraints[index])
			
			switch index {
			case 0:
				if subviews.count > 1 {
					let constraint: NSLayoutConstraint
					let (top, _, _, left) = subviews[1].constraintsToPinToSuperview()
					
					switch rule {
					case .horizontal:
						constraint = left
					case .vertical:
						constraint = top
					}
					
					addConstraint(constraint)
					subviewsConstraints[index + 1] = constraint
				}
			case subviewsConstraints.count - 1:
				if subviews.count > 1 {
					let index = subviewsConstraints.count - 2
					
					let constraint: NSLayoutConstraint
					let (_, right, bottom, _) = subviews[index].constraintsToPinToSuperview()
					
					switch rule {
					case .horizontal:
						constraint = right
					case .vertical:
						constraint = bottom
					}
					
					addConstraint(constraint)
					subviewsConstraints[index] = constraint
				}
			default:
				let leftOrTopView = subviews[index - 1]
				let rightOrBottomView = subviews[index + 1]
				
				let constraint: NSLayoutConstraint
				
				switch rule {
				case .horizontal:
					constraint = NSLayoutConstraint(item: leftOrTopView, attribute: .right, relatedBy: .equal, toItem: rightOrBottomView, attribute: .left, multiplier: 1, constant: -offsetMargin)
					
				case .vertical:
					constraint = NSLayoutConstraint(item: leftOrTopView, attribute: .bottom, relatedBy: .equal, toItem: rightOrBottomView, attribute: .top, multiplier: 1, constant: -offsetMargin)
				}
				
				addConstraint(constraint)
				subviewsConstraints[index - 1] = constraint
			}
			
			subviewsConstraints.remove(at: index)
			
			setNeedsUpdateConstraints()
		} else {
			if subviewsConstraints.count > 0 {
//				assertionFailure()
				
				print("ERR. subviewsConstrains.count != subviews.count. Every subview.edgeConstraint should be in subviewsConstrains")
			}
		}
	}
	
	@IBOutlet fileprivate var subviewsConstraints = [NSLayoutConstraint]()
	fileprivate var lastViewEdgeConstraint: NSLayoutConstraint? {
		return subviewsConstraints.last
	}
	
	fileprivate func constraintSubview(_ view: UIView, after siblingView: UIView?) {
		guard let rule = flexibleRule else {
			return
		}
		
		if let constraintToBrake = self.lastViewEdgeConstraint {
			removeConstraint(constraintToBrake)
		}
		
		let (top, right, bottom, left): (NSLayoutConstraint, NSLayoutConstraint, NSLayoutConstraint, NSLayoutConstraint)
		if view.preservesSuperviewLayoutMargins {
			(top, right, bottom, left) = view.constraintsToPinToSuperviewMargins()
		} else {
			(top, right, bottom, left) = view.constraintsToPinToSuperview()
		}
		
		switch rule {
		case .horizontal:
			let viewToPinTo: UIView
			let offset: CGFloat
			
			#if swift(>=4.2)
			let margin: NSLayoutConstraint.Attribute
			#else
			let margin: NSLayoutAttribute
			#endif
			
			if let lastSubview = siblingView {
				viewToPinTo = lastSubview
				margin = .right
				
				offset = -1 * (view.preservesSuperviewLayoutMargins ? left.constant : offsetMargin)
			} else {
				viewToPinTo = self
				margin = .left
				
				offset = view.preservesSuperviewLayoutMargins ? -left.constant : 0
			}
			
			let constraint = NSLayoutConstraint(item: viewToPinTo, attribute: margin, relatedBy: .equal, toItem: view, attribute: .left, multiplier: 1, constant: offset)
			
			addConstraints([top, right, bottom, constraint])
			
			if let previousSubview = siblingView, let index = subviews.index(of: previousSubview) {
				subviewsConstraints[index] = constraint
			}
			subviewsConstraints.append(right)
			
		case .vertical:
			let offset: CGFloat
			let viewToPinTo: UIView
			
			#if swift(>=4.2)
			let margin: NSLayoutConstraint.Attribute
			#else
			let margin: NSLayoutAttribute
			#endif
			
			if let lastSubview = siblingView {
				viewToPinTo = lastSubview
				margin = .bottom
				
				offset = -1 * (view.preservesSuperviewLayoutMargins ? top.constant : offsetMargin)
			} else {
				viewToPinTo = self
				margin = .top
				
				offset = view.preservesSuperviewLayoutMargins ? -top.constant : 0
			}
			
			let constraint = NSLayoutConstraint(item: viewToPinTo, attribute: margin, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1, constant: offset)
			
			addConstraints([constraint, right, bottom, left])
			
			if let previousSubview = siblingView, let index = subviews.index(of: previousSubview) {
				subviewsConstraints[index] = constraint
			}
			subviewsConstraints.append(bottom)
		}
	}
	
}
