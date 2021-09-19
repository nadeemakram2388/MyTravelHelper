//
//  SearchTrainViewController.swift
//  MyTravelHelper
//
//  Created by Satish on 11/03/19.
//  Copyright © 2019 Sample. All rights reserved.
//

import UIKit
import SwiftSpinner
import DropDown

class SearchTrainViewController: UIViewController {
    @IBOutlet weak var destinationTextField: CustomTextField!
    @IBOutlet weak var sourceTxtField: CustomTextField!
    @IBOutlet weak var trainsListTable: UITableView!

    var stationsList:[StationName] = [StationName]()
    var trains:[StationTrain] = [StationTrain]()
    var presenter:ViewToPresenterProtocol?
    //var dropDown = DropDown()
    var transitPoints:(source:String, destination:String) = ("","")
    var searchMode = true

    override func viewDidLoad() {
        super.viewDidLoad()
        sourceTxtField.inputView = UIView()
        destinationTextField.inputView = UIView()
        trainsListTable.tableFooterView = UIView(frame: .zero)

    }

    override func viewWillAppear(_ animated: Bool) {
        if stationsList.count == 0 {
            SwiftSpinner.useContainerView(view)
            SwiftSpinner.show(AppText.loadingStation.string)
            presenter?.fetchallStations()
        }
    }

    @IBAction func searchTrainsTapped(_ sender: Any) {
        view.endEditing(true)
        self.searchMode = true
        self.sourceTxtField.backgroundColor = UIColor.clear
        self.destinationTextField.backgroundColor = UIColor.clear
        showProgressIndicator(view: self.view)
        presenter?.searchTapped(source: transitPoints.source, destination: transitPoints.destination)
    }
}

extension SearchTrainViewController:PresenterToViewProtocol {
    func showNoInterNetAvailabilityMessage() {
        trainsListTable.isHidden = true
        hideProgressIndicator(view: self.view)
        showAlert(title: AppText.noInternet.string, message: AppText.internetIssue.string, actionTitle: AppText.okay.string)
    }

    func showNoTrainAvailbilityFromSource() {
        trainsListTable.isHidden = true
        hideProgressIndicator(view: self.view)
        showAlert(title: AppText.noTrain.string, message: AppText.noTrainArrivingIn90min.string, actionTitle: AppText.okay.string)
    }

    func updateLatestTrainList(trainsList: [StationTrain]) {
        hideProgressIndicator(view: self.view)
        trains = trainsList
        trainsListTable.isHidden = false
        trainsListTable.reloadData()
    }

    func showNoTrainsFoundAlert() {
        trainsListTable.isHidden = true
        hideProgressIndicator(view: self.view)
        trainsListTable.isHidden = true
        showAlert(title: AppText.noTrain.string, message: AppText.noTrainFromSourceDestiIn90min.string, actionTitle: AppText.okay.string)
    }

    func showAlert(title:String,message:String,actionTitle:String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: actionTitle, style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }

    func showInvalidSourceOrDestinationAlert() {
        trainsListTable.isHidden = true
        hideProgressIndicator(view: self.view)
        showAlert(title: AppText.invalidSourceDesti.string, message: AppText.validationSourceDesti.string, actionTitle: AppText.okay.string)
    }

    func saveFetchedStations(stations: [StationName]?) {
        if let _stations = stations {
          self.stationsList = _stations
            let arr1 = self.stationsList.filter( { $0.favorite })
            let arr2 = self.stationsList.filter( { !$0.favorite })
            self.stationsList = arr1 + arr2
        }
        self.trainsListTable.reloadData()
        SwiftSpinner.hide()
    }
}

extension SearchTrainViewController:UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == sourceTxtField {
            self.sourceTxtField.backgroundColor = UIColor.lightGray.withAlphaComponent(0.2)
            self.destinationTextField.backgroundColor = UIColor.clear
        } else if textField == destinationTextField {
            self.destinationTextField.backgroundColor = UIColor.lightGray.withAlphaComponent(0.2)
            self.sourceTxtField.backgroundColor = UIColor.clear
        }
        self.trainsListTable.isHidden = false
        self.searchMode = false
        self.trainsListTable.reloadData()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return textField.resignFirstResponder()
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return true
    }
}

extension SearchTrainViewController:UITableViewDataSource,UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchMode ? trains.count : stationsList.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if searchMode {
            let cell = tableView.dequeueReusableCell(withIdentifier: TrainInfoCell.name, for: indexPath) as! TrainInfoCell
            let train = trains[indexPath.row]
            cell.configureFor(train: train)
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: StationListCell.name, for: indexPath) as! StationListCell
            let station = self.stationsList[indexPath.row]
            cell.configureFor(station: station)
            cell.delegate = self
            return cell
        }
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let station = self.stationsList[indexPath.row]
        if sourceTxtField.isFirstResponder {
            self.sourceTxtField.text = station.stationDesc
            self.transitPoints.source = station.stationCode ?? ""
            self.destinationTextField.becomeFirstResponder()
            
        } else if destinationTextField.isFirstResponder {
            self.destinationTextField.text = station.stationDesc
            self.transitPoints.destination = station.stationCode ?? ""
            self.destinationTextField.resignFirstResponder()
            self.sourceTxtField.backgroundColor = UIColor.clear
            self.destinationTextField.backgroundColor = UIColor.clear
        }
    }

}

//MARK: StationTableViewCellDelegate
extension SearchTrainViewController: StationListCellDelegate {
    func updateFavorite(_ station: StationName) {
        self.presenter?.updateFavorite(station: station)
        self.trainsListTable.reloadData()
    }}
