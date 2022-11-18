//
//  JejuTaleView.swift
//  DorongDorong
//
//  Created by geonhyeong on 2022/11/17.
//

import SwiftUI
import URLImage
import AVFoundation

struct JejuTaleView: View {
	//MARK: Property Wrapper
	@ObservedObject var jejuTaleStoryViewModel = JejuTaleStoryViewModel()
	@ObservedObject private var audioViewModel = RecorderViewModel(numberOfSamples: 21)
	@State var presentSheet: Bool = false		// 설화변경 Modal
	@Binding var tabSelection: Tab	// 설화변경 Modal
	let player = AVPlayer()
	@State private var isPlay: Bool = true

	init(tabSelection: Binding<Tab>) {
		self._tabSelection = tabSelection
		let fileUrl = Bundle.main.url(forResource: "story", withExtension: "mp3")!
		let playerItem = AVPlayerItem(url: fileUrl)
		player.replaceCurrentItem(with: playerItem)
		let time = CMTime(value: 2, timescale: 1)
		player.play()
	}
	
	var body: some View {
		Button {
			if isPlay {
				player.pause()
			} else {
				player.play()
			}
			isPlay.toggle()
		} label: {
			Image("sample2")
				.resizable()
				.scaledToFit()
		}
		.navigationBarItems(leading: Button(action: {
			presentSheet = true // Button action
		}) {
			Text("설화변경")
				.font(.custom("Pretendard-Medium", size: 12))
				.foregroundColor(.white)
				.padding(5)
				.overlay(
					RoundedRectangle(cornerRadius: 6)
						.stroke(.white, lineWidth: 1)
				)
		}, trailing: NavigationLink(destination: JejuTaleVoiceView(tabSelection: $tabSelection).onAppear{player.pause()}) {
			Image("voice")
				.foregroundColor(.white)
		}.navigationBarBackButtonHidden(true)) // NavigationLink
		.sheet(isPresented: $presentSheet) {
			JejuStoryList(storyList: jejuTaleStoryViewModel, presentSheet: $presentSheet)
				.onDisappear {
					player.pause()
				}
		}
	} // VStack
}

struct JejuStoryList: View {
	@ObservedObject var storyList: JejuTaleStoryViewModel
	@Binding var presentSheet: Bool
	
	var body: some View {
		ScrollView {
			Image(systemName: "chevron.down")
				.resizable()
				.scaledToFit()
				.frame(width: 14)
				.padding(.bottom, 40)
				.padding(.top, 20)
				.foregroundColor(Color(uiColor: .lightGray))
			
			LazyVStack(spacing: 20) {
				ForEach(0..<storyList.storyList.count, id: \.self) { i in
					JejuStoryCell(presentSheet: $presentSheet, info: storyList.storyList[i])
				}
			}
		}
	}
}

struct JejuStoryCell: View {
	@Binding var presentSheet: Bool
	let info: JejuStory
	
	var body: some View {
		Button {
		} label: {
			ZStack {
				URLImage(url: URL(string: info.jejuStoryThumbnailImgUrl)!, content: { image in
					image
						.resizable()
						.frame(width: Screen.maxWidth-(2*24.0), height: Screen.maxHeight*0.2)
						.cornerRadius(8)
				})
				VStack {
					HStack {
						Text(info.jejuStoryTitle)
							.font(.custom("Pretendard-Bold", size: 16))
							.foregroundColor(.white)
							.multilineTextAlignment(.leading)

						Spacer()
					} // HStack
					.padding(.top, 26)
					Spacer()
				} // VStack
				.offset(x: 50)
			} // ZStack
		}
	}
}

struct JejuTaleView_Previews: PreviewProvider {
	static var previews: some View {
		NavigationView {
			ZStack {
				JejuTaleView(tabSelection: .constant(.sound))
			}
			.edgesIgnoringSafeArea(.all)
		}
	}
}
