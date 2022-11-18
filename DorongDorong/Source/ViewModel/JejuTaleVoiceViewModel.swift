//
//  JejuTaleVoiceViewModel.swift
//  DorongDorong
//
//  Created by geonhyeong on 2022/11/17.
//

import SwiftUI
import Combine
import Alamofire

class JejuTaleVoiceViewModel: ObservableObject {
	@Published var voiceList: [JejuVoice] = []
	@Published var isActive: [Bool] = []
	
	private var subscription = Set<AnyCancellable>()    // disposeBag

	init() {
		getList()
	}
	
	func getList() {
		AF.request(JejuVoiceManager.getJejuVoice)
			.publishDecodable(type: JejuVoiceListResponse.self)
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
					self.voiceList = receivedValue.jejuStoryVoiceList
					self.isActive = [Bool](repeating: false, count: self.voiceList.count)
				}
			)
			.store(in: &subscription)  // disposed(by: disposeBag)
	}

}


