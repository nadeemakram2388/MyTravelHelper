//
//  ServerError.swift
//  MyTravelHelper
//
//  Created by nadeem akram on 9/19/21.
//  Copyright © 2021 Sample. All rights reserved.
//

import Foundation
struct ServerError: Decodable {
    let status: String?
    let error: String?
}
