//
//  MoyaProvider.swift
//  RickAndMortyApp
//
//  Created by Muhammed Sevük on 13.03.2021.
//

import Foundation
import Moya

let provider: MoyaProvider<API> = {
    return MoyaProvider<API>.init(plugins: [NetworkLoggerPlugin()])
}()

enum API {
    case characters(_ page: Int)
    case filter(_ name: String, _ status: String)
    case episode(_ episode: String)
}

extension API: TargetType {
    var baseURL: URL {
        switch self {
        case .characters, .filter, .episode:
            return URL(string: "https://rickandmortyapi.com/api")!
        }
        
    }
    
    var path: String {
        switch self {
        case .characters, .filter:
            return "/character"
        case .episode(let episode):
            return "/episode/\(episode)"
        }
        
    }
    
    var method: Moya.Method {
        return .get
    }
    
    var sampleData: Data {
        return "sample".data(using: .utf8) ?? Data()
    }
    
    var task: Task {
        switch self {
        case .characters(let page):
            return .requestParameters(parameters: [
                                        "page": page
                                        ], encoding: URLEncoding.queryString)
        case .filter(let name, let status):
            return .requestParameters(parameters: [
                                        "name" : name,
                                        "status" : status
                                        ], encoding: URLEncoding.queryString)
        case .episode:
            return .requestPlain
        }
    }
    
    var headers: [String : String]? {
        switch self {
        case .characters, .filter:
            return ["Accept": "*/*"]
        case .episode:
            return [:]
        }
        
    }
}
