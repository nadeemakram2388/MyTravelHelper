//
//  SearchTrainInteractorTests.swift
//  MyTravelHelperTests
//
//  Created by nadeem akram on 9/19/21.
//  Copyright © 2021 Sample. All rights reserved.
//

import XCTest
@testable import MyTravelHelper

class SearchTrainInteractorTests: XCTestCase {

    var interactor: SearchTrainInteractor!
    var presenter = SearchTrainPresenterMock()
    var view = SearchTrainMockView()

    override func setUp() {
        let session = MockNetworkSession()
        let client = NetworkClient(session: session)
        interactor = SearchTrainInteractor(client: client)
        interactor.presenter = presenter
    }
    func testfetchallStations() {
        interactor.fetchallStations()
        XCTAssert((interactor.presenter?.stations.count ?? 0) > 0 , "failed to get station")
    }

    func testFetchTrainsFromSource() {
        let source = "BFSTC"
        let destination = "LBURN"
        let expectation = self.expectation(description: "trains")
        interactor.fetchTrainsFromSource(sourceCode: source, destinationCode: destination)
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            expectation.fulfill()
            XCTAssert((self.interactor.presenter?.trains?.count ?? 0) > 0 , "failed to get train")
        }
        waitForExpectations(timeout: 10, handler: nil)
    }

    override func tearDown() {
        interactor = nil
    }
    override func setUpWithError() throws {
    }

    override func tearDownWithError() throws {
    }

    func testExample() throws {
    }
}

class SearchTrainPresenterMock: InteractorToPresenterProtocol {
    var stations: [StationName] = []
    var trains:[StationTrain]?

    func stationListFetched(list:[StationName]) {
        self.stations = list
    }
    func fetchedTrainsList(trainsList:[StationTrain]?) {
        self.trains = trainsList
    }
    func showNoTrainAvailbilityFromSource() {
        
    }
    func showNoInterNetAvailabilityMessage() {
        
    }

}
