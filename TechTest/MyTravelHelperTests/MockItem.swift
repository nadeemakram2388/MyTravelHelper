//
//  MockItem.swift
//  MyTravelHelperTests
//
//  Created by nadeem akram on 9/19/21.
//  Copyright © 2021 Sample. All rights reserved.
//

import Foundation
struct MockItem {
    static let getAllStationsXMLString =
    """
        <ArrayOfObjStation xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns="http://api.irishrail.ie/realtime/">
        <objStation>
        <StationDesc>Belfast</StationDesc>
        <StationAlias/>
        <StationLatitude>54.6123</StationLatitude>
        <StationLongitude>-5.91744</StationLongitude>
        <StationCode>BFSTC</StationCode>
        <StationId>228</StationId>
        </objStation>
        <objStation>
        <StationDesc>Lisburn</StationDesc>
        <StationAlias/>
        <StationLatitude>54.514</StationLatitude>
        <StationLongitude>-6.04327</StationLongitude>
        <StationCode>LBURN</StationCode>
        <StationId>238</StationId>
        </objStation>
        <objStation>
        <StationDesc>Lurgan</StationDesc>
        <StationAlias/>
        <StationLatitude>54.4672</StationLatitude>
        <StationLongitude>-6.33547</StationLongitude>
        <StationCode>LURGN</StationCode>
        <StationId>241</StationId>
        </objStation>
        <objStation>
        <StationDesc>Portadown</StationDesc>
        <StationAlias/>
        <StationLatitude>54.4295</StationLatitude>
        <StationLongitude>-6.43868</StationLongitude>
        <StationCode>PDOWN</StationCode>
        <StationId>242</StationId>
        </objStation>
        <objStation>
        <StationDesc>Sligo</StationDesc>
        <StationAlias/>
        <StationLatitude>54.2723</StationLatitude>
        <StationLongitude>-8.48249</StationLongitude>
        <StationCode>SLIGO</StationCode>
        <StationId>180</StationId>
        </objStation>
        </ArrayOfObjStation>
    """
    
    static let getStationDataByCodeXMLString =
        """
        <ArrayOfObjStationData xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns="http://api.irishrail.ie/realtime/">
        <objStationData>
        <Servertime>2021-07-04T07:47:24.91</Servertime>
        <Traincode>A141 </Traincode>
        <Stationfullname>Belfast</Stationfullname>
        <Stationcode>BFSTC</Stationcode>
        <Querytime>07:47:24</Querytime>
        <Traindate>20 Sep 2021</Traindate>
        <Origin>Belfast</Origin>
        <Destination>Dublin Connolly</Destination>
        <Origintime>09:00</Origintime>
        <Destinationtime>11:20</Destinationtime>
        <Status>No Information</Status>
        <Lastlocation/>
        <Duein>73</Duein>
        <Late>0</Late>
        <Exparrival>00:00</Exparrival>
        <Expdepart>09:00</Expdepart>
        <Scharrival>00:00</Scharrival>
        <Schdepart>09:00</Schdepart>
        <Direction>Southbound</Direction>
        <Traintype>DD/90</Traintype>
        <Locationtype>O</Locationtype>
        </objStationData>
        </ArrayOfObjStationData>
        """
    
    static let getTrainMovementsXMLString =
        """
        <ArrayOfObjTrainMovements xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns="http://api.irishrail.ie/realtime/">
        <objTrainMovements>
        <TrainCode>A141 </TrainCode>
        <TrainDate>20 Sep 2021</TrainDate>
        <LocationCode>BFSTC</LocationCode>
        <LocationFullName>Belfast</LocationFullName>
        <LocationOrder>1</LocationOrder>
        <LocationType>O</LocationType>
        <TrainOrigin>Belfast</TrainOrigin>
        <TrainDestination>Dublin Connolly</TrainDestination>
        <ScheduledArrival>00:00:00</ScheduledArrival>
        <ScheduledDeparture>09:00:00</ScheduledDeparture>
        <ExpectedArrival>00:00:00</ExpectedArrival>
        <ExpectedDeparture>09:00:00</ExpectedDeparture>
        <Arrival/>
        <Departure/>
        <AutoArrival/>
        <AutoDepart/>
        <StopType>C</StopType>
        </objTrainMovements>
        <objTrainMovements>
        <TrainCode>A141 </TrainCode>
        <TrainDate>20 Sep 2021</TrainDate>
        <LocationCode>LBURN</LocationCode>
        <LocationFullName>Lisburn</LocationFullName>
        <LocationOrder>2</LocationOrder>
        <LocationType>S</LocationType>
        <TrainOrigin>Belfast</TrainOrigin>
        <TrainDestination>Dublin Connolly</TrainDestination>
        <ScheduledArrival>09:13:00</ScheduledArrival>
        <ScheduledDeparture>09:15:00</ScheduledDeparture>
        <ExpectedArrival>09:13:00</ExpectedArrival>
        <ExpectedDeparture>09:15:00</ExpectedDeparture>
        <Arrival/>
        <Departure/>
        <AutoArrival/>
        <AutoDepart/>
        <StopType>N</StopType>
        </objTrainMovements>
        <objTrainMovements>
        <TrainCode>A141 </TrainCode>
        <TrainDate>20 Sep 2021</TrainDate>
        <LocationCode>LURGN</LocationCode>
        <LocationFullName>Lurgan</LocationFullName>
        <LocationOrder>3</LocationOrder>
        <LocationType>S</LocationType>
        <TrainOrigin>Belfast</TrainOrigin>
        <TrainDestination>Dublin Connolly</TrainDestination>
        <ScheduledArrival>09:31:00</ScheduledArrival>
        <ScheduledDeparture>09:33:00</ScheduledDeparture>
        <ExpectedArrival>09:31:00</ExpectedArrival>
        <ExpectedDeparture>09:33:00</ExpectedDeparture>
        <Arrival/>
        <Departure/>
        <AutoArrival/>
        <AutoDepart/>
        <StopType>-</StopType>
        </objTrainMovements>
        </ArrayOfObjTrainMovements>
        """

}
