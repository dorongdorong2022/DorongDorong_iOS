//
//  LoginViewModel.swift
//  DorongDorong
//
//  Created by geonhyeong on 2022/11/17.
//

import Foundation
import Alamofire
import Combine
import SwiftKeychainWrapper

class LoginViewModel: ObservableObject {
	private var subscription = Set<AnyCancellable>()    // disposeBag

	init() {
		getToken()
	}
	
	func getToken() {
		AF.request(LoginManger.postLogin)
			.publishDecodable(type: LoginResponse.self)
			.value()
			.receive(on: DispatchQueue.main)
			.sink(
				receiveCompletion: { completion in
					print(completion)
					guard case .failure(let error) = completion else { return }
					switch error.responseCode {
					case 400: // 요청 에러 발생했을 때
						break
					case 500: // 서버의 내부적 에러가 발생했을 때
						break
					default:
						break
					}
				},
				receiveValue: { receivedValue in
					print("받은 값 : \(receivedValue)")
					Constant.accessToken = receivedValue.accessToken
					KeychainWrapper.standard.set(receivedValue.accessToken, forKey: "accessToken")
				}
			)
			.store(in: &subscription)  // disposed(by: disposeBag)
	}
}
