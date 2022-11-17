//
//  LoginManger.swift
//  DorongDorong
//
//  Created by geonhyeong on 2022/11/17.
//

import Foundation
import Alamofire
import Combine

enum LoginManger: URLRequestConvertible {
	
	case postLogin
	
	var baseURL: URL {
		switch self {
		case .postLogin:
			return URL(string: "\(APIConstants.url)/login/device")!
		}
	}
	
	var method: HTTPMethod {
		switch self {
		case .postLogin:
			return .post
		}
	}
	
	var headers: HTTPHeaders {
		var headers = HTTPHeaders()
		headers["accept"] = "application/json;charset=utf8"
		headers["Content-Type"] = "application/json"
		return headers
	}
	
	var parameters: Parameters {
		var params = Parameters()
		params["fcmToken"] = "string"

		return params
	}
	
	func asURLRequest() throws -> URLRequest {
		let url = baseURL
		
		var request = URLRequest(url: url)
		
		request.method = method
		request.headers = headers

		request.httpBody = try JSONEncoding.default.encode(request, with: parameters).httpBody

		return request
	}
}
