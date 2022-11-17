//
//  LodingView.swift
//  DorongDorong
//
//  Created by geonhyeong on 2022/11/18.
//

import SwiftUI

struct LodingView: View {
	var body: some View {
		ZStack {
			Color.black
				.ignoresSafeArea()
				.opacity(0.2)
			
			ProgressView()
				.progressViewStyle(CircularProgressViewStyle(tint: Color("violet")))
				.scaleEffect(3)
		}
	}
}

struct LodingView_Previews: PreviewProvider {
	static var previews: some View {
		LodingView()
	}
}
