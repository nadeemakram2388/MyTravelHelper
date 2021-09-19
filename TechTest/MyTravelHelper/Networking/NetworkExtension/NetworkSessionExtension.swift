//
//  NetworkSessionExtension.swift
//  MyTravelHelper
//
//  Created by nadeem akram on 9/19/21.
//  Copyright © 2021 Sample. All rights reserved.
//

import Foundation
extension URLSession: NetworkSessionProtocol {
    func dataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> NetworkDataTaskProtocol {
        let task = dataTask(with: request, completionHandler: completionHandler) as URLSessionDataTask
        return task as NetworkDataTaskProtocol
    }
}
