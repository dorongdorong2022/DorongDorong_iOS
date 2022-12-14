//
//  JejuTTSRegisterView.swift
//  DorongDorong
//
//  Created by geonhyeong on 2022/11/17.
//

import SwiftUI

struct JejuTTSExplainView: View {
	//MARK: Property
	let widthPadding = 24.0
	let explanation = [
		"조용한 공간에서 녹음해 주세요.",
		"- 회의실 또는 개인 공간(숙소) 같은 조용한 곳을 이용해 주세요.",
		"- 넓은 홀이나 창고, 전화 부스 등 좁은 공간처럼 조용하지만 소리가 울리는(에코) 환경은 피해주세요.",
		"",
		"하나의 분위기로 읽어주세요.",
		"- 일관된 분위기를 유지하며 동일한 목소리로 읽어주세요.",
		"- 평소 말하는 톤이나, 사투리로 읽어주셔도 괜찮습니다.",
		"  다만, 사투리를 쓰다가 표준어를 섞어서 쓰시면 목소리 학습 품질이 떨어질 수 있습니다.",
		"",
		"마이크를 통해 녹음해 주세요.",
		"- 이어폰 마이크 등을 사용하면 녹음 품질이 올라가요.(노이즈 제거 기능 포함 등)",
	]
	
	var body: some View {
		GeometryReader { geometry in
			VStack {
				HStack {
					Text("보이스를 등록하고 아이와 교감해보세요")
						.font(.custom("Pretendard-Bold", size: 20))
						.bold()
						.foregroundColor(.white)
					Spacer()
				} // HStack
				.padding(.top, geometry.safeAreaInsets.top + Screen.maxHeight * 0.11 - 5)
				.padding(.bottom, 20)
				
				Spacer()
				
				ScrollView {
					VStack(alignment: .leading, spacing: 10) {
						ForEach(0..<explanation.count, id: \.self) { i in
							if i == 0 || i == 4 || i == 9 {
								HStack {
									if i == 0 {
										Text("1")
											.font(.custom("Pretendard-Bold", size: 14))
											.padding(2)
											.padding([.leading, .trailing], 5)
											.foregroundColor(.black)
											.background(Color("violet"))
											.cornerRadius(30)
									} else if i == 4 {
										Text("2")
											.font(.custom("Pretendard-Bold", size: 14))
											.padding(2)
											.padding([.leading, .trailing], 4)
											.foregroundColor(.black)
											.background(Color("violet"))
											.cornerRadius(30)
									} else {
										Text("3")
											.font(.custom("Pretendard-Bold", size: 14))
											.padding(2)
											.padding([.leading, .trailing], 4)
											.foregroundColor(.black)
											.background(Color("violet"))
											.cornerRadius(30)
									}
									
									Text(explanation[i])
										.font(.custom("Pretendard-Bold", size: 16))
									
								}
							} else {
								Text(explanation[i])
									.font(.custom("Pretendard-Regular", size: 14))
									.foregroundColor(Color(uiColor: .lightGray))
							}
						}
						.foregroundColor(.white)
						.font(.custom("Pretendard-Regular", size: 16))
					} // VStack
				} // ScrollView
				
				NavigationLink(destination: JejuTTSRegisterView()){
					Text("녹음 시작하기")
						.font(.custom("Pretendard-SemiBold", size: 16))
						.foregroundColor(.white)
						.frame(width: Screen.maxWidth-(widthPadding*2), height: Screen.maxHeight*0.08)
						.background(Color("violet"))
						.cornerRadius(10)
				}
			} // VStack
			.padding(23)
			.padding(.bottom, geometry.safeAreaInsets.bottom + Screen.maxHeight * 0.11 - 5)
		} // GeometryReader
	}
}

struct JejuTTSExplain_Previews: PreviewProvider {
	static var previews: some View {
		NavigationView {
			ZStack {
				JejuTTSExplainView()
			}
			.ignoresSafeArea(.all)
		}
	}
}
