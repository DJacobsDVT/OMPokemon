//
//  NSCache+Subscript.swift
//  OMNetworking
//
//  Created by Daniel Jacobs on 2025/04/09.
//

import Foundation

extension NSCache where KeyType == NSString, ObjectType == PokemonCacheEntryObject {
    subscript(_ name: String) -> PokemonCacheEntry? {
        get {
            let key = name
            let value = object(forKey: key as NSString)
            return value?.entry
        }
        set {
            let key = name
            if let entry = newValue {
                let value = PokemonCacheEntryObject(entry: entry)
                setObject(value, forKey: key as NSString)
            } else {
                removeObject(forKey: key as NSString)
            }
        }
    }
}
