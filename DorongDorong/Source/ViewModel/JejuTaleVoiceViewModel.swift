//
//  JejuTaleVoiceViewModel.swift
//  DorongDorong
//
//  Created by geonhyeong on 2022/11/17.
//

import SwiftUI
import Combine

class JejuTaleVoiceViewModel: ObservableObject {
	@Published var voiceList: [VoiceCell] = [VoiceCell(id: "01", name: "엄마", fileLink: "", isSelected: true)]
	@Published var isActive: [Bool] = []
}


