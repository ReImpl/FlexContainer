//
//  FlexController.swift
//  FlexContainer
//
//  Created by Anthony on 10/3/18.
//

import UIKit

open class FlexController: UIViewController {
	
	public let contentView: UIView = {
		let v = UIView()
		
		v.translatesAutoresizingMaskIntoConstraints = false
		
		return v
	}()
	
	open override func viewDidLoad() {
		super.viewDidLoad()
		
		view.addSubview(scrollView)
		scrollView.pinToSuperviewEdges()
		
		setupGuides()
		setupContentView()
	}
	
	// MARK: - Internal (contentView)
	
	private func setupContentView() {
		scrollView.addSubview(contentView)
		let edges = contentView.constraintsToPinToSuperviewEdges()

		scrollView.addConstraints([
			edges.left, edges.right,

			NSLayoutConstraint(
				item: contentView, attribute: .top,
				relatedBy: .equal,
				toItem: innerHeaderGuide, attribute: .bottom,
				multiplier: 1, constant: 0
			),
			NSLayoutConstraint(
				item: contentView, attribute: .bottom,
				relatedBy: .equal,
				toItem: innerFooterGuide, attribute: .top,
				multiplier: 1, constant: 0
			)]
		)
	}
	
	// MARK: - Internal (Guide views)
	
	private let scrollView: UIScrollView = {
		let v = UIScrollView()
		
		v.translatesAutoresizingMaskIntoConstraints = false
		
		return v
	}()
	//
	private let innerHeaderGuide: UIView = {
		let v = UIView()
//		v.colorizeBorder(with: .red)
		v.isHidden = true
		v.translatesAutoresizingMaskIntoConstraints = false
		
		return v
	}()
	private let innerFooterGuide: UIView = {
		let v = UIView()
		
		v.isHidden = true
		v.translatesAutoresizingMaskIntoConstraints = false
		
		return v
	}()
	
	private func setupGuides() {
		setupGuideView(position: .top)
		setupGuideView(position: .bottom)
	}
	
	private enum GuidePosition {
		case top
		case bottom
	}
	
	private func setupGuideView(position: GuidePosition) {
		let line = setupLineView(position: position)
		
		let guide = UIView()
		
		guide.isHidden = true
		guide.translatesAutoresizingMaskIntoConstraints = false
		
		view.addSubview(guide)
		let edges = guide.constraintsToPinToSuperviewEdges()
		
		let guidePin: NSLayoutConstraint.Attribute
		let linePin: NSLayoutConstraint.Attribute
		
		switch position {
		case .top:
			guidePin = .bottom
			linePin = .top
			
			view.addConstraints([edges.top, edges.left, edges.right])
		case .bottom:
			guidePin = .top
			linePin = .bottom
			
			view.addConstraints([edges.bottom, edges.left, edges.right])
		}
		
		view.addConstraint(NSLayoutConstraint(
			item: guide, attribute: guidePin,
			relatedBy: .equal,
			toItem: line, attribute: linePin,
			multiplier: 1, constant: 0)
		)
		
		let innerGuide = setupInnerGuideView(position: position)
		
		view.addConstraints([
			NSLayoutConstraint(
				item: innerGuide, attribute: .height,
				relatedBy: .equal,
				toItem: guide, attribute: .height,
				multiplier: 1, constant: 0),
			NSLayoutConstraint(
				item: innerGuide, attribute: .width,
				relatedBy: .equal,
				toItem: guide, attribute: .width,
				multiplier: 1, constant: 0
			)]
		)
	}
	
	private func setupInnerGuideView(position: GuidePosition) -> UIView {
		let view: UIView
		
		switch position {
		case .top:
			view = innerHeaderGuide
		case .bottom:
			view = innerFooterGuide
		}
		
		scrollView.addSubview(view)
		let edges = view.constraintsToPinToSuperviewEdges()
		
		switch position {
		case .top:
			scrollView.addConstraints([edges.top, edges.left, edges.right])
		case .bottom:
			scrollView.addConstraints([edges.bottom, edges.left, edges.right])
		}
		
		return view
	}
	
	private func setupLineView(position: GuidePosition) -> UIView {
		let line = UIView()
		
		line.isHidden = true
		line.translatesAutoresizingMaskIntoConstraints = false
		
		line.addConstraint(NSLayoutConstraint(
			item: line,
			attribute: .height,
			relatedBy: .equal,
			toItem: nil,
			attribute: .notAnAttribute,
			multiplier: 1,
			constant: 1)
		)
		
		view.addSubview(line)
		let margins = line.constraintsToPinToSuperviewMargins()
		
		switch position {
		case .top:
			view.addConstraints([margins.top, margins.left, margins.right])
		case .bottom:
			view.addConstraints([margins.bottom, margins.left, margins.right])
		}
		
		return line
	}
	
}
