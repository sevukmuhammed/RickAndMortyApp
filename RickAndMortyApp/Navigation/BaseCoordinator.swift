//
//  BaseCoordinator.swift
//  RickAndMortyApp
//
//  Created by Muhammed Sevük on 12.03.2021.
//

import UIKit
import RxSwift
import Swinject

public class BaseCoordinator: NavigationCoordinator {
    public let disposeBag: DisposeBag
    public var container: Container
    public var navigationController: BaseNavigationController
    public let fromViewController: BaseViewController?
    var viewController : BaseViewController!
    var currentScene : AppScene!
    
    required init(container: Container, navigationController: BaseNavigationController, disposeBag: DisposeBag, fromViewController: BaseViewController?) {
        self.container = container
        self.navigationController = navigationController
        self.disposeBag = disposeBag
        self.fromViewController = fromViewController
    }
    public func navigate(scene: AppScene, data: Any) {
        
    }
    
    public func back(_ viewController: UIViewController) {
        
    }
    
    public func start(_ scene: AppScene, data: Any) {
        self.initializeNavigationService()
        
    }
    

}
