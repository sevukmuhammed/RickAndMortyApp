//
//  MainPageViewController+CollectionView.swift
//  RickAndMortyApp
//
//  Created by Muhammed Sevük on 13.03.2021.
//

import Foundation
import RxSwift
import RxCocoa


extension MainPageViewController : UICollectionViewDataSource {
    
    internal func bindCollectionView() {
        registerCollectionViewCells()
        
    }
    
    private func registerCollectionViewCells() {
        collectionView.register(cellType: GridCharacterCell.self)
        collectionView.register(cellType: ListCharacterCell.self)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.behaviorRelay.value.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ListCharacterCell", for: indexPath) as! ListCharacterCell
            cell.cellData = viewModel.behaviorRelay.value[indexPath.row]
            return cell
        case 1:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GridCharacterCell", for: indexPath) as! GridCharacterCell
            cell.cellData = viewModel.behaviorRelay.value[indexPath.row]
            return cell
        default:
            return UICollectionViewCell()
            
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.row == (viewModel.behaviorRelay.value.count) - 1 && !viewModel.filterMode.value {
            
            Timer.scheduledTimer(withTimeInterval: 2, repeats: false, block: { (timer:Timer) in
                    self.viewModel.pageRelay.accept(self.viewModel.pageRelay.value + 1)
                    self.viewModel.getData(page: self.viewModel.pageRelay.value)
            })
            
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let gridCell = self.collectionView.cellForItem(at: indexPath) as? GridCharacterCell
        let listCell = self.collectionView.cellForItem(at: indexPath) as? ListCharacterCell
        
        if gridCell != nil {
            self.navigationSubject.onNext(Navigation<Any>(DetailPageScene.detailPage, data: ["character": gridCell?.cellData]))
        } else if listCell != nil {
            self.navigationSubject.onNext(Navigation<Any>(DetailPageScene.detailPage, data: ["character": listCell?.cellData]))
        }
        
    }
    
}

extension MainPageViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            return CGSize(width: (collectionView.frame.width - 20), height: 100)
        case 1:
            return CGSize(width: (collectionView.frame.width - 30) / 2, height: (collectionView.frame.width - 30) / 2)
        default:
            return CGSize(width: (collectionView.frame.width - 30) / 2, height: (collectionView.frame.width - 30) / 2)
        }
        
    }

}


