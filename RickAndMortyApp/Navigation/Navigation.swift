//
//  Navigation.swift
//  RickAndMortyApp
//
//  Created by Muhammed Sevük on 12.03.2021.
//

import Foundation

public struct Navigation<T> {
    public let scene: AppScene
    public let data: Any
    public let name: String?
    public let animation: Bool?
    
    public init(_ scene:AppScene, data:Any, name: String? = nil, animation: Bool? = nil) {
        self.scene = scene
        self.data = data
        self.name = name
        self.animation = animation
    }
}

