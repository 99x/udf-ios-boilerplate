
//
//  FactResponse.swift
//  CalculatorFeature
//
//  Created by Suren Rodrigo on 9/7/19.
//  Copyright © 2019 Suren Rodrigo. All rights reserved.
//
import Alamofire

final class FactRequest: Requestable {
    
    typealias ResponseType = FactResponse
    let date: Int
    let month: Int
    init(date: Int, month: Int) {
        self.date = date
        self.month = month
    }
    
    var baseUrl: URL {
        return  URL(string: BaseUrl)!
    }
    
    var endpoint: String {
        return "\(self.month)/\(self.date)/date?json"
    }
    
    var method: Network.Method {
        return .get
    }
    
    var query: Network.QueryType {
        return .path
    }
    
    var parameters: [String : Any]? {
        return nil
    }
    
    var rawParameters: [Any]?
    
    var headers: [String : String]? {
        return nil
    }
    
    var timeout: TimeInterval {
        return 10.0
    }
    
    var cachePolicy: NSURLRequest.CachePolicy {
        return .reloadIgnoringLocalAndRemoteCacheData
    }
    
}
