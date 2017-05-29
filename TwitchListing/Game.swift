//
//  Game.swift
//  TwitchListing
//
//  Created by Szymon Kazmierczak on 28/05/2017.
//  Copyright © 2017 Szymon Kazmierczak. All rights reserved.
//

import Foundation

class Game {
    var id: String = ""
    var title: String = ""
    var channels: String = ""
    var viewers: String = ""
    var imageUrl: String = ""
    var logoUrl: String = ""
    
    init(id: String, title: String, channels: String, viewers: String, imageUrl: String, logoUrl: String){
        self.id = id
        self.title = title
        self.channels = channels
        self.viewers = viewers
        self.imageUrl = imageUrl
        self.logoUrl = logoUrl
    }
}
