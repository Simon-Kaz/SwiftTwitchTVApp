//
//  GameDataProcessor.swift
//  TwitchListing
//
//  Created by Szymon Kazmierczak on 28/05/2017.
//  Copyright © 2017 Szymon Kazmierczak. All rights reserved.
//

import Foundation
import SwiftyJSON

class GameDataProcessor {
    
    static func mapJsonToGames(object: [String: AnyObject]) -> [Game] {
        
        var mappedGames: [Game] = [ ]
        
        let json = JSON(object)
        
        for game in json["top"].arrayValue {
            
            // TODO: Clean up the json traversing
            let id = game["game"]["_id"].stringValue
            let title = game["game"]["name"].stringValue
            let channels = game["channels"].stringValue
            let viewers = game["viewers"].stringValue
            let imageUrl = game["game"]["box"]["large"].stringValue
            let logoUrl = game["game"]["logo"]["large"].stringValue
            
//            print("GAME DETAILS: " + id + " " + title  + " " + channels  + " " +  viewers  + " " +  imageUrl)
            
            let gameClass = Game(id: id, title: title, channels: channels, viewers: viewers, imageUrl: imageUrl, logoUrl: logoUrl)
            mappedGames.append(gameClass)
        }
        return mappedGames
    }
}
