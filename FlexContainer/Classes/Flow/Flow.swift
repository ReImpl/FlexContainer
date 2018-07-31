//
//  FlexibleContainerView.swift
//  FlowController
//
//  Created by kernel on 12/23/16.
//  Copyright © 2016 ReImpl. All rights reserved.
//

import UIKit

public struct Storyboard {
	
	public let name: String
	
	public init(named s: String) {
		name = s
	}
	
}

public protocol Flow {
	
	var initialStoryboard: Storyboard { get }
	
}


