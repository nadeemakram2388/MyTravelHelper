//
//  NetworkRequestProtocol.swift
//  MyTravelHelper
//
//  Created by nadeem akram on 9/19/21.
//  Copyright © 2021 Sample. All rights reserved.
//

import Foundation

public typealias HTTPHeaders = [String: String]

protocol NetworkRequestProtocol {
    var baseURL: URL { get }
    var path: String { get }
    var httpMethod: HTTPMethod { get }
    var httpBody: Data? { get }
    var headers: HTTPHeaders? { get }
}
