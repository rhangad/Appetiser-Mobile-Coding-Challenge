//
//  ApiService.swift
//  Appetiser Mobile Coding Challenge
//
//  Created by Dev Partners on 3/22/19.
//  Copyright © 2019 Dev Partners. All rights reserved.
//

import Foundation
import CoreData
import Alamofire

class ApiService {
    
    func getTrackList(_ fetchedResultsController: NSFetchedResultsController<Track>) {
        Alamofire.request("https://itunes.apple.com/search?term=star&amp;country=au&amp;media=movie", method: .get, encoding: JSONEncoding.default).responseJSON { response in
            if response.result.isSuccess {
                if let result = response.result.value {
                    let context = fetchedResultsController.managedObjectContext
                    let json = result as! [String:Any]
                    let jsonArray = json["results"] as! [[String:Any]]
                    
                    for jsonObject in jsonArray {
                        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Track")
                        let trackId = jsonObject["trackId"] as? NSNumber
                        if trackId != nil {
                            fetchRequest.predicate = NSPredicate(format: "trackId = '\(trackId!.stringValue)'")
                        }
                        let queryResult = try? context.fetch(fetchRequest)
                        // Update values if an entity already exists
                        if (queryResult?.count)! > 0 {
                            let updateTrack = queryResult![0] as! Track
                            updateTrack.setValue(jsonObject["artistName"] as? String, forKey: "artistName")
                            updateTrack.setValue(jsonObject["artworkUrl30"] as? String, forKey: "artworkUrl30")
                            updateTrack.setValue(jsonObject["artworkUrl100"] as? String, forKey: "artworkUrl100")
                            updateTrack.setValue(jsonObject["collectionName"] as? String, forKey: "collectionName")
                            updateTrack.setValue(jsonObject["country"] as? String, forKey: "country")
                            updateTrack.setValue(jsonObject["currency"] as? String, forKey: "currency")
                            updateTrack.setValue(jsonObject["primaryGenreName"] as? String, forKey: "primaryGenreName")
                            updateTrack.setValue(jsonObject["trackName"] as? String, forKey: "trackName")
                            updateTrack.setValue(jsonObject["longDescription"] as? String, forKey: "longDescription")
                            updateTrack.setValue(jsonObject["trackTimeMillis"] as? Double ?? 0, forKey: "trackTimeMillis")
                            let price = jsonObject["trackPrice"] as? NSNumber
                            updateTrack.setValue(price?.stringValue, forKey: "trackPrice")
                            let id = jsonObject["trackId"] as? NSNumber
                            updateTrack.setValue(id?.stringValue, forKey: "trackId")
                        }
                        // Create new entity if it doesn't exists
                        else {
                            let newTrack  = Track(context: context)
                            newTrack.artistName = jsonObject["artistName"] as? String
                            newTrack.artworkUrl30 = jsonObject["artworkUrl30"] as? String
                            newTrack.artworkUrl100 = jsonObject["artworkUrl100"] as? String
                            newTrack.collectionName = jsonObject["collectionName"] as? String
                            newTrack.country = jsonObject["country"] as? String
                            newTrack.currency = jsonObject["currency"] as? String
                            newTrack.primaryGenreName = jsonObject["primaryGenreName"] as? String
                            newTrack.trackName = jsonObject["trackName"] as? String
                            newTrack.longDescription = jsonObject["longDescription"] as? String
                            newTrack.trackTimeMillis = jsonObject["trackTimeMillis"] as? Double ?? 0
                            
                            let price = jsonObject["trackPrice"] as? NSNumber
                            newTrack.trackPrice = price?.stringValue
                            let id = jsonObject["trackId"] as? NSNumber
                            newTrack.trackId = id?.stringValue
                        }
                        
                        // Save the context.
                        do {
                            try context.save()
                        } catch {
                            
                            let nserror = error as NSError
                            print(nserror)
                        }
                    }
                }
            }
            else {
                
            }
        }
    }
    
}
