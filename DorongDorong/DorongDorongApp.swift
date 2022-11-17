//
//  DorongDorongApp.swift
//  DorongDorong
//
//  Created by geonhyeong on 2022/11/16.
//

import SwiftUI
import SwiftKeychainWrapper

@main
struct DorongDorongApp: App {
	@ObservedObject var login: LoginViewModel = LoginViewModel()
	
	init() {
		if Storage.isFirstTime() { // 첫 실행
			Constant.accessToken = nil
			KeychainWrapper.standard.remove(forKey: "accessToken")
		}
	}
	
	var body: some Scene {
		WindowGroup {
			ContentView()
				.onAppear {
					login.getToken()
				}
		}
	}
}
