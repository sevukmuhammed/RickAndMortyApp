//
//  CharacterModel.swift
//  RickAndMortyApp
//
//  Created by Muhammed Sevük on 13.03.2021.
//

import Foundation

public struct Response: Codable {
    var info : Info?
    var results : [Result]?
    
    enum CodingKeys: String, CodingKey {
        case info = "info"
        case results = "results"
    }
    
    public init() {}
}

public struct Info: Codable {
    var count : Int?
    var pages : Int?
    var next : String?
    var prev : String?
    
    enum CodingKeys: String, CodingKey {
        case count = "count"
        case pages = "pages"
        case next = "next"
        case prev = "prev"
    }
}

public struct Result: Codable {
    var id : Int?
    var name : String?
    var status : String?
    var species : String?
    var type : String?
    var gender: String?
    var origin: Origin?
    var location : Location?
    var image : String?
    var episode : [String]?
    var url: String?
    var created: String?
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case status = "status"
        case species = "species"
        case type = "type"
        case gender = "gender"
        case origin = "origin"
        case location = "location"
        case image = "image"
        case episode = "episode"
        case url = "url"
        case created = "created"
    }
    
}

public struct Origin: Codable {
    var name : String?
    var url : String?
    
    enum CodingKeys: String, CodingKey {
        case name = "name"
        case url = "url"
    }
}

public struct Location: Codable {
    var name : String?
    var url : String?
    
    enum CodingKeys: String, CodingKey {
        case name = "name"
        case url = "url"
    }
}
