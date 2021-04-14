//
//  MainPageViewController.swift
//  RickAndMortyApp
//
//  Created by Muhammed Sevük on 12.03.2021.
//

import Foundation
import RxSwift
import RxCocoa
import Swinject

final class MainPageViewController: BaseViewController, MainPageStoryboardLoadable {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var filterButton: UIButton!
    
    var container: Container!
    var viewModel: MainPageViewModel!
    var disposeBag: DisposeBag!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupNavigationBar()
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.collectionView.keyboardDismissMode = .onDrag
        subscribeAll()
        setupNavigationBar()
        viewModel.getData(page: viewModel.pageRelay.value)
        bindCollectionView()
        
    }
    
   
    override func viewWillAppear(_ animated: Bool) {
        self.collectionView.reloadData()
    }
    
}
