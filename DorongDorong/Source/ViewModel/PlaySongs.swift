//
//  PlaySongs.swift
//  DorongDorong
//
//  Created by geonhyeong on 2022/11/17.
//

import Foundation

class Lyriclist: ObservableObject {
	@Published var allSongs: [Lyric]
	@Published var isListChanged: Bool = false
	@Published var noBlurCellIndex: Int = 0
	@Published var currentPlayTime: Double = 0
	
	init() {
		let lyriclist1 = [
			Lyric(lyric: "햇살도 둥글둥글하게 뭉치는 맑은 날", isBlur: true, isEnd: false, time: 4),
			Lyric(lyric: "꽃초롱 불 밝히듯 눈을 밝힐까", isBlur: false, isEnd: false, time: 4),
			Lyric(lyric: "흙에서 자란 내마음 파아란 하늘빛", isBlur: false, isEnd: false, time: 5),
			Lyric(lyric: "하늘을 우러러 한 점 부끄럼 없기를", isBlur: false, isEnd: false, time: 3),
			Lyric(lyric: "많고 많은 사람 중에 그대 한 사람", isBlur: false, isEnd: false, time: 6),
		]
		
		self.allSongs = lyriclist1
	}
}



