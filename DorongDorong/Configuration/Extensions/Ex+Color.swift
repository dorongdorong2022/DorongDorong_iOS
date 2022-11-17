//
//  Ex+Color.swift
//  DorongDorong
//
//  Created by geonhyeong on 2022/11/17.
//

import SwiftUI

extension Color {
	fileprivate static let backgroundGradientStart = Color("backgroundGradientStart")
	fileprivate static let backgroundGradientEnd = Color("backgroundGradientEnd")
}

extension LinearGradient {
	static func backgroundGradient(startPoint: UnitPoint, endPoint: UnitPoint) -> LinearGradient {
		let colors: [Color] = [.backgroundGradientStart, .backgroundGradientEnd]
		return gradient(colors: colors, startPoint: startPoint, endPoint: endPoint)
	}
	
	private static func gradient(colors: [Color], startPoint: UnitPoint, endPoint: UnitPoint) -> LinearGradient {
		return LinearGradient(gradient: Gradient(colors: colors), startPoint: startPoint, endPoint: endPoint)
	}
}
