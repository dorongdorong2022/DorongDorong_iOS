//
//  JejuTTSRegisterView.swift
//  DorongDorong
//
//  Created by geonhyeong on 2022/11/17.
//

import SwiftUI

struct JejuTTSRegisterView: View {
	//MARK: Property Wrapper
	@Environment(\.presentationMode) var presentable
	@ObservedObject var authorizationViewModel = AuthorizationViewModel()
	@ObservedObject private var audioRecorder = RecorderViewModel(numberOfSamples: 35)
	@ObservedObject var lyric: Lyriclist = Lyriclist()
	
	let widthPadding = 24.0
	let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
	@State private var count = 0
	@State private var curIndex = 0
	@State private var isStop: Bool = false
	
	var body: some View {
		ZStack {
			VStack {
				HStack {
					Text("아래 문장을 읽어주세요")
						.font(.custom("Pretendard-Bold", size: 20))
						.bold()
						.foregroundColor(.white)
					Spacer()
					
				} // HStack
				.padding(.bottom, 40)
				
				VStack {
					ScrollView(showsIndicators: false) {
						LazyVStack(spacing: 14) {
							Spacer()
							ForEach(lyric.allSongs, id: \.id) { lyric in
								HStack {
									Text(lyric.lyric)
										.foregroundColor(!lyric.isBlur ? Color("darkGray") : .white)
										.font(.custom(!lyric.isBlur ? "Pretendard-Medium" : "Pretendard-Bold", size: !lyric.isBlur ? 14: 18))
										.multilineTextAlignment(.leading)
									
									if lyric.isEnd {
										Image(systemName: "checkmark")
											.foregroundColor(Color("violet"))
									}
								}
							}
						}
						.onReceive(timer) { time in
							if !isStop {
								if audioRecorder.isRecording {
									count += 1
									if count % 5 == 0 { // 5초후 넘어감
										lyric.allSongs[curIndex].isBlur = false
										curIndex += 1
										if curIndex < lyric.allSongs.count {
											lyric.allSongs[curIndex-1].isEnd = true
											lyric.allSongs[curIndex].isBlur = true
										} else {
											lyric.allSongs[lyric.allSongs.count-1].isEnd = true
											isStop = true
											self.audioRecorder.stopRecording()
										}
									}
								} else {
									self.audioRecorder.stopRecording()
								}
							}
						}
						.padding()
					} // ScrollView
				} // VStack
				.frame(width: Screen.maxWidth-(widthPadding*2), height: 220)
				.overlay(
					RoundedRectangle(cornerRadius: 13)
						.stroke(.white, lineWidth: 1)
				)
				.padding(.bottom, 20)
				
				HStack(alignment: .center, spacing: 4) {
					ForEach(self.audioRecorder.soundSamples, id: \.self) { step in
						JejuTaleVoiceCellBarView(isStep: step)
					}
				} // HStack
				.frame(width: Screen.maxWidth-(widthPadding*2), height: 96)
				.background(Color("darkGray"))
				.clipShape (
					RoundedRectangle(cornerRadius: 13)
				)
				
				Spacer()
				
				Button(action: {
					if self.audioRecorder.isRecording {
						self.audioRecorder.stopRecording()
					} else {
						self.audioRecorder.startRecording()
					}
				}, label: {
					ZStack {
						if audioRecorder.isRecording { // 녹음 시작
							puaseButton // 정지 버튼
						} else { // 녹음 끝
							Circle()
								.frame(width: 64, height: 64)
								.foregroundColor(Color("violet"))
							
							Image(systemName: "record.circle")
								.resizable()
								.frame(width: 32, height: 32)
								.foregroundColor(Color.white)
						}
					}
				})
			} // Vstack
			.padding(24)
			.navigationBarBackButtonHidden(true)
			.navigationBarTitleDisplayMode(.inline)
			.navigationBarItems(leading: Button(action: {
				presentable.wrappedValue.dismiss()
			}) {
				Image(systemName: "chevron.backward")
					.foregroundColor(.white)
			})
			.onAppear {
				authorizationViewModel.showAudioRecord() // 권한 확인
			}
			.alert(isPresented: $authorizationViewModel.showErrorAlert) {
				// 허용안함, 카메라없는 error
				Alert(
					title: Text(authorizationViewModel.showErrorAlertTitle),
					message: Text(authorizationViewModel.showErrorAlertMessage),
					primaryButton: .default(Text("설정")) { // 앱 설정으로 이동
						if let appSettring = URL(string: UIApplication.openSettingsURLString) {
							UIApplication.shared.open(appSettring, options: [:], completionHandler: nil)
						}
					},
					secondaryButton: .default(Text("확인")) {
						
					})
			}
			.alert(title: "보이스의 이름을 입력해주세요", message: "message",
				   primaryButton: CustomAlertButton(title: "저장", action: {
				presentable.wrappedValue.dismiss()
				
			}),
				   secondaryButton: CustomAlertButton(title: "취소", action: {
				presentable.wrappedValue.dismiss()
			}),
				   isPresented: $isStop)
		} // Zstack
	}
	
	var playButton: some View {
		Button(action: {
			self.audioRecorder.startPlayback()
		}) {
			ZStack {
				Circle()
					.frame(width: 64, height: 64)
					.foregroundColor(Color("violet"))
				
				Image(systemName: "record.circle")
					.resizable()
					.scaledToFit()
					.foregroundStyle(.white)
					.frame(width: 28)
			}
		}
	}
	
	// 정지 버튼
	var puaseButton: some View {
		Group {
			Circle()
				.frame(width: 64, height: 64)
				.foregroundColor(Color("violet"))
			
			Image(systemName: "stop.fill")
				.resizable()
				.scaledToFit()
				.frame(height: 28)
				.foregroundStyle(.white)
		}
	}
	
}

struct JejuTTSRegisterView_Previews: PreviewProvider {
	static var previews: some View {
		NavigationView {
			JejuTTSRegisterView()
		}
	}
}
