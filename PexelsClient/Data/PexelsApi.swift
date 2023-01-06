//
//  PexelsApi.swift
//  PexelsClient
//
//  Created by Ariful Jannat Arif on 1/6/23.
//

import Foundation

private var pexelApiKey = "563492ad6f91700001000001387f6df23aa34aec89b7e0367d51c21a"

enum PexelsApi{
    case videos(page:Int,query:String)
    case images(page:Int,query:String)
}
extension PexelsApi{
    enum MethodType{
        case GET
        case POST(data:AnyObject)
    }
}
extension PexelsApi{
    var host:String  {"api.pexels.com"}
    var path:String{
        switch self{
        case .images(_, _):
            return "/images/search"
        case .videos(_, _):
            return "/videos/search"
        
        }
    }
    
    var methodType : MethodType{
        switch self{
        case .videos(_, _):
            return .GET
        case .images(_, _):
            return .GET
        }
    }
    var queryItems : [ String : String]? {
        switch self{
        case .videos(let page, let query):
            return ["query":"\(query)","page":"\(page)","orientation":"portrait"]
        case .images(let page, let query):
            return ["query":"\(query)","page":"\(page)"]
        }
    }
}
extension PexelsApi{
    
    private var url:URL?{
        var urlComponent = URLComponents()
        urlComponent.scheme = "https"
        urlComponent.host = host
        urlComponent.path = path
        urlComponent.queryItems = queryItems?.compactMap{item in
            URLQueryItem(name: item.key, value: item.value)
        }
        return urlComponent.url
    }
    var request : URLRequest?{
        guard url != nil else {return nil}
        var urlReq = URLRequest(url: url!)
        urlReq.cachePolicy = .returnCacheDataElseLoad
        urlReq.setValue(pexelApiKey, forHTTPHeaderField: "Authorization")
        return urlReq
    }
}
