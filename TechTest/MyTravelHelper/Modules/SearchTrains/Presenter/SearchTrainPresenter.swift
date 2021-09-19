//
//  SearchTrainPresenter.swift
//  MyTravelHelper
//
//  Created by Satish on 11/03/19.
//  Copyright © 2019 Sample. All rights reserved.
//

import UIKit

class SearchTrainPresenter:ViewToPresenterProtocol {
    var stations :[StationName] = [StationName]()
    var trains: [StationTrain]?

    func searchTapped(source: String, destination: String) {
        let sourceStationCode = getStationCode(stationName: source)
        let destinationStationCode = getStationCode(stationName: destination)
        interactor?.fetchTrainsFromSource(sourceCode: sourceStationCode, destinationCode: destinationStationCode)
    }
    
    var interactor: PresenterToInteractorProtocol?
    var router: PresenterToRouterProtocol?
    var view: PresenterToViewProtocol?

    func fetchallStations() {
        interactor?.fetchallStations()
    }

    private func getStationCode(stationName: String) -> String {
        return stations.filter{$0.stationDesc == stationName}.first?.stationCode?.lowercased() ?? ""
    }
}

extension SearchTrainPresenter: InteractorToPresenterProtocol {
    
    func showNoInterNetAvailabilityMessage() {
        view?.showNoInterNetAvailabilityMessage()
    }

    func showNoTrainAvailbilityFromSource() {
        view?.showNoTrainAvailbilityFromSource()
    }

    func fetchedTrainsList(trainsList: [StationTrain]?) {
        if let _trainsList = trainsList {
            view?.updateLatestTrainList(trainsList: _trainsList)
        }else {
            view?.showNoTrainsFoundAlert()
        }
    }
    
    func stationListFetched(list: [StationName]) {
        stations = list
        view?.saveFetchedStations(stations: list)
    }
    
    func updateFavorite(station: StationName) {
        interactor?.updateFavorite(station: station)
    }
}
