//
//  DetailPageStoryboardLoadable.swift
//  RickAndMortyApp
//
//  Created by Muhammed Sevük on 14.03.2021.
//

import Foundation
import UIKit

public protocol DetailPageStoryboardLoadable: StoryboardLoadable {}

extension DetailPageStoryboardLoadable where Self: UIViewController {
    @nonobjc static var storyboardName: String {
        return "DetailPageStoryboard"
    }
}
