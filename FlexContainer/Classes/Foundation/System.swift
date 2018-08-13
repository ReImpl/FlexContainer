//
//  System.swift
//
//  Created by kernel on 12/29/15.
//  Copyright © 2016 ReImpl. All rights reserved.
//

public func onMainQueue(_ action: @escaping () -> ()) {
	DispatchQueue.main.async(execute: action)
}

public func onMainQueue(afterDelay seconds: Int, action: @escaping () -> ()) {
	let time = DispatchTime.now() + DispatchTimeInterval.seconds(seconds)
	
	DispatchQueue.main.asyncAfter(deadline: time, execute: action)
}

public func onMainQueue(afterDelay millis: Double, action: @escaping () -> ()) {
	let time = DispatchTime.now() + DispatchTimeInterval.milliseconds(Int(millis * 1000))
	
	DispatchQueue.main.asyncAfter(deadline: time, execute: action)
}

// MARK: -

func degreesToRadians(_ degrees: Float) -> Float {
	return degrees * Float.pi / 180.0
}

func radiansToDegrees(_ radians: Float) -> Float {
	return radians * 180.0 / Float.pi
}

// MARK: -

public func measure(_ action: () -> Void) -> Double {
	//	do {
	var info = mach_timebase_info(numer: 0, denom: 0)
	mach_timebase_info(&info)
	let begin = mach_absolute_time()
	
	action()
	
	return Double(mach_absolute_time() - begin) * Double(info.numer) / Double(info.denom)
	//	}
}

public func nanosToMillis(_ n: Double) -> Double {
	return n / 1000000
}

