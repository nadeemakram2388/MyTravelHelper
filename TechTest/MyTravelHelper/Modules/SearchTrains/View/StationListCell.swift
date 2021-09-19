//
//  StationListCell.swift
//  MyTravelHelper
//
//  Created by nadeem akram on 9/19/21.
//  Copyright © 2021 Sample. All rights reserved.
//

import UIKit

protocol StationListCellDelegate: AnyObject {
    func updateFavorite(_ station: StationName)
}

class StationListCell: UITableViewCell {
    
    @IBOutlet weak var stationNameLabel: UILabel!
    @IBOutlet weak var stationCodeLabel: UILabel!
    @IBOutlet weak var favouriteButton: UIButton!
    
    weak var delegate: StationListCellDelegate?
    weak var station: StationName?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}

extension StationListCell {
    
    func configureFor(station: StationName) {
        self.station = station
        self.stationNameLabel.text = station.stationDesc
        self.stationCodeLabel.text = station.stationCode
        self.favouriteButton.isSelected = station.favorite
    }
    
    @IBAction func onTappedFaviroteBtn() {
        if let station = self.station {
            self.delegate?.updateFavorite(station)
        }
    }
}

