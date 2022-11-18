//
//  CustomTabView.swift
//  DorongDorong
//
//  Created by geonhyeong on 2022/11/17.
//

import SwiftUI

enum Tab {
	case tts
	case tale
	case sound
	case coach
}

struct CustomTabView: View {
	//MARK: Property Wrapper
	@Binding var selection: Tab
	
	var body: some View {
		VStack {
			Spacer()
			ZStack {
				HStack(alignment: .center, spacing: 8) {
					ForEach(0..<4) { index in
						Spacer().frame(width: Screen.maxWidth * 0.04)
						
						Button {
							switch index {
							case 0: selection = .tts
							case 1: selection = .tale
							case 2: selection = .sound
							default: selection = .coach
							}
						} label: {
							switch index {
							case 0: TabButton(isSelection: selection == .tts, name: "보이스", systemName: "tab3.fill", systemNameByNotSelected: "tab3")
							case 1:
								TabButton(isSelection: selection == .tale, name: "제주설화", systemName: "tab2.fill", systemNameByNotSelected: "tab2")
							case 2: TabButton(isSelection: selection == .sound, name: "제주소리", systemName: "tab1.fill", systemNameByNotSelected: "tab1")
							default: TabButton(isSelection: selection == .coach, name: "챌린지", systemName: "tab4.fill", systemNameByNotSelected: "tab4")
							}
						}
						
						Spacer().frame(width: Screen.maxWidth * 0.04)
					} // HStack
					.frame(height: Screen.maxHeight * 0.12)
					.edgesIgnoringSafeArea(.all)
				} // ZStack
				.frame(width: Screen.maxWidth)
				.background(Color(red: 0, green: 0, blue: 0, opacity: 0.5)) // 반투명
				.cornerRadius(22)
			}
			.edgesIgnoringSafeArea([.bottom])
		} // VStack
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
			Image(isSelection ? systemName : systemNameByNotSelected)
				.resizable()
				.scaledToFit()
				.frame(width: 24)
			Text(name)
				.font(.custom("Pretendard-Medium", size: 11))
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
