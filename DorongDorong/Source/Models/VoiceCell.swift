//
//  VoiceCell.swift
//  DorongDorong
//
//  Created by geonhyeong on 2022/11/17.
//

import Foundation

struct VoiceCell: Codable, Identifiable {
	let id: String
	let name: String
	let fileLink: String
	let isSelected: Bool
}
