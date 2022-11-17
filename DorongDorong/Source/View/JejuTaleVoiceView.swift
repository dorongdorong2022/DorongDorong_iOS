//
//  JejuTaleVoiceView.swift
//  DorongDorong
//
//  Created by geonhyeong on 2022/11/17.
//

import SwiftUI

struct JejuTaleVoiceView: View {
	//MARK: Property Wrapper
	@Environment(\.presentationMode) var presentable
	@ObservedObject var voiceViewModel = JejuTaleVoiceViewModel()
	@State private var isPlay: Bool = false
	
	//MARK: Property
	let screen = Screen.self
	let widthPadding = 24.0
	
	var body: some View {
		VStack(spacing: 20) {
			HStack {
				Text("목소리를 선택해주세요")
					.font(.system(size: 20))
					.bold()
					.foregroundColor(.white)
				Spacer()
			} // HStack
			
			List {
				ForEach(0..<voiceViewModel.voiceList.count, id: \.self) { index in
					JejuTaleVoiceCellView(voiceViewModel: voiceViewModel, isPlay: $isPlay, info: voiceViewModel.voiceList[index], index: index)
				}
				
				// Last Element
				Button {
					
				} label: {
					VStack(spacing: 8) {
						Text("음성 추가하기")
						
						Image(systemName: "plus")
							.resizable()
							.scaledToFit()
							.frame(width: 22)
					}
				}
				.foregroundColor(Color(uiColor: .lightGray))
				.frame(width: screen.maxWidth-(widthPadding*2), height: screen.maxHeight*0.15)
			}
		} // VStack
		.padding()
		.background(.black)
		.navigationBarBackButtonHidden(true)
		.navigationBarItems(leading: Button(action: {
			presentable.wrappedValue.dismiss()
		}) {
			Image(systemName: "chevron.backward")
				.foregroundColor(.white)
		})
	}
}

//MARK: - JejuTaleVoice CellView
struct JejuTaleVoiceCellView: View {
	//MARK: Property Wrapper
	@ObservedObject private var audioRecorder = RecorderViewModel(numberOfSamples: 35)
	@ObservedObject var voiceViewModel: JejuTaleVoiceViewModel
	@Binding var isPlay: Bool
	
	//MARK: Property
	let screen = Screen.self
	let widthPadding = 24.0
	var info: VoiceCell
	var index: Int
	
	var body: some View {
		ZStack {
			Button(action: {
				voiceViewModel.isActive[index].toggle()
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
					.padding([.leading, .top, .trailing], 22)
					
					HStack(spacing: 22) {
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
						
						HStack(alignment: .center, spacing: 4) {
							ForEach(self.audioRecorder.soundSamples, id: \.self) { step in
								JejuTaleVoiceCellBarView(isStep: step)
							}
						} // HStack
					}
					.padding([.leading, .bottom, .trailing], 22)
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
			.offset(x: -120, y: 15)
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
		NavigationStack {
			ZStack {
				JejuTaleVoiceView()
			}
		}
	}
}
