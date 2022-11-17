//
//  AuthorizationViewModel.swift
//  DorongDorong
//
//  Created by geonhyeong on 2022/11/17.
//

import SwiftUI

class AuthorizationViewModel: ObservableObject {
  @Published var showErrorAlert = false
  @Published var showErrorAlertTitle = "오류"
  @Published var showErrorAlertMessage = "오류"
  
  // 녹음 권한 확인
  @Published var showRecord = false
  @Published var recordError: RecordAuthorization.RecordErrorType?
  
  // Record 보기 전, 권한 확인
  func showAudioRecord() {
	do {
	  try RecordAuthorization.checkPermissions()
	  showRecord = true
	} catch { // 권한 오류가 발생
	  showErrorAlert = true
	  showErrorAlertTitle = "녹음 접근 오류"
	  recordError = RecordAuthorization.RecordErrorType(error: error as! RecordAuthorization.RecordError)
	  showErrorAlertMessage = recordError!.message
	}
  }
}
