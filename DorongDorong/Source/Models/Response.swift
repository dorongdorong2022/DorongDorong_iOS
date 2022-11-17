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

struct JejuStoryVoiceListResponse: Decodable {
	let code: String
	let message: String
	let jejuStoryVoiceList: [JejuStory]
}
