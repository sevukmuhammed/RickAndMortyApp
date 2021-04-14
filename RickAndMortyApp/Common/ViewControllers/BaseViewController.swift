//
//  BaseViewController.swift
//  RickAndMortyApp
//
//  Created by Muhammed Sevük on 12.03.2021.
//

import Foundation
import RxSwift
public class BaseViewController : UIViewController {
    
    public let navigationSubject = PublishSubject<Navigation<Any>>()
    
    public override func viewDidLoad() {
        
        super.viewDidLoad()
    }
    public override var preferredStatusBarStyle: UIStatusBarStyle {
        .lightContent
    }
}

