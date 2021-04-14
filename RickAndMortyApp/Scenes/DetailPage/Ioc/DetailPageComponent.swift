//
//  DetailPageComponent.swift
//  RickAndMortyApp
//
//  Created by Muhammed Sevük on 14.03.2021.
//

import Foundation
import Swinject
import SwinjectAutoregistration
import RxSwift

final class DetailPageComponent {
    static func register(_ container: Container) {
        container.autoregister(DetailPageRepository.self, initializer: DetailPageRepository.init)
        container.autoregister(DetailPageViewModel.self, initializer: DetailPageViewModel.init)
        container.storyboardInitCompleted(DetailPageViewController.self) { r, c in
            c.disposeBag = r.resolve(DisposeBag.self)
            c.viewModel = r.resolve(DetailPageViewModel.self)
            c.container = container
        }
    }
}
