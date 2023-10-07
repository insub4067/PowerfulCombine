//
//  AnyPublisher+Test.swift
//  
//
//  Created by 김인섭 on 10/6/23.
//

import XCTest
import Combine
@testable import MightyCombine
@testable import TestSource

final class AnyPublisher_Test: XCTestCase {
    
    var store = Set<AnyCancellable>()

    func test_func_mock() throws {
        
        let expectInt = 123
        
        Empty<Int, Error>()
            .eraseToAnyPublisher()
            .mock(.success(expectInt))
            .receive(on: DispatchQueue.main)
            .sink { completion in
                XCTAssertNil(completion.error)
            } receiveValue: { result in
                XCTAssertEqual(result, expectInt)
            }.store(in: &store)

        let expectError = TestError.testError
        
        Empty<Int, TestError>()
            .eraseToAnyPublisher()
            .mock(.fail(expectError))
            .receive(on: DispatchQueue.main)
            .sink { completion in
                XCTAssertNotNil(completion.error as? TestError)
                if let error = completion.error as? TestError {
                    XCTAssertEqual(error, expectError)
                }
            } receiveValue: { _ in
                
            }.store(in: &store)

    }
}
