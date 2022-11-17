//
//  Constants.swift
//  DorongDorong
//
//  Created by geonhyeong on 2022/11/17.
//

import SwiftUI
import SwiftKeychainWrapper

struct Screen {
	static let maxWidth = UIScreen.main.bounds.width
	static let maxHeight = UIScreen.main.bounds.height
}

class Constant {
	static var accessToken: String? = KeychainWrapper.standard.string(forKey: "accessToken") {
		didSet {
			guard let token = accessToken else { return }
			print("ACCESS TOKEN: \(token)")
			KeychainWrapper.standard.set(token, forKey: "accessToken")
		}
	}
}


public class Storage {
	static func isFirstTime() -> Bool {
		let defaults = UserDefaults.standard
		if defaults.object(forKey: "isFirstTime") == nil {
			defaults.set("No", forKey:"isFirstTime")
			return true
		} else {
			return false
		}
	}
}
