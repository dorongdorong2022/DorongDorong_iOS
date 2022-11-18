//
//  SplashView.swift
//  DorongDorong
//
//  Created by geonhyeong on 2022/11/18.
//

import SwiftUI

struct SplashView: View {
	
	@State var isActive:Bool = false
	
	var body: some View {
		VStack {
			// 2.
			if self.isActive {
				// 3.
				ContentView()
			} else {
				// 4.
				Image("splash")
					.resizable()
					.scaledToFill()
					.ignoresSafeArea()
			}
		}
		// 5.
		.onAppear {
			// 6.
			DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
				// 7.
				withAnimation {
					self.isActive = true
				}
			}
		}
	}
}

struct SplashView_Previews: PreviewProvider {
    static var previews: some View {
        SplashView()
    }
}
