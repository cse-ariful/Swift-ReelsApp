//
//  QueryDataHelper.swift
//  PexelsClient
//
//  Created by Ariful Jannat Arif on 1/5/23.
//

import Foundation
enum Query: String, CaseIterable{
    case nature, animals, people, ocean,food , computer, monitor, birds, city, hospital
}


struct PexelApiResponseBody : Decodable{
    var page:Int
    var perPage:Int
    var totalResults:Int
    var url: String
    var videos:[VideoModel]
}

struct VideoModel : Identifiable,Decodable{
    var id:Int
    var image:String
    var duration:Int
    var user:User
    var videoFiles : [VideoFile]
    
    struct User : Identifiable, Decodable{
        var id:Int
        var name:String
        var url:String
    }
    struct VideoFile : Identifiable, Decodable{
        var id:Int
        var quality:String
        var fileType:String
        var link:String
    }
}
