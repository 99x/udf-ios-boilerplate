//
//  Network.swift
//  buttik
//
//  Created by Bishan Meddegoda on 5/21/19.
//  Copyright © 2019 driw. All rights reserved.
//

import Foundation
import Alamofire

protocol Requestable {
    
    associatedtype ResponseType: Codable

    var endpoint: String { get }
    var method: Network.Method { get }
    var query:  Network.QueryType { get }
    var parameters: [String: Any]? { get }
    var rawParameters: [Any]? { get }
    var headers: [String: String]? { get }
    var baseUrl: URL { get }
    var timeout : TimeInterval { get }
    var cachePolicy : NSURLRequest.CachePolicy { get }
    
}

enum NetworkResult<T> {
    case success(T)
    case cancel(Error?)
    case failure(Error?)
}

class Network {
    
    public enum Method: String {
        case get = "GET"
        case post = "POST"
        case put = "PUT"
        case delete = "DELETE"
    }
    
    public enum QueryType {
        case json, path
    }
    
    struct ApiSpecificError: Codable {
        var code: String
        var message: String
        var requestId: String
    }
    
    @discardableResult
    static func request<T: Requestable>(req: T, completionHandler: @escaping (NetworkResult<T.ResponseType?>) -> Void) -> DataRequest? {
        
        let url = req.baseUrl.appendingPathComponent(req.endpoint)
        let request = prepareRequest(for: url, req: req)
        
        return Alamofire.request(request).responseData{ (response) in
            
            if let err = response.error {
                
                if let urlError = err as? URLError, urlError.code == URLError.cancelled {
                    // cancelled
                    completionHandler(NetworkResult.cancel(urlError))
                } else {
                    // other failures
                    completionHandler(NetworkResult.failure(err))
                }
                return
            }
            
            if let data = response.data {
                if(data.isEmpty){
                    completionHandler(NetworkResult.success(nil))
                }
                else{
                    if(response.response?.statusCode != 200){
                        let decoder = JSONDecoder()
                        do {
                            let object = try decoder.decode(ApiSpecificError.self, from: data)
                            let userInfo: [String : Any] = [NSLocalizedDescriptionKey :  object.message]
                            let error = NSError(domain: "HttpResponseError", code: Int(object.code) ?? 0, userInfo: userInfo)
                            completionHandler(NetworkResult.failure(error))
                        } catch let error {
                            completionHandler(NetworkResult.failure(error))
                        }
                    }
                    else{
                        let decoder = JSONDecoder()
                        do {
                            let object = try decoder.decode(T.ResponseType.self, from: data)
                            completionHandler(NetworkResult.success(object))
                        } catch let error {
                            completionHandler(NetworkResult.failure(error))
                        }
                    }
                }
            }
        }
        
    }
    
}

extension Network {
    
    private static func prepareRequest<T: Requestable>(for url: URL, req: T) -> URLRequest {
        
        var request : URLRequest? = nil
        
        switch req.query {
        case .json:
            request = URLRequest(url: url, cachePolicy: req.cachePolicy,
                                 timeoutInterval: req.timeout)
            if let params = req.parameters {
                print("came to res parameters")
                print("------------")
                do {
                    let body = try JSONSerialization.data(withJSONObject: params, options: [])
                    request!.httpBody = body
                } catch {
                    assertionFailure("Error : while attemping to serialize the data for preparing httpBody \(error)")
                }
            }
            if let params = req.rawParameters {
                print("came to res rawParameters")
                print("------------")
                print(params)
                do {
                    let body = try JSONSerialization.data(withJSONObject: params, options: [])
                    request!.httpBody = body
                    print("-----JSON-------")
                    print(body)
                } catch {
                    assertionFailure("Error : while attemping to serialize the data for preparing httpBody \(error)")
                }
            }
        case .path:
            var query = ""
            
            req.parameters?.forEach { key, value in
                query = query + "\(key)=\(value)&"
            }
            
            var components = URLComponents(url: url, resolvingAgainstBaseURL: true)!
            components.query = query
            request = URLRequest(url: components.url!, cachePolicy: req.cachePolicy, timeoutInterval: req.timeout)
        }
        
        request!.allHTTPHeaderFields = req.headers
        request!.httpMethod = req.method.rawValue
        
        return request!
    }
    
}
