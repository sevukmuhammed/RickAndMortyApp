//
//  DetailPageCoordinator.swift
//  RickAndMortyApp
//
//  Created by Muhammed Sevük on 14.03.2021.
//

import Foundation
import Swinject
import RxSwift

public enum DetailPageScene: String, AppScene {
    
    case detailPage = "detailPage"
    
    public var identifier: String {
        return "DetailPage"
    }
    
    public var name: String {
        return self.rawValue
    }
    
    public var coordinator: BaseCoordinator.Type {
        return DetailPageCoordinator.self
    }
}

final class DetailPageCoordinator: BaseCoordinator {
    override func start(_ scene: AppScene, data: Any) {
        viewController = container.resolveViewController(DetailPageViewController.self)
        let _data = data as! [String: Any]
        (viewController as! DetailPageViewController).character = _data["character"] as? Result
        navigationController.pushViewController(viewController, animated: true)
    }
    override func  navigate(scene: AppScene, data: Any) {
        
    }
    
    override func back(_ viewController: UIViewController) {
        navigationController.popViewController(animated: true)
    }
}
