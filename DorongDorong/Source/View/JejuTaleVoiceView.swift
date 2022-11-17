//
//  JejuTaleVoiceView.swift
//  DorongDorong
//
//  Created by geonhyeong on 2022/11/17.
//

import SwiftUI

struct JejuTaleVoiceView: View {
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
//MARK: - JejuTaleVoice CellBar View
struct JejuTaleVoiceCellBarView: View {
	var isStep: Bool // 색상을 변경할지 결졍
	
	var body: some View {
	  Rectangle()
		.frame(width: 2, height: 32)
		.foregroundColor(isStep ? Color("violet") : Color(uiColor: .lightGray))
	}
}

struct JejuTaleVoiceView_Previews: PreviewProvider {
    static var previews: some View {
        JejuTaleVoiceView()
    }
}
