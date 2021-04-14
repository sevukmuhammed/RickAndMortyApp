//
//  AppDelegate.swift
//  RickAndMortyApp
//
//  Created by Muhammed Sevük on 12.03.2021.
//

import UIKit
import Swinject

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    internal var appCoordinator: AppCoordinator!
    internal let container = Container()
    
    func application(_ application: UIApplication, willFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        initDependencyGraph()
        return true
    }
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        window = UIWindow()
        appCoordinator = AppCoordinator(window: window!, container: container)
        appCoordinator.start(AppMainScene.app, data: [])
        window?.makeKeyAndVisible()
        return true
    }

}

