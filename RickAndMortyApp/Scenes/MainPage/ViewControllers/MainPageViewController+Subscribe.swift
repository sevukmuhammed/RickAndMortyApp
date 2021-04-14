//
//  MainPageViewController+Subscribe.swift
//  RickAndMortyApp
//
//  Created by Muhammed Sevük on 13.03.2021.
//

import Foundation
import RxCocoa
import RxSwift
import SwiftMessages

extension MainPageViewController {
    func subscribeAll() {
        subscribeViewModel()
        subscribeSegmentedControl()
        subscribeFilterButton()
    }
    
    func subscribeViewModel() {
        self.viewModel
            .behaviorRelay
            .subscribe(onNext: { value in
            self.collectionView.reloadData()
        }).disposed(by: disposeBag)
    }
    
    func subscribeSegmentedControl() {
        segmentedControl
            .rx
            .selectedSegmentIndex
            .subscribe(onNext: { index in
                self.collectionView.reloadData()
                switch index {
                case 0:
                    self.filterButton.setBackgroundImage(UIImage(named: "filterButton2"), for: .normal)
                    break
                case 1:
                    self.filterButton.setBackgroundImage(UIImage(named: "filterButton"), for: .normal)
                    break
                default:
                    break
                }
        }).disposed(by: disposeBag)
    }
    
    func subscribeFilterButton() {
        filterButton.rx.tap.bind{
            let popup = try! SwiftMessages.viewFromNib(named: "FilterView") as! FilterView
            popup.viewModel = self.viewModel
            popup.disposeBag = self.disposeBag
            var config = SwiftMessages.Config()
            config.presentationStyle = .center
            config.duration = .forever
            config.keyboardTrackingView = KeyboardTrackingView()
            config.dimMode = .blur(style: .dark, alpha: 1.0, interactive: true)
            config.interactiveHide = false
            SwiftMessages.show(config: config, view: popup)
        }.disposed(by: disposeBag)
    }
}
