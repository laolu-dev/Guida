//
//  KeyManager.swift
//  Runner
//
//  Created by Toki Olaoluwa on 17/01/2024.
//

import Foundation

struct KeyManager {
   private let keyFilePath = Bundle.main.path(forResource: "ApiKey",      ofType: "plist")
   func getKeys() -> NSDictionary? {
     guard let keyFilePath = keyFilePath else {
       return nil
     }
     return NSDictionary(contentsOfFile: keyFilePath)
   }
   
   func getValue(key: String) -> AnyObject? {
       guard let keys = getKeys() else {
         return nil
       }
     return keys[key]! as AnyObject
   }
}
