//
//  ContentView.swift
//  DorongDorong
//
//  Created by geonhyeong on 2022/11/16.
//

import SwiftUI

struct ContentView: View {
	//MARK: Property Wrapper
	@State private var tabSelection: Tab = .tts
	@State private var presentSheet = false

	var body: some View {
		NavigationView {
			ZStack {
				switch tabSelection {
				case .tts:
					JejuTTSExplainView()
				case .tale:
					JejuTaleView(tabSelection: $tabSelection)
				case .sound:
					JejuSoundView()
				case .coach:
					JejuCoachView()
				}
				
				CustomTabView(selection: $tabSelection)
			} // ZStack
			.edgesIgnoringSafeArea(.all)
		}
	}
}

struct ContentView_Previews: PreviewProvider {
	static var previews: some View {
		ContentView()
	}
}
