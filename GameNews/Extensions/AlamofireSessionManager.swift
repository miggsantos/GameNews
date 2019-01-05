//
//  AlamofireSessionManager.swift
//  GameNews
//
//  Created by Miguel Santos on 09/11/2017.
//  Copyright © 2017 Miguel Santos. All rights reserved.
//

import Alamofire

extension Alamofire.SessionManager{
    
    @discardableResult
    open func requestWithCacheOrLoad(
        _ url: URLConvertible,
        method: HTTPMethod = .get,
        parameters: Parameters? = nil,
        encoding: ParameterEncoding = URLEncoding.default,
        headers: HTTPHeaders? = nil)
        -> DataRequest
    {
        do {
            var urlRequest = try URLRequest(url: url, method: method, headers: headers)
            urlRequest.cachePolicy = .returnCacheDataElseLoad
            let encodedURLRequest = try encoding.encode(urlRequest, with: parameters)
            return request(encodedURLRequest)
        } catch {
            print(error)
            return request(URLRequest(url: URL(string: "http://example.com/wrong_request")!))
        }
    }
}
