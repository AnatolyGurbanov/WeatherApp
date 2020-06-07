//
//  URLBuilder.swift
//  weather_app
//
//  Created by Anatoly on 05.06.2020.
//  Copyright © 2020 Anatoly. All rights reserved.
//

import Foundation

class URLBuilder {
    
    enum URLBuilderError: Error {
        
        case emptyHost
        case inconsistentCredentials
        case systemError
    }
    
    func buildUrl(host: String? = nil,
                  path: String = "",
                  queryItems: [String: String]? = [String: String](),
                  scheme: String = "https") throws -> URL {

        guard let host = host else {
            throw URLBuilderError.emptyHost
        }

        var urlComponents = URLComponents()
        urlComponents.scheme = scheme
        urlComponents.host = host
        urlComponents.path = path
        let queryItems = queryItems?.map {
            URLQueryItem(name: $0, value: $1)
        }
        
        urlComponents.queryItems = queryItems
        
        guard let url = urlComponents.url else {
            throw URLBuilderError.systemError
        }

        return url
    }
    
}
