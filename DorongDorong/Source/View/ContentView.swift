//
//  ContentView.swift
//  DorongDorong
//
//  Created by geonhyeong on 2022/11/16.
//

import SwiftUI

struct ContentView: View {
	//MARK: Property Wrapper
	@State private var tabSelection: Tab = .sound
	@State private var presentSheet = false

	var body: some View {
		NavigationView {
			ZStack {
				switch tabSelection {
				case .sound:
					JejuSoundView(presentSheet: $presentSheet)
				case .tale:
					JejuTaleView(presentSheet: $presentSheet)
				case .tts:
					JejuTTSRegisterView()
				case .coach:
					Color.black
				default:
					Color.red
				}
				
				CustomTabView(selection: $tabSelection)
			} // ZStack
			.edgesIgnoringSafeArea(.all)
			.sheet(isPresented: $presentSheet) {
				ZStack {
					Color.white
					Text("Detail")
				}
				.edgesIgnoringSafeArea(.bottom)
			}
		}
	}
}

struct ContentView_Previews: PreviewProvider {
	static var previews: some View {
		ContentView()
	}
}
