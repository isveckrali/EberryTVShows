//
//  TvListModel.swift
//  EBerryTVApp
//
//  Created by Mehmet Can Seyhan on 2019-09-12.
//  Copyright © 2019 Mehmet Can Seyhan. All rights reserved.
//

import Foundation

struct TvListModel: Decodable {
    var score:Double?
    var show:Show?
}

struct Show: Decodable {
    var id:Int?
    var url:String?
    var name:String?
    var type:String?
    var language:String?
    var genres:[String]?
    var status:String?
    var runtime:Int?
    var premiered:String?
    var officialSite:String?
    var schedule:Schedule?
    var rating:Rating?
    var weight:Int?
    var network:Network?
    var webChannel:WebChannel?
    var externals:Externals?
    var image:Images?
    var summary:String?
    var updated:Int?
    var links:Links?
}

struct Images: Decodable {
    var medium: String?
    var original: String?
}

struct Schedule: Decodable {
    var time:String?
    var days:[String]?
}

struct Rating: Decodable {
    var average:Double?
}

struct Network: Decodable {
    var id:Int?
    var name:String?
    var country:Country?
}

struct WebChannel: Decodable {
    var id:Int?
    var name:String?
    var country:Country?
}

struct Externals: Decodable {
    var tvrage:Int?
    var thetvdb:Int?
    var imdb:String?
}

struct Image: Decodable {
    var medium:String?
    var original:String?
}

struct Links: Decodable {
    var previousepisode:Previousepisode?
}

struct Country: Decodable {
    var name:String?
    var code:String?
    var timezone:String?
}

struct Previousepisode: Codable {
    var href:String?
}
