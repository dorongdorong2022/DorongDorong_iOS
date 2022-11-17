//
//  JejuTaleVoiceView.swift
//  DorongDorong
//
//  Created by geonhyeong on 2022/11/17.
//

import SwiftUI

struct JejuTaleVoiceView: View {
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
//MARK: - JejuTaleVoice CellView
struct JejuTaleVoiceCellView: View {
	//MARK: Property Wrapper
	@Binding var isPlay: Bool
	
	//MARK: Property
	let screen = Screen.self
	let widthPadding = 10.0
	var info: VoiceCell
	
	var body: some View {
		ZStack {
			Button(action: {
				
			}) {
				VStack {
					HStack {
						Text(info.name)
							.font(.system(size: 14, weight: .semibold))
						Spacer()
						if info.isSelected {
							Circle()
								.foregroundColor(.white)
								.frame(width: 20)
								.overlay {
									Image(systemName: info.isSelected ? "checkmark" : "")
										.resizable()
										.scaledToFit()
										.frame(width: 10)
										.foregroundColor(Color(uiColor: .darkGray))
										.cornerRadius(5)
								} // Circle
						} else {
							Circle()
								.stroke(.white, lineWidth: 1)
								.frame(width: 20)
						}
					} // HStack
					.foregroundColor(.white)
					.padding()
					
					HStack {
						Button {
						} label: {
							Image(systemName: isPlay ? "play.circle.fill" : "play.circle")
								.resizable()
								.scaledToFit()
								.symbolRenderingMode(.palette)
								.foregroundStyle(isPlay ? .white : Color("violet"), Color("violet"))
								.frame(width: 44)
								.hidden()
						}
						Spacer()
					}
					.padding([.bottom, .trailing], 22)
					.padding(.leading, 15)
				} // VStack
			} // Button
			.frame(width: screen.maxWidth-(widthPadding*2), height: screen.maxHeight*0.15)
			.background(Color(uiColor: .darkGray))
			.cornerRadius(10)
			
			Button {
				isPlay.toggle()
			} label: {
				Image(systemName: isPlay ? "play.circle.fill" : "play.circle")
					.resizable()
					.scaledToFit()
					.symbolRenderingMode(.palette)
					.foregroundStyle(isPlay ? .white : Color("violet"), Color("violet"))
					.frame(width: 44)
			}
			.offset(x: -140, y: 20)
		} // ZStack
	}
}

//MARK: - JejuTaleVoice CellBar View
struct JejuTaleVoiceCellBarView: View {
	var isStep: Bool // 색상을 변경할지 결졍
	
	var body: some View {
	  Rectangle()
		.frame(width: 2, height: 32)
		.foregroundColor(isStep ? Color("violet") : Color(uiColor: .lightGray))
	}
}

struct JejuTaleVoiceView_Previews: PreviewProvider {
	static var previews: some View {
		//		NavigationStack {
		//			ZStack {
		//				JejuTaleVoiceView()
		//			}
		//			.edgesIgnoringSafeArea(.all)
		//		}
		
		JejuTaleVoiceCellView(isPlay: .constant(true), info: VoiceCell(id: "1", name: "엄마", fileLink: "dasd", isSelected: true))

//		JejuTaleVoiceCellBarView(isStep: true)
	}
}
