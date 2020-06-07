//
//  APIManager.swift
//  weather_app
//
//  Created by Anatoly on 05.06.2020.
//  Copyright © 2020 Anatoly. All rights reserved.
//

import Foundation
import Alamofire
import RxSwift


enum ApiError: Error {
    
    case authError              //Status code 401
    case forbidden              //Status code 403
    case notFound               //Status code 404
    case conflict               //Status code 409
    case internalServerError    //Status code 500
    case dataIsEmpty
    case unknownError
}

protocol JSONRequestPerformingProtocol {
    
    func request<ResponseType: Decodable>(path: URL, method: HTTPMethod) -> Observable<ResponseType>
}

class RxNetworkService: JSONRequestPerformingProtocol {
    
    let sessionManager = Session.default

    func request<ResponseType: Decodable>(path: URL, method: HTTPMethod) -> Observable<ResponseType> {
        
        return Observable<ResponseType>.create { observer -> Disposable in
            
            let encoding: ParameterEncoding = method == .get ? URLEncoding.queryString : JSONEncoding.default
            
            self.sessionManager.request(path,
                                        method: method,
                                        encoding: encoding)
                .validate()
                .responseData { (response) in

                    let statusCode = response.response?.statusCode

                    switch response.result {
                    case .success(let value):
                        self.tryParseResult(observer: observer, urlResponse: response.response, responseData: value)
                    case .failure(_):
                        
                        switch statusCode {
                        case 401:
                            observer.onError(ApiError.authError)
                        case 403:
                            observer.onError(ApiError.forbidden)
                        case 404:
                            observer.onError(ApiError.notFound)
                        case 409:
                            observer.onError(ApiError.conflict)
                        case 500:
                            observer.onError(ApiError.internalServerError)
                        default:
                            observer.onError(ApiError.unknownError)
                        }
                    }
            }
            
            return Disposables.create(with: {
                self.sessionManager.session.getAllTasks { (tasks) in
                    
                    tasks.forEach({ (task) in
                        task.cancel()
                    })
                }
            })
        }

    }
    
    private func tryParseResult<ResponseType: Decodable>(observer: AnyObserver<ResponseType>, urlResponse: HTTPURLResponse?, responseData: Data) {
        
        if responseData.count == 0 {
            observer.onError(ApiError.dataIsEmpty)
            return
        }
        
        do {
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            let decodedValue: ResponseType = try decoder.decode(ResponseType.self, from: responseData)
            observer.onNext(decodedValue)
            observer.onCompleted()
        }
            
        catch (let error) {
            print("Response parsing error: \(error.localizedDescription)")
        }
    }

}
