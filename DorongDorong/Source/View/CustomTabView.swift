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
		ZStack{
			HStack(alignment: .center, spacing: 8) {
				ForEach(0..<3) { index in
					Spacer().frame(width: Screen.maxWidth * 0.05)
					
					Button {
						switch index {
						case 0: selection = .sound
						case 1: selection = .tale
						case 2: selection = .tts
						default: selection = .sound
						}
					} label: {
						switch index {
						case 0: TabButton(isSelection: selection == .sound, systemName: "leaf.fill", systemNameByNotSelected: "leaf")
						case 1: TabButton(isSelection: selection == .tale, systemName: "book.fill", systemNameByNotSelected: "book")
						case 2: TabButton(isSelection: selection == .tts, systemName: "mic.fill", systemNameByNotSelected: "mic")
						default: TabButton(isSelection: selection == .sound, systemName: "leaf.fill", systemNameByNotSelected: "leaf")
						}
					}
					
					Spacer().frame(width: Screen.maxWidth * 0.05)
				} // HStack
				.frame(height: Screen.maxHeight * 0.11 - 5)
				.ignoresSafeArea(.keyboard)
				.edgesIgnoringSafeArea(.all)
			} // ZStack
			.frame(width: Screen.maxWidth)
			.background(Color(red: 0, green: 0, blue: 0, opacity: 0.3)) // 반투명
		}
		.ignoresSafeArea(.keyboard)
		.edgesIgnoringSafeArea([.bottom])
	}
}

//MARK: - TabButton
struct TabButton: View {
	//MARK: Property
	let isSelection: Bool // 현재 Tab
	let systemName: String // 선택되었을때
	let systemNameByNotSelected: String // 선택되지 않았을때
	
	var body: some View {
		VStack{
			Image(systemName: isSelection ? systemName : systemNameByNotSelected)
				.font(.system(size: 24))
				.padding(.vertical, 17)
				.foregroundColor(isSelection ? .white : .gray)
			Spacer()
		}
	}
}

struct CustomTabView_Previews: PreviewProvider {
	static var previews: some View {
		CustomTabView(selection: .constant(.sound))
	}
}
