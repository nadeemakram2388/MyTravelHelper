//
//  SearchTrainInteractor.swift
//  MyTravelHelper
//
//  Created by Satish on 11/03/19.
//  Copyright © 2019 Sample. All rights reserved.
//

import Foundation
import XMLParsing

class SearchTrainInteractor: PresenterToInteractorProtocol {
    var _sourceStationCode = String()
    var _destinationStationCode = String()
    var presenter: InteractorToPresenterProtocol?
    let coreDataManager = CoreDataManager.shared()

    private var httpClient: NetworkClient!
    init(client: NetworkClient? = nil) {
        self.httpClient = client ?? NetworkClient.shared
    }

    func fetchallStations() {
        let stations = self.fetchStationsFromDB()
        if stations.count > 0 {
            self.presenter!.stationListFetched(list: stations)
        } else {
            if Reach().isNetworkReachable() == true {
                httpClient.dataTask(NetworkAPI.getAllStationsXML) { [weak self] (result) in
                    guard let self = self else { return }
                    switch result {
                    case .success(let data):
                        guard let data = data else { return }
                        do {
                            let station = try XMLDecoder().decode(Stations.self, from: data)
                            let savedStations = self.saveStationToDB(stations: station.stationsList)
                            self.presenter?.stationListFetched(list: savedStations)
                        } catch (let error) {
                            print("Data could not loaded")
                            print(error.localizedDescription)
                            DispatchQueue.main.async {
                                self.presenter?.stationListFetched(list: [])
                            }
                        }
                    case .failure(let error):
                        let _ = NetworkError(error.localizedDescription)
                    }

                }
            } else {
                self.presenter?.showNoInterNetAvailabilityMessage()
            }
        }
    }

    func fetchTrainsFromSource(sourceCode: String, destinationCode: String) {
        _sourceStationCode = sourceCode
        _destinationStationCode = destinationCode
        if Reach().isNetworkReachable() {
            httpClient.dataTask(NetworkAPI.getStationDataByCodeXML(stationCode: sourceCode)) { [weak self] (result) in
                guard let self = self else { return }
                switch result {
                case .success(let data):
                    guard let data = data else { return }
                    do {
                        let stationData = try XMLDecoder().decode(StationData.self, from: data)
                        let _trainsList = stationData.trainsList
                        self.proceesTrainListforDestinationCheck(trainsList: _trainsList)
                    } catch (let error) {
                        print(error.localizedDescription)
                        DispatchQueue.main.async {
                            self.presenter?.showNoTrainAvailbilityFromSource()
                        }
                    }
                case .failure( _):
                    self.presenter?.showNoTrainAvailbilityFromSource()
                }
            }
        } else {
            self.presenter?.showNoInterNetAvailabilityMessage()
        }
    }
    
    private func proceesTrainListforDestinationCheck(trainsList: [StationTrain]) {
        var _trainsList = trainsList
        let today = Date()
        let group = DispatchGroup()
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        let dateString = formatter.string(from: today)
        
        for index  in 0...trainsList.count-1 {
            group.enter()
            if Reach().isNetworkReachable() {
                httpClient.dataTask(NetworkAPI.getTrainMovementsXML(trainId: trainsList[index].trainCode, trainDate: dateString)) { [weak self] (result) in
                    
                    group.leave()
                    guard let self = self else { return }
                    switch result {
                    case .success(let data):
                        guard let data = data else { return }
                        do {
                            let trainMovements = try XMLDecoder().decode(TrainMovementsData.self, from: data)
                            let _movements = trainMovements.trainMovements
                            let sourceIndex = _movements.firstIndex(where: {$0.locationCode.caseInsensitiveCompare(self._sourceStationCode) == .orderedSame})
                            let destinationIndex = _movements.firstIndex(where: {$0.locationCode.caseInsensitiveCompare(self._destinationStationCode) == .orderedSame})
                            let desiredStationMoment = _movements.filter{$0.locationCode.caseInsensitiveCompare(self._destinationStationCode) == .orderedSame}
                            let isDestinationAvailable = desiredStationMoment.count == 1

                            guard let sIndex = sourceIndex,
                                  let dIndex = destinationIndex,
                                  isDestinationAvailable  && sIndex < dIndex else { return }
                            _trainsList[index].destinationDetails = desiredStationMoment.first
                        } catch ( _) {
                            print("Data could not loaded")
                        }
                    case .failure(let error):
                        let _ = NetworkError(error.localizedDescription)
                    }
                }
            } else {
                self.presenter?.showNoInterNetAvailabilityMessage()
            }
        }

        group.notify(queue: DispatchQueue.main) {
            let sourceToDestinationTrains = _trainsList.filter{$0.destinationDetails != nil}
            self.presenter?.fetchedTrainsList(trainsList: sourceToDestinationTrains)
        }
    }
}
//MARK: Fetch/Save
extension SearchTrainInteractor {
    private func saveStationToDB(stations: [Station]) -> [StationName] {
        return self.coreDataManager.saveStations(stations)
    }
    private func fetchStationsFromDB() -> [StationName] {
        return coreDataManager.getStations()
    }
}

//MARK: Fetch/Save
extension SearchTrainInteractor {
    func updateFavorite(station: StationName) {
        station.favorite = !station.favorite
        coreDataManager.saveData()
    }
}
