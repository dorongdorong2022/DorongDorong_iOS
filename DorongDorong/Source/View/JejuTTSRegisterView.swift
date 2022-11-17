//
//  JejuTTSRegisterView.swift
//  DorongDorong
//
//  Created by geonhyeong on 2022/11/17.
//

import SwiftUI

struct JejuTTSRegisterView: View {
	//MARK: Property Wrapper
	@Environment(\.presentationMode) var presentable

    var body: some View {
		VStack {
			HStack {
				Text("보이스 녹음 설명")
					.font(.custom("Pretendard-Bold", size: 20))
					.bold()
					.foregroundColor(.white)
				Spacer()
			} // HStack

		}
		.navigationBarBackButtonHidden(true)
		.navigationBarItems(leading: Button(action: {
			presentable.wrappedValue.dismiss()
		}) {
			Image(systemName: "chevron.backward")
				.foregroundColor(.white)
		})
    }
}

struct JejuTTSRegisterView_Previews: PreviewProvider {
    static var previews: some View {
		NavigationView {
			JejuTTSRegisterView()
		}
    }
}
