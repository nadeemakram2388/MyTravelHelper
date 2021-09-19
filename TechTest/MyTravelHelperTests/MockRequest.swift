//
//  MockRequest.swift
//  MyTravelHelperTests
//
//  Created by nadeem akram on 9/19/21.
//  Copyright © 2021 Sample. All rights reserved.
//

import Foundation
@testable import MyTravelHelper

typealias Completion = (Data?, URLResponse?, Error?) -> Void

enum MockRequest {
    case getAllStationsXML
    case getStationDataByCodeXML(stationCode: String)
    case getTrainMovementsXML(trainId: String, trainDate: String)
}


extension MockRequest {
    //Identify request based on endpoint
    static func identifyRequest(request: URLRequest) -> MockRequest? {
        if request.url?.absoluteString.contains(NetworkAPI.getAllStationsXML.path) == true {
            return getAllStationsXML
        } else if request.url?.absoluteString.contains(NetworkAPI.getStationDataByCodeXML(stationCode: "BFSTC").path ) == true {
            return getStationDataByCodeXML(stationCode: "BFSTC")
        } else if request.url?.absoluteString.contains(NetworkAPI.getTrainMovementsXML(trainId: "A141", trainDate: "20/09/2021").path) == true {
            return getTrainMovementsXML(trainId: "A141", trainDate: "20/09/2021")
        }
        return nil
    }

    //Return success response
    func completionHandler(request: URLRequest, completion: Completion) {
        guard let method = request.httpMethod, let httpMethod = HTTPMethod(rawValue: method) else {
            fatalError("Unknown HTTPMethod Used.")
        }
        
        switch (self, httpMethod) {
        case (.getAllStationsXML, .get):
            getAllStationsXML(request: request, statusCode: 200, completion: completion)
        case (.getStationDataByCodeXML, .get):
            getStationDataByCodeXML(request: request, statusCode: 200, completion: completion)
        case (.getTrainMovementsXML, .get):
            getTrainMovementsXML(request: request, statusCode: 200, completion: completion)

        default:
            fatalError("Request not handled yet.")
        }
    }
    
    //Return error response
    func badCompletionHandler(request: URLRequest, completion: Completion) {
        guard let method = request.httpMethod, let httpMethod = HTTPMethod(rawValue: method) else {
            fatalError("Unknown HTTPMethod Used.")
        }
        
        switch (self, httpMethod) {
        case (.getAllStationsXML, .get):
            getBadItems(request: request, statusCode: 400, completion: completion)
        case (.getStationDataByCodeXML, .get):
            getBadItems(request: request, statusCode: 400, completion: completion)
        case (.getTrainMovementsXML, .get):
            getBadItems(request: request, statusCode: 400, completion: completion)

        default:
            fatalError("Request not handled yet.")
        }
    }
    
    // MARK: - Helper Functions
    private func getAllStationsXML(request: URLRequest, statusCode: Int, completion: Completion) {
        let data = MockItem.getAllStationsXMLString.data(using: .utf8)
        let response = HTTPURLResponse(url: request.url!, statusCode: statusCode, httpVersion: nil, headerFields: nil)
        completion(data, response, nil)
    }
    
    private func getStationDataByCodeXML(request: URLRequest, statusCode: Int, completion: Completion) {
        let data = MockItem.getStationDataByCodeXMLString.data(using: .utf8)
        let response = HTTPURLResponse(url: request.url!, statusCode: statusCode, httpVersion: nil, headerFields: nil)
        completion(data, response, nil)
    }

    private func getTrainMovementsXML(request: URLRequest, statusCode: Int, completion: Completion) {
        let data = MockItem.getTrainMovementsXMLString.data(using: .utf8)
        let response = HTTPURLResponse(url: request.url!, statusCode: statusCode, httpVersion: nil, headerFields: nil)
        completion(data, response, nil)
    }

    private func getBadItems(request: URLRequest, statusCode: Int, completion: Completion) {
        let response = HTTPURLResponse(url: request.url!, statusCode: statusCode, httpVersion: nil, headerFields: nil)
        completion(nil, response, NetworkError("Server not reachable."))
    }
    }
