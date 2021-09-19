//
//  CoreDataHelper.swift
//  MyTravelHelper
//
//  Created by nadeem akram on 9/19/21.
//  Copyright © 2021 Sample. All rights reserved.
//

import Foundation
import CoreData

class CoreDataHelper: NSObject {
    
    private override init() {
        super.init()
        applicationLibraryDirectory()
    }
    static let _shared = CoreDataHelper()
    class func shared() -> CoreDataHelper {
        return _shared
    }
    private lazy var applicationDocumentsDirectory: URL = {
        let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        print(urls[urls.count-1])
        return urls[urls.count-1]
    }()
    
    private func applicationLibraryDirectory() {
        print(applicationDocumentsDirectory)
        if let url = FileManager.default.urls(for: .libraryDirectory, in: .userDomainMask).last {
            print(url.absoluteString)
        }
    }
    // MARK: - Core Data stack
    lazy var managedObjectContext = {
        return self.persistentContainer.viewContext
    }()
    // Persistent Container
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "MyTravelHelper")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // Save the data in Database
    func saveData(){
        let context = self.managedObjectContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}

extension CoreDataHelper {
    
    func saveStations(_ stations: [Station]) -> [StationName] {
        let arr = stations.compactMap{self.createEntityFrom(station: $0)}
        saveData()
        return arr
    }
    
    private func createEntityFrom(station: Station) -> StationName? {
        // Convert
        let stationName = StationName(context: self.managedObjectContext)
        stationName.stationId = Int16(station.stationId)
        stationName.stationDesc = station.stationDesc
        stationName.stationCode = station.stationCode
        stationName.stationLatitude = station.stationLatitude
        stationName.stationLongitude = station.stationLongitude
        return stationName
    }
    
    func getStations() -> [StationName] {
        do {
            let results  = try managedObjectContext.fetch(StationName.fetchRequest()) as? [StationName]
            return results ?? []
        } catch let error as NSError {
            print("Could not fetch \(error)")
            return []
        }
    }
    
}
