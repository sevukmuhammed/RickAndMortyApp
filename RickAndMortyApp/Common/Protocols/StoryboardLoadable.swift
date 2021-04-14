//
//  StoryboardLoadable.swift
//  RickAndMortyApp
//
//  Created by Muhammed Sevük on 12.03.2021.
//

import UIKit

public protocol StoryboardLoadable: AnyObject {
    @nonobjc static var storyboardName: String { get }
}

