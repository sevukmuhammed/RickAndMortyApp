//
//  AppDelegate+Ioc.swift
//  RickAndMortyApp
//
//  Created by Muhammed Sevük on 12.03.2021.
//

import Foundation
import os.log
import SwinjectAutoregistration
import Swinject
import RxSwift

extension AppDelegate {
    internal func initDependencyGraph() {
        self.registerGlobalDependencies(container)
        MainPageComponent.register(container)
        DetailPageComponent.register(container)
    }
    
    private func registerGlobalDependencies(_ container: Container) {
        container.autoregister(DisposeBag.self, initializer: DisposeBag.init  as ()-> DisposeBag).inObjectScope(.container)
    }
}
