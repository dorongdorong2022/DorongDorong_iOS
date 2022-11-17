//
//  Ex+Alert.swift
//  DorongDorong
//
//  Created by geonhyeong on 2022/11/18.
//

import UIKit
import SwiftUI

extension View {
	
	func alert(title: String = "", message: String = "", dismissButton: CustomAlertButton = CustomAlertButton(title: "ok"), isPresented: Binding<Bool>) -> some View {
		let title   = NSLocalizedString(title, comment: "")
		let message = NSLocalizedString(message, comment: "")
		
		return modifier(CustomAlertModifier(title: title, message: message, dismissButton: dismissButton, isPresented: isPresented))
	}
	
	func alert(title: String = "", message: String = "", primaryButton: CustomAlertButton, secondaryButton: CustomAlertButton, isPresented: Binding<Bool>) -> some View {
		let title   = NSLocalizedString(title, comment: "")
		let message = NSLocalizedString(message, comment: "")
		
		return modifier(CustomAlertModifier(title: title, message: message, primaryButton: primaryButton, secondaryButton: secondaryButton, isPresented: isPresented))
	}
}

struct CustomAlertModifier {
	
	// MARK: - Value
	// MARK: Private
	@Binding private var isPresented: Bool
	
	// MARK: Private
	private let title: String
	private let message: String
	private let dismissButton: CustomAlertButton?
	private let primaryButton: CustomAlertButton?
	private let secondaryButton: CustomAlertButton?
}


extension CustomAlertModifier: ViewModifier {
	
	func body(content: Content) -> some View {
		content
			.fullScreenCover(isPresented: $isPresented) {
				CustomAlert(title: title, message: message, dismissButton: dismissButton, primaryButton: primaryButton, secondaryButton: secondaryButton)
			}
	}
}

extension CustomAlertModifier {
	
	init(title: String = "", message: String = "", dismissButton: CustomAlertButton, isPresented: Binding<Bool>) {
		self.title         = title
		self.message       = message
		self.dismissButton = dismissButton
		
		self.primaryButton   = nil
		self.secondaryButton = nil
		
		_isPresented = isPresented
	}
	
	init(title: String = "", message: String = "", primaryButton: CustomAlertButton, secondaryButton: CustomAlertButton, isPresented: Binding<Bool>) {
		self.title           = title
		self.message         = message
		self.primaryButton   = primaryButton
		self.secondaryButton = secondaryButton
		
		self.dismissButton = nil
		
		_isPresented = isPresented
	}
}

import SwiftUI

struct CustomAlertButton: View {
	
	// MARK: - Value
	// MARK: Public
	let title: LocalizedStringKey
	var action: (() -> Void)? = nil
	
	
	// MARK: - View
	// MARK: Public
	var body: some View {
		Button {
			action?()
		} label: {
			Text(title)
				.font(.system(size: 14, weight: .medium))
				.foregroundColor(.white)
				.padding(.horizontal, 10)
		}
		.frame(width: 110, height: 54)
		.cornerRadius(15)
	}
}

struct CustomAlert: View {
	
	// MARK: - Value
	// MARK: Public
	let title: String
	let message: String
	let dismissButton: CustomAlertButton?
	let primaryButton: CustomAlertButton?
	let secondaryButton: CustomAlertButton?
	
	// MARK: Private
	@State private var opacity: CGFloat           = 0
	@State private var backgroundOpacity: CGFloat = 0
	@State private var scale: CGFloat             = 0.001
	@State private var text: String				  = ""
	@State private var isComplete: Bool		      = false
	@State private var isGo: Bool		      = false
	
	@Environment(\.dismiss) private var dismiss
	
	
	// MARK: - View
	// MARK: Public
	var body: some View {
		ZStack {
			ModalBackGround()
			
			alertView
				.scaleEffect(scale)
				.opacity(opacity)
			
			if opacity == 0 {
				if isGo {
					completeView
				} else {
					LodingView()
						.onAppear {
							DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
								isGo = true
							}
						}
				}
			}
		}
		.ignoresSafeArea()
		.transition(.opacity)
		.task {
			animate(isShown: true)
		}
		.onAppear { animate(isShown: true) }
	}
	
	// MARK: Private
	private var alertView: some View {
		VStack(spacing: 20) {
			titleView
			messageView
			buttonsView
		}
		.padding(24)
		.frame(width: 320)
		.background(Color("darkGray"))
		.cornerRadius(12)
		.shadow(color: Color.black.opacity(0.4), radius: 16, x: 0, y: 12)
	}
	
	@ViewBuilder
	private var titleView: some View {
		if !title.isEmpty {
			Text(title)
				.font(.system(size: 18, weight: .bold))
				.foregroundColor(.white)
				.lineSpacing(24 - UIFont.systemFont(ofSize: 18, weight: .bold).lineHeight)
				.multilineTextAlignment(.leading)
				.frame(maxWidth: .infinity, alignment: .leading)
		}
	}
	
	@ViewBuilder
	private var messageView: some View {
		VStack(spacing: 0) {
			TextField("입력해주세요", text: $text)
				.foregroundColor(.white)
				.font(.custom("Pretendard-SemiBold", size: 14))
			
			Rectangle() // 구분선 넣기
				.frame(height: 1)
				.foregroundColor(.white)
		}
		.padding(.top, 22)
	}
	
	private var buttonsView: some View {
		HStack(spacing: 12) {
			if dismissButton != nil {
				dismissButtonView
				
			} else if primaryButton != nil, secondaryButton != nil {
				secondaryButtonView
				primaryButtonView
			}
		}
		.padding(.top, 12)
	}
	
	@ViewBuilder
	private var primaryButtonView: some View {
		if let button = primaryButton {
			CustomAlertButton(title: button.title) {
				animate(isShown: false) {
					DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
						dismiss()
					}
					
					isComplete = true
				}
				
				DispatchQueue.main.asyncAfter(deadline: .now() + 3.7) {
					button.action?()
				}
			}
			.background(Color("violet"))
			.cornerRadius(10)
		}
	}
	
	@ViewBuilder
	private var completeView: some View {
		VStack {
			Text("저장이 완료되었습니다!")
				.font(.custom("Pretendard-Bold", size: 14))
				.padding(.bottom, 14)
			
			Text("제주설화를 저장된 목소리로 감상해보세요")
				.font(.custom("Pretendard-Medium", size: 14))
				.padding(.bottom, 32)
			
			Image("music")
				.resizable()
				.scaledToFit()
				.frame(width: 140)
		}
		.padding(24)
		.frame(width: 320)
		.background(Color("darkGray"))
		.cornerRadius(12)
		.shadow(color: Color.black.opacity(0.4), radius: 16, x: 0, y: 12)
		
	}
	
	
	@ViewBuilder
	private var secondaryButtonView: some View {
		if let button = secondaryButton {
			CustomAlertButton(title: button.title) {
				animate(isShown: false) {
					dismiss()
				}
				
				DispatchQueue.main.asyncAfter(deadline: .now() + 0.7) {
					button.action?()
				}
			}
			.foregroundColor(.black)
			.background(Color(uiColor: .lightGray))
			.cornerRadius(10)
		}
	}
	
	@ViewBuilder
	private var dismissButtonView: some View {
		if let button = dismissButton {
			CustomAlertButton(title: button.title) {
				animate(isShown: false) {
					dismiss()
				}
				
				DispatchQueue.main.asyncAfter(deadline: .now() + 0.7) {
					button.action?()
				}
			}
		}
	}
	
	private var dimView: some View {
		Color.gray
			.opacity(0.88)
			.opacity(backgroundOpacity)
	}
	
	
	// MARK: - Function
	// MARK: Private
	private func animate(isShown: Bool, completion: (() -> Void)? = nil) {
		switch isShown {
		case true:
			opacity = 1
			
			withAnimation(.spring(response: 0.3, dampingFraction: 0.9, blendDuration: 0).delay(0.5)) {
				backgroundOpacity = 1
				scale             = 1
			}
			
			DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
				completion?()
			}
			
		case false:
			withAnimation(.easeOut(duration: 0.2)) {
				backgroundOpacity = 0
				opacity           = 0
			}
			
			DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
				completion?()
			}
		}
	}
}

#if DEBUG
struct CustomAlert_Previews: PreviewProvider {
	
	static var previews: some View {
		let dismissButton   = CustomAlertButton(title: "OK")
		let primaryButton   = CustomAlertButton(title: "OK")
		let secondaryButton = CustomAlertButton(title: "Cancel")
		
		let title = "This is your life. Do what you want and do it often."
		let message = """
  If you don't like something, change it.
  If you don't like your job, quit.
  If you don't have enough time, stop watching TV.
  """
		
		return VStack {
			CustomAlert(title: title, message: message, dismissButton: nil,           primaryButton: nil,           secondaryButton: nil)
			CustomAlert(title: title, message: message, dismissButton: dismissButton, primaryButton: nil,           secondaryButton: nil)
			CustomAlert(title: title, message: message, dismissButton: nil,           primaryButton: primaryButton, secondaryButton: secondaryButton)
		}
		.previewDevice("iPhone 13 Pro Max")
		.preferredColorScheme(.light)
	}
}
#endif
