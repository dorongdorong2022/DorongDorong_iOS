//
//  Response.swift
//  DorongDorong
//
//  Created by geonhyeong on 2022/11/17.
//

import Foundation

struct LoginResponse: Decodable {
	let code: String
	let message: String
	let accessToken: String
}

struct JejuStoryListResponse: Decodable {
	let code: String
	let message: String
	let jejuStoryList: [JejuStory]
}

struct JejuSoundListResponse: Decodable {
	let code: String
	let message: String
	let jejuSoundList: [JejuSound]
}

struct JejuVoiceListResponse: Decodable {
	let code: String
	let message: String
	let jejuStoryVoiceList: [JejuVoice]
}
