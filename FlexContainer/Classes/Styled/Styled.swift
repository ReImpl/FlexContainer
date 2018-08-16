//
//  UIViewAdditions.swift
//  Styled
//
//  Created by kernel on 12/29/17.
//  Copyright © 2016 ReImpl. All rights reserved.
//

import UIKit
import Layoutless

/**
	This describes a Container of styles defined on top of DeclarativeHub/Layoutless::Style.

	How to create style cotnainers:

	Create single 'AppStyle' protocol that extends StyleContainer.

	In 'AppStyle' define {get}-only variables of Style<UIView-or-Subclass> type.
	Than implement your own style(s) (using classes or structs) that realize AppStyle protocol.

	In this way you declare a contract for all styles that the app uses once in 'AppStyle'.
	And then provide various implementations. Two hypothetical examples are LightStyle and DarkStyle

	For instance, you may define:

	protocol AppStyle: StyleContainer {
		var background: Style<UIView> { get }
		var linkButton: Style<UIButton> { get }
	}

	struct LightStyle: AppStyle {
		let background = Style<UIView> {
			$0.backgroundColor = .white
		}

		let linkButton = Style<UIButton> {
			$0.titleLabel?.font = .preferredFont(forTextStyle: .headline)

			$0.setTitleColor(.orange, for: .normal)
			$0.setTitleColor(.black, for: .highlighted)

			$0.setBackgroundColor(.clear, for: .normal)
			$0.setBackgroundColor(.clear, for: .highlighted)
		}
	}

	struct DarkStyle: AppStyle {
		let background = Style<UIView> {
			$0.backgroundColor = .darkGray
		}

		let linkButton = Style<UIButton> {
			$0.titleLabel?.font = .preferredFont(forTextStyle: .headline)

			$0.setTitleColor(.white, for: .normal)
			$0.setTitleColor(.red, for: .highlighted)

			$0.setBackgroundColor(.clear, for: .normal)
			$0.setBackgroundColor(.clear, for: .highlighted)
		}
	}
*/

public protocol StyleContainer {
	
}

public extension UIApplication {
	
	var currentStyleContainer: StyleContainer? {
		get {
			return appStyleContainer
		}
		set {
			appStyleContainer = newValue
		}
	}
	
}

fileprivate var appStyleContainer: StyleContainer?

public extension UIView {
	
	@IBInspectable
	public var style: String? {
		get {
			return nil
		}
		set {
			guard let styleName = newValue,
				let style = findStyle(named: styleName) else {
					assertionFailure("nil style. Styling skipped.")
					
					return
			}
			
			covariantGenericApply(style)
		}
	}
	
	private func findStyle(named name: String) -> Any? {
		guard let allStyles = UIApplication.shared.currentStyleContainer else {
			assertionFailure()
			
			return nil
		}
		
		let mirror = Mirror(reflecting: allStyles)
		
		guard let first = mirror.children.first(where: { $0.label == name }) else {
			assertionFailure("No style named '\(name)' found.")
			
			return nil
		}
		
		return first.value
	}
	
	func covariantGenericApply(_ style: Any) {
		switch (style, self) {
		case (let s as Style<UILabel>, let view as UILabel):
			s.apply(to: view)
		case (let s as Style<UIButton>, let view as UIButton):
			s.apply(to: view)
		case (let s as Style<UIImageView>, let view as UIImageView):
			s.apply(to: view)
		
		case (let s as Style<UITextField>, let view as UITextField):
			s.apply(to: view)
		case (let s as Style<UITextView>, let view as UITextView):
			s.apply(to: view)
			
		case (let s as Style<UIPickerView>, let view as UIPickerView):
			s.apply(to: view)
		case (let s as Style<UIDatePicker>, let view as UIDatePicker):
			s.apply(to: view)
		
		case (let s as Style<UIStackView>, let view as UIStackView):
			s.apply(to: view)
			
		case (let s as Style<UIStepper>, let view as UIStepper):
			s.apply(to: view)
		case (let s as Style<UISegmentedControl>, let view as UISegmentedControl):
			s.apply(to: view)
		case (let s as Style<UISwitch>, let view as UISwitch):
			s.apply(to: view)
		case (let s as Style<UISlider>, let view as UISlider):
			s.apply(to: view)
			
		case (let s as Style<UIPageControl>, let view as UIPageControl):
			s.apply(to: view)
		case (let s as Style<UIProgressView>, let view as UIProgressView):
			s.apply(to: view)
		case (let s as Style<UIActivityIndicatorView>, let view as UIActivityIndicatorView):
			s.apply(to: view)
			
		case (let s as Style<UIScrollView>, let view as UIScrollView):
			s.apply(to: view)
		
		case (let s as Style<UITableView>, let view as UITableView):
			s.apply(to: view)
		case (let s as Style<UITableViewCell>, let view as UITableViewCell):
			s.apply(to: view)
			
		case (let s as Style<UICollectionView>, let view as UICollectionView):
			s.apply(to: view)
		case (let s as Style<UICollectionReusableView>, let view as UICollectionReusableView):
			s.apply(to: view)
			
		case (let s as Style<UINavigationBar>, let view as UINavigationBar):
			s.apply(to: view)
			
		case (let s as Style<UIView>, _):
			s.apply(to: self)
		default:
			assertionFailure("Unhandled style: \(style) for view: \(self)")
		}
	}
	
}

