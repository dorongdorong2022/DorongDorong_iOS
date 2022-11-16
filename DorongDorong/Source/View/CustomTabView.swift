//
//  CustomTabView.swift
//  DorongDorong
//
//  Created by geonhyeong on 2022/11/17.
//

import SwiftUI

enum Tab {
	case sound
	case tale
	case tts
}

struct CustomTabView: View {
	//MARK: Property Wrapper
	@Binding var selection: Tab
	
	var body: some View {
		ZStack {
			HStack(alignment: .center, spacing: 8) {
				ForEach(0..<3) { index in
					Spacer().frame(width: Screen.maxWidth * 0.08)
					
					Button {
						switch index {
						case 0: selection = .sound
						case 1: selection = .tale
						case 2: selection = .tts
						default: selection = .sound
						}
					} label: {
						switch index {
						case 0: TabButton(isSelection: selection == .sound, name: "제주소리", systemName: "leaf.fill", systemNameByNotSelected: "leaf")
						case 1: TabButton(isSelection: selection == .tale, name: "제주설화", systemName: "book.fill", systemNameByNotSelected: "book")
						default: TabButton(isSelection: selection == .tts, name: "보이스", systemName: "mic.fill", systemNameByNotSelected: "mic")
						}
					}
					
					Spacer().frame(width: Screen.maxWidth * 0.08)
				} // HStack
				.frame(height: Screen.maxHeight * 0.11 - 5)
				.edgesIgnoringSafeArea(.all)
			} // ZStack
			.frame(width: Screen.maxWidth)
			.background(Color(red: 0, green: 0, blue: 0, opacity: 0.3)) // 반투명
		}
		.edgesIgnoringSafeArea([.bottom])
	}
}

//MARK: - TabButton
struct TabButton: View {
	//MARK: Property
	let isSelection: Bool 	// 현재 Tab
	let name: String		// Tab 이름
	let systemName: String 	// 선택되었을때
	let systemNameByNotSelected: String // 선택되지 않았을때
	
	var body: some View {
		VStack(spacing: 5) {
			Image(systemName: isSelection ? systemName : systemNameByNotSelected)
				.font(.system(size: 24))
			Text(name)
				.font(.system(size: 11))
			Spacer()
		}
		.padding(.vertical, 17)
		.foregroundColor(isSelection ? .white : .gray)
	}
}

struct CustomTabView_Previews: PreviewProvider {
	static var previews: some View {
		CustomTabView(selection: .constant(.sound))
	}
}
