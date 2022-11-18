//
//  JejuTaleStoryViewModel.swift
//  DorongDorong
//
//  Created by geonhyeong on 2022/11/18.
//

import SwiftUI
import Combine
import Alamofire

class JejuTaleStoryViewModel: ObservableObject {
	@Published var storyList: [JejuStory] = []
	
	private var subscription = Set<AnyCancellable>()    // disposeBag

	init() {
		getList()
	}
	
	func getList() {
		AF.request(JejuStoryManager.getJejuStory)
			.publishDecodable(type: JejuStoryListResponse.self)
			.value()
			.receive(on: DispatchQueue.main)
			.sink(
				receiveCompletion: { completion in
					print("JejuSoundViewModel 받은 값 : \(completion)")
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
					self.storyList = receivedValue.jejuStoryList
				}
			)
			.store(in: &subscription)  // disposed(by: disposeBag)
	}
}
