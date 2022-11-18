//
//  JejuSoundView.swift
//  DorongDorong
//
//  Created by geonhyeong on 2022/11/17.
//

import SwiftUI
import URLImage
import AVFoundation

struct JejuSoundView: View {
	//MARK: Property Wrapper
	@ObservedObject var soundList = JejuSoundViewModel()
	@ObservedObject private var audioViewModel = RecorderViewModel(numberOfSamples: 21)
	@State private var presentSheet: Bool = false
	@State private var selectSound: JejuSound = JejuSound(jejuSoundNo: "0000000004", jejuSoundImgUrl: "https://dorongdorong.s3.ap-northeast-2.amazonaws.com/file/image/pm10_main.png", jejuSoundThumbnailImgUrl: "https://dorongdorong.s3.ap-northeast-2.amazonaws.com/file/image/pm10.png", jejuSoundTxt: "오후 10시의 새별오름\n공한 밤하늘 소리", jejuSoundUrl: "https://dorongdorong.s3.ap-northeast-2.amazonaws.com/file/sound/%E1%84%89%E1%85%A2%E1%84%87%E1%85%A7%E1%86%AF%E1%84%8B%E1%85%A9%E1%84%85%E1%85%B3%E1%86%B7.wav")
	@State private var isPlay: Bool = true
	@State private var isPlay2: Bool = false

	@State private var selectSoundNum: Bool = false
	let player = AVPlayer()
	let player2 = AVPlayer()

	init() {
		let fileUrl = Bundle.main.url(forResource: "sound1", withExtension: "mp3")!
		let playerItem = AVPlayerItem(url: fileUrl)
		player.replaceCurrentItem(with: playerItem)
		player.play()
		
		let fileUr2 = Bundle.main.url(forResource: "sound2", withExtension: "mp3")!
		let playerItem2 = AVPlayerItem(url: fileUr2)
		player2.replaceCurrentItem(with: playerItem2)
	}
	
	var body: some View {
		ZStack {
			Button {
				if selectSoundNum {
					if isPlay2 {
						player2.pause()
					} else {
						player2.play()
					}
					isPlay2.toggle()
				} else {
					if isPlay {
						player.pause()
					} else {
						player.play()
					}
					isPlay.toggle()
				}
			} label: {
				if URL(string: selectSound.jejuSoundImgUrl) != nil {
					URLImage(url: URL(string: selectSound.jejuSoundImgUrl)!, content: { image in
						image
							.resizable()
							.scaledToFit()
					})
				} else {
					Image("sample")
						.resizable()
						.scaledToFit()
				}
			}
		}

		.navigationBarItems(leading: Button(action: {
			presentSheet = true // Button action
		}) {
			Text("장소변경")
				.font(.custom("Pretendard-Medium", size: 12))
				.foregroundColor(.white)
				.padding(5)
				.overlay(
					RoundedRectangle(cornerRadius: 6)
						.stroke(.white, lineWidth: 1)
				)
		}) // VStack
		.sheet(isPresented: $presentSheet) {
			JejuSoundList(isPlay: $isPlay, isPlay2: $isPlay2, selectSoundNum: $selectSoundNum, soundList: soundList, presentSheet: $presentSheet, selectSound: $selectSound)
				.onDisappear {
					if selectSoundNum {
						player.pause()
						player2.play()
					} else {
						player2.pause()
						player.play()
					}
				}
		}
	}
}

struct BackgroundCleanerView: UIViewRepresentable {
	func makeUIView(context: Context) -> UIView {
		let view = UIView()
		DispatchQueue.main.async {
			view.superview?.superview?.backgroundColor = .clear
		}
		return view
	}
	
	func updateUIView(_ uiView: UIView, context: Context) {}
}


struct JejuSoundList: View {
	@Binding var isPlay: Bool
	@Binding var isPlay2: Bool
	@Binding var selectSoundNum: Bool
	@ObservedObject var soundList: JejuSoundViewModel
	@Binding var presentSheet: Bool
	@Binding var selectSound: JejuSound
	
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
				ForEach(0..<soundList.soundList.count, id: \.self) { i in
					JejuSoundCell(isPlay: $isPlay, isPlay2: $isPlay, selectSoundNum: $selectSoundNum, presentSheet: $presentSheet, selectSound: $selectSound, info: soundList.soundList[i])
				}
			}
		}
	}
}

struct JejuSoundCell: View {
	@Binding var isPlay: Bool
	@Binding var isPlay2: Bool
	@Binding var selectSoundNum: Bool
	@Binding var presentSheet: Bool
	@Binding var selectSound: JejuSound
	let info: JejuSound
	
	var body: some View {
		Button {
			presentSheet = false
			selectSound = info
			if info.jejuSoundTxt.hasPrefix("오후 6시") {
				selectSoundNum = true
				isPlay2 = true
				isPlay = false
			} else {
				selectSoundNum = false
				isPlay = true
				isPlay2 = false
			}
		} label: {
			URLImage(url: URL(string: info.jejuSoundThumbnailImgUrl)!, content: { image in
				image
					.resizable()
					.frame(width: Screen.maxWidth-(2*24.0), height: Screen.maxHeight*0.2)
					.cornerRadius(8)
			})
			.overlay {
				Text(info.jejuSoundTxt)
					.multilineTextAlignment(.leading)
					.font(.custom("Pretendard-Bold", size: 16))
					.foregroundColor(.white)
					.offset(x: -60, y: -40)
			}
		}
	}
}

struct JejuSoundView_Previews: PreviewProvider {
	static var previews: some View {
		NavigationView {
			ZStack {
				JejuSoundView()
			}
			.edgesIgnoringSafeArea(.all)
		}
		//		JejuSoundCell(info: JejuSound(jejuSoundNo: "0000000001", jejuSoundImgUrl: "", jejuSoundThumbnailImgUrl: "https://dorongdorong.s3.ap-northeast-2.amazonaws.com/file/image/pm6.png", jejuSoundTxt: "오후 6시의 다랑쉬오름\n노을 속 산책 발걸음 소리", jejuSoundUrl: "https://dorongdorong.s3.ap-northeast-2.amazonaws.com/file/sound/%E1%84%83%E1%85%A1%E1%84%85%E1%85%A1%E1%86%BC%E1%84%89%E1%85%B1%E1%84%8B%E1%85%A9%E1%84%85%E1%85%B3%E1%86%B7.mp3"))
	}
}
