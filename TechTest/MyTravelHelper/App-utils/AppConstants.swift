//
//  AppConstants.swift
//  MyTravelHelper
//
//  Created by Satish on 11/03/19.
//  Copyright © 2019 Sample. All rights reserved.
//

import Foundation

let PROGRESS_INDICATOR_VIEW_TAG: Int = 10

struct AppConstants {
    
}

enum AppText {
    case internetIssue
    case okay
    case noInternet
    case loadingStation
    case pleaseWait
    case noTrain
    case noTrainArrivingIn90min
    case noTrainFromSourceDestiIn90min
    case invalidSourceDesti
    case validationSourceDesti
    case somthingWentWrong

    var string: String {
        switch self {
        case .internetIssue:
            return "Common.internetIssue".localized()
        case .okay:
            return "Common.Okay".localized()
        case .noInternet:
            return "Common.noInternet".localized()
        case .loadingStation:
            return "Common.loadingStation".localized()
        case .pleaseWait:
            return "Common.pleasewait".localized()
        case .noTrain:
            return "SearchTrain.noTrain".localized()
        case .noTrainArrivingIn90min:
            return "SearchTrain.noTrainArrivingIn90min".localized()
        case .noTrainFromSourceDestiIn90min:
            return "SearchTrain.noTrainFromSourceDestiIn90min".localized()
        case .invalidSourceDesti:
            return "SearchTrain.invalidSourceDesti".localized()
        case .validationSourceDesti:
            return "SearchTrain.validationSourceDesti".localized()
        case .somthingWentWrong:
            return "Somthing went wrong!".localized()

        }
    }
}
