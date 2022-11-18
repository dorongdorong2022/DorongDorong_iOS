//
//  JejuCoachView.swift
//  DorongDorong
//
//  Created by geonhyeong on 2022/11/18.
//

import SwiftUI

struct JejuCoachView: View {
	let widthPadding = 24.0
	let cardList = ["card1", "card2", "card3", "card4"]
	let textList = [
		"태교가 궁금하신가요?\n태교의 정의부터 알아보기",
		"임신 초기에 놓치지 말아야 할\n태교 꿀 TIP 알려드릴게요",
		"우리 아이 뇌 발달 촉진시키는 청각,\n소리 태교의 비밀!",
		"임신 중기, 뭘 먹어야\n엄마도 아이도 건강할 수 있을까?"
	]
	
	var body: some View {
		GeometryReader { geometry in
			VStack {
				HStack {
					Text("우리 아이를 위한 태교코칭")
						.font(.custom("Pretendard-Bold", size: 20))
						.bold()
						.foregroundColor(.white)
					Spacer()
				} // HStack
				.padding(.top, geometry.safeAreaInsets.top + Screen.maxHeight * 0.11 - 5)
				.padding(.bottom, 20)
				
				Spacer()
				
				ScrollView(showsIndicators: false) {
					LazyVStack(spacing: 20) {
						ForEach(0..<cardList.count, id: \.self) { i in
							Button {
								
							} label: {
								ZStack {
									Image(cardList[i])
										.resizable()
										.scaledToFit()
										.frame(height: Screen.maxHeight*0.2)
									VStack {
										HStack {
											Text(textList[i])
												.font(.custom("Pretendard-Bold", size: 16))
												.multilineTextAlignment(.leading)
												.foregroundColor(.white)
											Spacer()
										} // HStack
										.padding([.leading], 26)
										.padding(.top, 26)
										Spacer()
									} // VStack
								} // ZStack

							}
						}
					} // LazyVStack
				} // ScrollView
			} // VStack
			.padding(24)
			.padding(.bottom, geometry.safeAreaInsets.bottom + Screen.maxHeight * 0.11 - 5)
			
		} // GeometryReader
	}
}

struct JejuCoachView_Previews: PreviewProvider {
	static var previews: some View {
		NavigationView {
			ZStack {
				JejuCoachView()
			}
			.ignoresSafeArea(.all)
		}
	}
}
