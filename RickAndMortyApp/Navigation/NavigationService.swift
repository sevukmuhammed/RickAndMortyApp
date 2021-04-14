//
//  NavigationService.swift
//  RickAndMortyApp
//
//  Created by Muhammed Sevük on 12.03.2021.
//

import UIKit
import RxSwift
import Swinject

public enum NavigationError: Error {
    case unImplementedScene
    case navigationObjectNotCreated
}

public class NavigationService {
    static var navigationService: NavigationService?
    static var navigationStack: [AppScene] = [AppMainScene.app]
    
    let container: Container
    let disposeBag: DisposeBag
    private init(_ container: Container, disposeBag: DisposeBag) {
        self.container = container
        self.disposeBag = disposeBag
    }
    
    static func requestNavigationObject() throws -> NavigationService {
        guard let _ = navigationService else {
            throw NavigationError.navigationObjectNotCreated
        }
        return navigationService!
    }
    
    public static func initializeNavigationService(_ container: Container, disposeBag: DisposeBag, fromViewController: BaseViewController?) {
        navigationService = NavigationService(container, disposeBag: disposeBag)
    }
    
    public func start(fromViewController: BaseViewController, navigationController: BaseNavigationController, prevCoordinator: BaseCoordinator, nextScene: AppScene, data: Any, animation: Bool?) throws {
        
        
    if nextScene.name == "back" {
        NavigationService.backScene()
        prevCoordinator.back(fromViewController)
        return
    }
    
    let nextSceneCoordinator = nextScene.coordinator
    
    NavigationService.setCurrentScene(scene: nextScene)
    nextSceneCoordinator.init(container: self.container,
               navigationController: navigationController,
               disposeBag: self.disposeBag, fromViewController:fromViewController)
        .start(nextScene, data:data)
    }
}

extension NavigationService {
    
    static func setCurrentScene(scene: AppScene){
            NavigationService.navigationStack.append(scene)
    }
    
    static func backScene(){
        if NavigationService.navigationStack.count > 1 {
            NavigationService.navigationStack.removeLast()
        }
    }
    
    static func getCurrentScene() -> AppScene{
        return NavigationService.navigationStack.last ?? MainPageScene.mainPage
    }
}

