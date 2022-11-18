//
//  JejuVoice.swift
//  DorongDorong
//
//  Created by geonhyeong on 2022/11/18.
//

import Foundation

struct JejuVoice: Decodable {
	var checkYn: Bool
	let jejuStoryVoiceNm: String
	let jejuStoryVoiceNo: String
	let jejuStoryVoiceSeqNo: Int
	let jejuStoryVoiceUrl: String
	let userNo: String
}
