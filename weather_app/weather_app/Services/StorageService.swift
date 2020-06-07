//
//  StorageService.swift
//  weather_app
//
//  Created by Anatoly on 08.06.2020.
//  Copyright © 2020 Anatoly. All rights reserved.
//

import Foundation

protocol KeyedSubscription {

    func set<T: Encodable>(object: T?, key: String)
    func object<T: Decodable>(key: String) -> T?
    func remove(key: String)
    func clean()
}

protocol StorageServiceProtocol {
    var inDiskCache: KeyedSubscription! { get set }
}

struct DiskCache {

    private let cityKey = "city"

    let diskCache = StorageService().inDiskCache!

    func saveCity(cityString: String) {
        diskCache.set(object: cityString, key: cityKey)
    }

    func requestCity() -> String? {
        return diskCache.object(key: cityKey)
    }

    func removeCity() {
        diskCache.remove(key: cityKey)
    }
}

class StorageService: StorageServiceProtocol {
    var inDiskCache: KeyedSubscription! = UserDefaults.standard
}

extension UserDefaults: KeyedSubscription {

    func set<T: Encodable>(object: T?, key: String) {
        if let encoded = try? PropertyListEncoder().encode(object) {
            set(encoded, forKey: key)
            return
        }
        set(object, forKey: key)
        synchronize()
    }

    func object<T: Decodable>(key: String) -> T? {

        if let object = object(forKey: key) as? Data {
            if let stored = try? PropertyListDecoder().decode(T.self, from: object) {
                return stored
            }
        }
        return object(forKey: key) as? T
    }

    func remove(key: String) {
        removeObject(forKey: key)
    }

    func clean() {
        let bundleName = Bundle.main.bundleIdentifier!
        removePersistentDomain(forName: bundleName)
        synchronize()
    }
}
