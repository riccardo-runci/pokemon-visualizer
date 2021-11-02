//
//  Cache.swift
//  pokemon-visualizer
//
//  Created by Riccardo Runci on 02/11/21.
//

import Foundation

class Cache {
    
    // MARK: TODO - implement cache lifetime
    static let shared = Cache()
    
    private var cache: [String: String] = [:]
    
    func saveToCache(_ request: String,_ response: String){
        var cache = self.getAllCachedResponse()
        cache[request] = response
        self.serializeToUserDefaults(cache)
    }
    
    func getCachedResponse(_ request: String) -> String? {
        return self.getAllCachedResponse()[request]
    }
    
    private func getAllCachedResponse() -> [String: String] {
        do {
            if let jsonString = UserDefaults.standard.string(forKey: "cache")?.data(using: .utf8) {
                let result = try JSONDecoder().decode([String:String].self, from: jsonString)
                return result
            }
        }
        catch{
            print(error)
        }
        return [:]
    }
    
    private func serializeToUserDefaults(_ cache: [String: String]){
        do {
            let result = try JSONEncoder().encode(cache)
            let resultString = String(data: result, encoding: .utf8)
            UserDefaults.standard.set(resultString, forKey: "cache")
            UserDefaults.standard.synchronize()
        }
        catch {
            print(error)
        }
    }
}
