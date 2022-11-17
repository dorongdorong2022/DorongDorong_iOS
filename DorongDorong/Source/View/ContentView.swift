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
	
	var body: some View {
		ZStack {
			switch tabSelection {
			case .sound:
				JejuSoundView()
			case .tale:
				Color.blue
			default:
				Color.red
			}
			
			CustomTabView(selection: $tabSelection)
		} // ZStack
		.edgesIgnoringSafeArea(.all)
	}
}

struct ContentView_Previews: PreviewProvider {
	static var previews: some View {
		ContentView()
	}
}
