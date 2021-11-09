//
//  CombineHttpManager.swift
//  PlaygroundForTesting
//
//  Created by Yousef on 8/16/21.
//

import Foundation
import SwiftUI
import Combine


enum CombineHttpError: Error, LocalizedError {
    case statusCode
    case decoding
    case invalidURL(String)
    case other(Error)
    case badResponse
    case badRequest(String)
    
    static func map(_ error: Error) -> CombineHttpError {
        return (error as? CombineHttpError) ?? .other(error)
    }
    
    var errorDescription: String? {
        switch self {
        
        case .statusCode:
            return "Server Error"
        case .decoding:
            return "Some of your data is correpted"
        case .invalidURL(let url):
            return "Bad URL: \(url)"
        case .other(let error):
            return error.localizedDescription
        case .badResponse:
            return "Bas Response"
        case .badRequest(let message):
            return message
        }
    }
}




class CombineHttpManager {
    
    
    private static func handleResponse<T: Decodable, Z: CombineWebManagerGeneralErrorResponse>(decodingType: T.Type, errorType: Z.Type, request: URLRequest) ->  AnyPublisher<T, CombineHttpError>{
       
        return URLSession.shared.dataTaskPublisher(for: request)
            .tryMap({ response -> Data in
                guard
                    let _ = response.response as? HTTPURLResponse
                else {
                    throw CombineHttpError.badResponse
                }
                
                return response.data
            })
            .tryMap { response -> T in
                if let result = try? JSONDecoder().decode(T.self, from: response) {
                    return result
                } else {
                    
                    if let stringResponse = try? JSONSerialization.jsonObject(with: response, options: .allowFragments) {
                        print("🔥 Error:")
                        print("URL: \(request.url?.absoluteString ?? "")")
                        print("Response", stringResponse)
                        print("*************************************")
                    }
                    
//                    throw CombineHttpError.decoding
                    if let errorResponse = try? JSONDecoder().decode(Z.self, from: response) {
                        throw CombineHttpError.badRequest("🔥 Status code: \(errorResponse.statusCode), \(errorResponse.message)")
                    } else {
                        throw CombineHttpError.decoding
                    }
                }
            }
            .mapError { CombineHttpError.map($0) }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
     /// create url from string and add query parameters to this url
    static private func createURL(url: String, queryParam: [String : Any]?) -> URL? {
        guard var urlComps = URLComponents(string: url) else {
            
            return nil
        }
        
        if let queryParam = queryParam {
            var queryItems = [URLQueryItem]()
            
            for (key, value) in queryParam {
                let queryItem = URLQueryItem(name: key, value: String(describing: value))
                queryItems.append(queryItem)
            }
         
            urlComps.queryItems = queryItems
        }
        
        return urlComps.url
    }
    
    
    //MARK: - Public funcs
    //MARK: Get
    static func Get<T: Decodable, Z: CombineWebManagerGeneralErrorResponse>(
        decodingType: T.Type,
        errorType: Z.Type,
        urlString: String,
        params: [String : Any]? = nil
    ) -> AnyPublisher<T, CombineHttpError>  {
        guard let url = createURL(url: urlString, queryParam: params) else {
            return Fail(error: CombineHttpError.invalidURL(urlString))
                .eraseToAnyPublisher()
        }
        
        let request = URLRequest(url: url)
        
        return handleResponse(decodingType: decodingType, errorType: errorType, request: request)
    }
    
    //MARK: POST
    static func Post<T: Decodable, Z: CombineWebManagerGeneralErrorResponse, U: Encodable>(
        decodingType: T.Type,
        errorType: Z.Type,
        body: U,
        urlString: String,
        params: [String : Any]? = nil
    ) -> AnyPublisher<T, CombineHttpError> {
        guard let url = createURL(url: urlString, queryParam: params) else {
            return Fail(error: CombineHttpError.invalidURL(urlString))
                .eraseToAnyPublisher()
        }
        
        var request = URLRequest(url: url)
        
        request.httpMethod = "POST"
        
        // Set request headers
        request.addValue("application/json", forHTTPHeaderField: "Content-type")
        
        // Set request body
        let tempBody = try? JSONEncoder().encode(body)
        request.httpBody = tempBody
        
        return handleResponse(decodingType: decodingType, errorType: errorType, request: request)
    }
    
    //MARK: PUT
    static func Put<T: Decodable, Z: CombineWebManagerGeneralErrorResponse, U: Encodable>(
        decodingType: T.Type,
        errorType: Z.Type,
        body: U,
        urlString: String,
        params: [String : Any]? = nil
    ) -> AnyPublisher<T, CombineHttpError> {
        guard let url = createURL(url: urlString, queryParam: params) else {
            return Fail(error: CombineHttpError.invalidURL(urlString))
                .eraseToAnyPublisher()
        }
        
        var request = URLRequest(url: url)
        
        request.httpMethod = "PUT"
        
        // Set request headers
        request.addValue("application/json", forHTTPHeaderField: "Content-type")
        
        // Set request body
        let tempBody = try? JSONEncoder().encode(body)
        request.httpBody = tempBody
        
        return handleResponse(decodingType: decodingType, errorType: errorType, request: request)
    }
    
    
}
