//
//  MockItem.swift
//  MyTravelHelperTests
//
//  Created by nadeem akram on 9/19/21.
//  Copyright © 2021 Sample. All rights reserved.
//

import Foundation

@testable import MyTravelHelper

//BadMockSession will always return error or nil response
class BadMockNetworkSession: NetworkSessionProtocol {
    func dataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> NetworkDataTaskProtocol {
        
        if let mockRequest =  MockRequest.identifyRequest(request: request) {
            mockRequest.badCompletionHandler(request: request, completion: completionHandler)
        }
        
        return MockNetworkDataTask()
    }
}
