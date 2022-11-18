//
//  JejuTaleVoiceView.swift
//  DorongDorong
//
//  Created by geonhyeong on 2022/11/17.
//

import SwiftUI
import AVFoundation

struct JejuTaleVoiceView: View {
	//MARK: Property Wrapper
	@Environment(\.presentationMode) var presentable
	@ObservedObject var voiceViewModel = JejuTaleVoiceViewModel()
	@State private var isPlay: Bool = false
	@ObservedObject var audioViewModel = RecorderViewModel(numberOfSamples: 35)
	@Binding var tabSelection: Tab
	let player = AVPlayer()
	let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()

	//MARK: Property
	let screen = Screen.self
	let widthPadding = 24.0
	
	init(tabSelection: Binding<Tab>) {
		self._tabSelection = tabSelection
		let fileUrl = Bundle.main.url(forResource: "voice", withExtension: "mp3")!
		let playerItem = AVPlayerItem(url: fileUrl)
		player.replaceCurrentItem(with: playerItem)
		audioViewModel.startInit(audio: URL(string: "https://dorongdorong.s3.ap-northeast-2.amazonaws.com/file/sound/%E1%84%92%E1%85%A1%E1%86%AF%E1%84%86%E1%85%A1%E1%86%BC.wav")!)
	}
	
	var body: some View {
		VStack(spacing: 38) {
			HStack {
				Text("목소리를 선택해주세요")
					.font(.custom("Pretendard-Bold", size: 20))
					.bold()
					.foregroundColor(.white)
				Spacer()
			} // HStack
			
			ScrollView {
				LazyVStack(spacing: 21) {
					ForEach(0..<voiceViewModel.voiceList.count, id: \.self) { index in
						JejuTaleVoiceCellView(audioViewModel: audioViewModel, voiceViewModel: voiceViewModel, isPlay: $isPlay, info: voiceViewModel.voiceList[index], index: index, player: player)
					}
					
					// Last Element
					Button {
						tabSelection = .tts
					} label: {
						VStack(spacing: 8) {
							Text("음성 추가하기")
								.font(.custom("Pretendard-Regular", size: 12))

							Image(systemName: "plus")
								.resizable()
								.scaledToFit()
								.frame(width: 22)
						}
					}
					.foregroundColor(Color(uiColor: .darkGray))
					.frame(width: screen.maxWidth-(widthPadding*2), height: screen.maxHeight*0.15)
					.background(Color(uiColor: .clear))
					.overlay(
						RoundedRectangle(cornerRadius: 10)
							.stroke(Color(uiColor: .darkGray), lineWidth: 2)
					)
				} // List
			} // ScrollView
		} // VStack
		.padding([.leading, .trailing], 22)
		.background(.black)
		.navigationBarBackButtonHidden(true)
		.navigationBarTitleDisplayMode(.inline)
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
	@ObservedObject var audioViewModel: RecorderViewModel
	@ObservedObject var audioRecorder = RecorderViewModel(numberOfSamples: 35)
	@ObservedObject var voiceViewModel: JejuTaleVoiceViewModel
	@Binding var isPlay: Bool
	
	//MARK: Property
	let screen = Screen.self
	let widthPadding = 24.0
	var info: JejuVoice
	var index: Int
	let player: AVPlayer

	var body: some View {
		ZStack {
			Button(action: {
				voiceViewModel.voiceList[index].checkYn.toggle()
			}) {
				VStack {
					HStack {
						Text(info.jejuStoryVoiceNm)
							.font(.custom("Pretendard-SemiBold", size: 14))
						Spacer()
						if info.checkYn {
							Circle()
								.foregroundColor(.white)
								.frame(width: 20)
								.overlay {
									Image(systemName: info.checkYn ? "checkmark" : "")
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
					.padding(22)
					
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
							ForEach(self.audioViewModel.soundSamples, id: \.self) { step in
								JejuTaleVoiceCellBarView(isStep: step)
							}
						} // HStack
					}
					.padding([.leading, .bottom, .trailing], 22)
				} // VStack
			} // Button
			.frame(width: screen.maxWidth-(widthPadding*2), height: screen.maxHeight*0.15)
			.background(Color("darkGray"))
			.cornerRadius(10)
			
			Button {
				
				if isPlay {
					player.pause()
				} else {
					player.play()
				}
				
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
			.foregroundColor(isStep ? Color("violet") : Color(uiColor: .darkGray))
	}
}

struct JejuTaleVoiceView_Previews: PreviewProvider {
	static var previews: some View {
		NavigationView {
			ZStack {
				JejuTaleVoiceView(tabSelection: .constant(.sound))
			}
		}
	}
}
