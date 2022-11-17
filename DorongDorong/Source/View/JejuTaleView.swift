//
//  JejuTaleView.swift
//  DorongDorong
//
//  Created by geonhyeong on 2022/11/17.
//

import SwiftUI

struct JejuTaleView: View {
	//MARK: Property Wrapper
	@Binding var stack: NavigationPath	// 이전화면으로
	@Binding var presentSheet: Bool		// 설화변경 Modal
	
	var body: some View {
		VStack {
			Image("sample1")
				.resizable()
				.scaledToFill()
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
		}, trailing: NavigationLink(destination: JejuTaleVoiceView()) {
			Image(systemName: "person.wave.2.fill")
				.foregroundColor(.white)
		}.navigationBarBackButtonHidden(true)) // NavigationLink
	} // VStack
}

struct JejuTaleView_Previews: PreviewProvider {
	static var previews: some View {
		NavigationStack {
			ZStack {
				JejuTaleView(stack: .constant(NavigationPath()), presentSheet: .constant(false))
			}
			.edgesIgnoringSafeArea(.all)
		}
	}
}
