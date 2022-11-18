//
//  JejuSoundManger.swift
//  DorongDorong
//
//  Created by geonhyeong on 2022/11/18.
//

import Foundation
import Alamofire
import Combine

enum JejuStoryManager: URLRequestConvertible {
	case getJejuStory

	var baseURL: URL {
		switch self {
		case .getJejuStory:
			return URL(string: "\(APIConstants.url)/jejustory/select/list/10")!
		}
	}
	
	var method: HTTPMethod {
		switch self {
		case .getJejuStory:
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
