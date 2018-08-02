//
//  TableView.swift
//
//  Created by kernel on 12/29/15.
//  Copyright © 2016 ReImpl. All rights reserved.
//

public extension UITableView {
	
	@objc
	public func registerCell(nibClass cls: UITableViewCell.Type) {
		let identifier = cls.className
		let nib = UINib(nibName: identifier, bundle: nil)
		
		register(nib, forCellReuseIdentifier: identifier)
	}
	
}
