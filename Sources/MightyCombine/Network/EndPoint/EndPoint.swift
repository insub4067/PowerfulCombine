//
//  EndPoint.swift
//
//
//  Created by 김인섭 on 10/7/23.
//

import Foundation
import MightySwift
import Combine

public struct EndPoint: EndPointable {

    public let baseURL: String
    public var paths: [String]?
    public var queries: [String: String]?
    public var headers: [String: String]?
    public var body: [String: Any]?
    public var method: HttpMethod
    public var responseHandler: ((_ response: HTTPURLResponse) throws -> Void)?
    public var session: URLSessionable?
    public var logStyle: LogStyle
    
    public init(
        _ baseURL: String,
        paths: [String]? = nil,
        queries: [String: String]? = nil,
        headers: [String: String]? = nil,
        body: [String: Any]? = nil,
        method: HttpMethod = .get,
        responseHandler: ((_ response: HTTPURLResponse) throws -> Void)? = nil,
        session: URLSessionable? = nil
    ) {
        self.baseURL = baseURL
        self.paths = paths
        self.queries = queries
        self.headers = headers
        self.body = body
        self.method = method
        self.responseHandler = responseHandler
        self.session = session
        self.logStyle = URLSession.logStyle
    }
    
    public var urlRequest: URLRequest {
        .init(baseURL)
        .urlPaths(paths)
        .urlQueries(queries)
        .httpHeaders(headers)
        .httpBody(body)
        .httpMethod(method)
    }
}
