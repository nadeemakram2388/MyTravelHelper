//
//  NetworkResponseExtension.swift
//  MyTravelHelper
//
//  Created by nadeem akram on 9/19/21.
//  Copyright © 2021 Sample. All rights reserved.
//

import Foundation
extension URLResponse {
    var isSuccess: Bool {
        return httpStatusCode >= 200 && httpStatusCode < 300
    }
    
    var httpStatusCode: Int {
        guard let statusCode = (self as? HTTPURLResponse)?.statusCode else {
            return 0
        }
        return statusCode
    }
}
