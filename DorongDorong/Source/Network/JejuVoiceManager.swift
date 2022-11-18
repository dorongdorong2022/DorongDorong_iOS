//
//  JejuVoiceManager.swift
//  DorongDorong
//
//  Created by geonhyeong on 2022/11/18.
//

import Foundation
import Alamofire
import Combine

enum JejuVoiceManager: URLRequestConvertible {
	case getJejuVoice

	var baseURL: URL {
		switch self {
		case .getJejuVoice:
			return URL(string: "\(APIConstants.url)/jejustoryvoice/select/list/all")!
		}
	}
	
	var method: HTTPMethod {
		switch self {
		case .getJejuVoice:
			return .get
		}
	}
	
	var headers: HTTPHeaders {
		var headers = HTTPHeaders()
		headers["accept"] = "application/json;charset=utf8"
		headers["Content-Type"] = "application/json"
		headers["token"] = "\(Constant.accessToken!)"
		return headers
	}
	
	var parameters: Parameters {
		return Parameters()
	}
	
	func asURLRequest() throws -> URLRequest {
		let url = baseURL
		
		var request = URLRequest(url: url)
		
		request.method = method
		request.headers = headers

		request = try URLEncoding.default.encode(request, with: nil)

		return request
	}
}
