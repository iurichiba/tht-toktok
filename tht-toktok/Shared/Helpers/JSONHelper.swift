//
//  JSONHelper.swift
//  tht-toktok
//
//  Created by Iuri Chiba on 04/12/22.
//

import Foundation

final class JSONHelper {
    static let sharedDecoder: JSONDecoder = {
        let instance = JSONDecoder()
        instance.dateDecodingStrategy = .iso8601
        instance.keyDecodingStrategy = .convertFromSnakeCase
        return instance
    }()
    
    static let sharedEncoder: JSONEncoder = {
        let instance = JSONEncoder()
        instance.dateEncodingStrategy = .iso8601
        instance.keyEncodingStrategy = .convertToSnakeCase
        return instance
    }()
    
    func decodeFromFile<T: Decodable>(_ file: String, type: T.Type) throws -> T {
        guard let file = Bundle.main.url(forResource: file, withExtension: "json") else {
            throw JSONError.fileNotFound
        }
        
        let data = try Data(contentsOf: file)
        let decoded = try JSONHelper.sharedDecoder.decode(type, from: data)
        return decoded
    }
    
    func encodeToData<T : Encodable>(_ value: T) throws -> Data {
        return try JSONHelper.sharedEncoder.encode(value)
    }
}

enum JSONError: Error {
    case fileNotFound
}

