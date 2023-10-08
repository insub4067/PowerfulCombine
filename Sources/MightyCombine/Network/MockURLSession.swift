//
//  MockURLSession.swift
//
//
//  Created by 김인섭 on 10/5/23.
//

import Foundation
import Combine

public struct MockURLSession: URLSessionable {
    
    
    var response: HTTPURLResponse?
    
    public init(response: HTTPURLResponse? = nil) {
        self.response = response
    }
    
    public func request<T>(_ urlRequest: URLRequest, scheduler: DispatchQueue = DispatchQueue.main) -> AnyPublisher<T, Error> where T : Decodable {
        Empty()
            .receive(on: scheduler)
            .eraseToAnyPublisher()
    }
    
    public func request<T>(_ urlRequest: URLRequest, scheduler: DispatchQueue = DispatchQueue.main, responseHandler: @escaping (HTTPURLResponse) throws -> Void) -> AnyPublisher<T, Error> where T : Decodable {
        guard let response else { return Empty().eraseToAnyPublisher() }
        
        do {
            try responseHandler(response)
            return Empty()
                .receive(on: scheduler)
                .eraseToAnyPublisher()
        } catch let error {
            return Fail(error: error)
                .receive(on: scheduler)
                .eraseToAnyPublisher()
        }
    }
}
