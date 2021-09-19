//
//  SearchTrainProtocols.swift
//  MyTravelHelper
//
//  Created by Satish on 11/03/19.
//  Copyright © 2019 Sample. All rights reserved.
//

import UIKit

protocol ViewToPresenterProtocol: AnyObject {
    var view: PresenterToViewProtocol? {get set}
    var interactor: PresenterToInteractorProtocol? {get set}
    var router: PresenterToRouterProtocol? {get set}
    func fetchallStations()
    func searchTapped(source:String,destination:String)
    func updateFavorite(station: StationName)
}

protocol PresenterToViewProtocol: AnyObject {
    func saveFetchedStations(stations:[StationName]?)
    func showInvalidSourceOrDestinationAlert()
    func updateLatestTrainList(trainsList: [StationTrain])
    func showNoTrainsFoundAlert()
    func showNoTrainAvailbilityFromSource()
    func showNoInterNetAvailabilityMessage()
}

protocol PresenterToRouterProtocol: AnyObject {
    static func createModule()-> SearchTrainViewController?
}

protocol PresenterToInteractorProtocol: AnyObject {
    var presenter:InteractorToPresenterProtocol? {get set}
    func fetchallStations()
    func fetchTrainsFromSource(sourceCode:String,destinationCode:String)
    func updateFavorite(station: StationName)
}

protocol InteractorToPresenterProtocol: AnyObject {
    var stations: [StationName] {get set}
    var trains: [StationTrain]? {get set}
    func stationListFetched(list:[StationName])
    func fetchedTrainsList(trainsList:[StationTrain]?)
    func showNoTrainAvailbilityFromSource()
    func showNoInterNetAvailabilityMessage()
}
