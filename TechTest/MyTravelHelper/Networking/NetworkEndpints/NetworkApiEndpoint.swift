//
//  NetworkApiEndpoint.swift
//  MyTravelHelper
//
//  Created by nadeem akram on 9/19/21.
//  Copyright © 2021 Sample. All rights reserved.
//

import Foundation
//Item APIs
enum NetworkAPI {
    case getAllStationsXML
    case getStationDataByCodeXML(stationCode: String)
    case getTrainMovementsXML(trainId: String, trainDate: String)

}

extension NetworkAPI: NetworkRequestProtocol {
    //Set Base URL
    var baseURL: URL {
        guard let url = URL(string: AppConstants.Service.baseURL) else {
            fatalError("BaseURL could not be configured.")
        }
        return url
    }
    
    //Returns EndPoint for Item APIs
    var path: String {
        switch self {
        case .getAllStationsXML:
            return "getAllStationsXML"
        case .getStationDataByCodeXML(let stationCode):
            return "getStationDataByCodeXML?StationCode=\(stationCode)"
        case .getTrainMovementsXML(let trainId, let trainDate):
            return "getTrainMovementsXML?TrainId=\(trainId)&TrainDate=\(trainDate)"

        }
    }
    
    //Returns HTTP Method for Item APIs
    var httpMethod: HTTPMethod {
        switch self {
        case .getAllStationsXML, .getStationDataByCodeXML( _), .getTrainMovementsXML( _,  _):
            return .get
        }
    }
    
    //Encode and Returns Encoded Data
    var httpBody: Data? {
        return nil
    }
    
    //Return Item APIs Specific Headers
    var headers: HTTPHeaders? {
        return nil
    }
}
