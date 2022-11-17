//
//  VoiceCell.swift
//  DorongDorong
//
//  Created by geonhyeong on 2022/11/17.
//

import Foundation

struct JejuStory: Codable, Identifiable {
	var id = UUID()
	let jejuStoryVoiceSeqNo: Int
	let jejuStoryVoiceNm: String
	let jejuStoryVoiceNo: String
	let jejuStoryVoiceUrl: String
	var userNo: String
	var checkYn: Bool
}
