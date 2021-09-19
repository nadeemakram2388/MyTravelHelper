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
    
    private var httpClient: NetworkClient!
    init(client: NetworkClient? = nil) {
        self.httpClient = client ?? NetworkClient.shared
    }

    func fetchallStations() {
        if Reach().isNetworkReachable() == true {
            httpClient.dataTask(NetworkAPI.getAllStationsXML) { [weak self] (result) in
                guard let self = self else { return }
                switch result {
                case .success(let data):
                    guard let data = data else { return }
                    do {
                        let station = try XMLDecoder().decode(Stations.self, from: data)
                        self.presenter!.stationListFetched(list: station.stationsList)
                    } catch (let error) {
                        print("Data could not loaded")
                        print(error.localizedDescription)
                        DispatchQueue.main.async {
                            self.presenter!.stationListFetched(list: [])
                        }
                    }
                case .failure(let error):
                    let _ = NetworkError(error.localizedDescription)
                }

            }
        } else {
            self.presenter!.showNoInterNetAvailabilityMessage()
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
                            self.presenter!.showNoTrainAvailbilityFromSource()
                        }
                    }
                case .failure(let error):
                    self.presenter!.showNoTrainAvailbilityFromSource()
                }
            }
        } else {
            self.presenter!.showNoInterNetAvailabilityMessage()
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
                            let trainMovements = try? XMLDecoder().decode(TrainMovementsData.self, from: data)

                            if let _movements = trainMovements?.trainMovements {
                                let sourceIndex = _movements.firstIndex(where: {$0.locationCode.caseInsensitiveCompare(self._sourceStationCode) == .orderedSame})
                                let destinationIndex = _movements.firstIndex(where: {$0.locationCode.caseInsensitiveCompare(self._destinationStationCode) == .orderedSame})
                                let desiredStationMoment = _movements.filter{$0.locationCode.caseInsensitiveCompare(self._destinationStationCode) == .orderedSame}
                                let isDestinationAvailable = desiredStationMoment.count == 1

                                if isDestinationAvailable  && sourceIndex! < destinationIndex! {
                                    _trainsList[index].destinationDetails = desiredStationMoment.first
                                }
                            }
                        } catch {
                            print("Data could not loaded")
                        }
                    case .failure(let error):
                        let _ = NetworkError(error.localizedDescription)
                    }
                }
            } else {
                self.presenter!.showNoInterNetAvailabilityMessage()
            }
        }

        group.notify(queue: DispatchQueue.main) {
            let sourceToDestinationTrains = _trainsList.filter{$0.destinationDetails != nil}
            self.presenter!.fetchedTrainsList(trainsList: sourceToDestinationTrains)
        }
    }
}
