//
//  Song.swift
//  DorongDorong
//
//  Created by geonhyeong on 2022/11/17.
//

import Foundation

class Song: ObservableObject {
	var name: String
	var singer: String
	var cover: String
	var lyrics: [Lyric]
	
	init(name: String, singer: String, cover: String, lyrics: [Lyric]) {
		self.lyrics = lyrics
		self.name = name
		self.singer = singer
		self.cover = cover
	}
}

class Lyric {
	var id: UUID = UUID()
	var isBlur: Bool
	var lyric: String
	var isEnd: Bool
	var time: Int
	
	init(lyric: String, isBlur: Bool, isEnd: Bool, time: Int) {
		self.lyric = lyric
		self.isBlur = isBlur
		self.isEnd = isEnd
		self.time = time
	}
}
