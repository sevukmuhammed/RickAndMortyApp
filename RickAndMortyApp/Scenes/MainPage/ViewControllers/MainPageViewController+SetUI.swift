//
//  MainPageViewController+SetUI.swift
//  RickAndMortyApp
//
//  Created by Muhammed Sevük on 24.03.2021.
//

import UIKit

extension MainPageViewController  {
    func setupNavigationBar() {
        self.navigationItem.title = "Home"
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor : UIColor.white]
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 110/255, green: 183/255, blue: 226/255, alpha: 1)
    }
    
}
