//
//  Data+Extensions.swift
//  weather_app
//
//  Created by Anatoly on 06.06.2020.
//  Copyright © 2020 Anatoly. All rights reserved.
//

import Foundation

extension Data {

    func decode<Type: Codable>(completion: @escaping (Type?, Error?) -> Void) {
        let decoder = JSONDecoder()
        do {
            let model: Type = try decoder.decode(Type.self, from: self)
            completion(model, nil)
        } catch let error {
            print(error)
            completion(nil, error)
        }
    }
}
