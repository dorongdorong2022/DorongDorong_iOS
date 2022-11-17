//
//  JejuSoundView.swift
//  DorongDorong
//
//  Created by geonhyeong on 2022/11/17.
//

import SwiftUI

struct JejuSoundView: View {
	var body: some View {
		VStack {
			Image("sample1")
				.resizable()
				.scaledToFill()
		}
		.navigationBarItems(leading: Button(action: {
			// Button action
		}) {
			Text("장소변경")
				.font(.system(size: 12))
				.foregroundColor(.white)
				.padding(5)
				.overlay(
					RoundedRectangle(cornerRadius: 6)
						.stroke(.white, lineWidth: 1)
				)
		})
	}
}

struct JejuSoundView_Previews: PreviewProvider {
	static var previews: some View {
		NavigationStack {
			ZStack {
				JejuSoundView()
			}
		}
		.edgesIgnoringSafeArea(.all)
	}
}
