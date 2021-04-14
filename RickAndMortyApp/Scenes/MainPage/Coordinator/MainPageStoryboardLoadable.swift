//
//  MainPageStoryboardLoadable.swift
//  RickAndMortyApp
//
//  Created by Muhammed Sevük on 12.03.2021.
//

import Foundation
import UIKit

public protocol MainPageStoryboardLoadable: StoryboardLoadable {}

extension MainPageStoryboardLoadable where Self: UIViewController {
    @nonobjc static var storyboardName: String {
        return "MainPageStoryboard"
    }
}

