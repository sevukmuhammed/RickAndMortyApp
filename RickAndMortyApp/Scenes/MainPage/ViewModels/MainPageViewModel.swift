//
//  MainPageViewModel.swift
//  RickAndMortyApp
//
//  Created by Muhammed Sevük on 12.03.2021.
//

import Foundation
import RxSwift
import RxCocoa
import RealmSwift

final class MainPageViewModel: BaseViewModel {
    var filterMode = BehaviorRelay<Bool>(value: false)
    private var repository: MainPageRepository!
    var behaviorRelay = BehaviorRelay<[Result]>(value: [Result()])
    var pageRelay = BehaviorRelay<Int>(value: 1)
    var array = [Result]()
    init(disposeBag: DisposeBag, MainPageRepository: MainPageRepository) {
        super.init()
        self.disposeBag = disposeBag
        self.repository = MainPageRepository
    }
    
    func getData(page: Int) {
        self.repository.getCharacterList(Response.self, page: page).subscribe(onNext: { data in
            
            
            self.behaviorRelay.accept(self.addData(data: data))
            
        }, onError: { error in
            print("Error => \(error.localizedDescription)")
            self.behaviorRelay.accept([Result()])
        }).disposed(by: disposeBag)
    }
    
    func addData(data: Response?) -> [Result] {
        data?.results?.forEach({ value in
            array.append(value)
        })
        return array
    }
    func getFilterData(name: String?, status: String?) {
        self.repository.getFilter(Response.self, name: name, status: status).subscribe(onNext: { data in
            self.behaviorRelay.accept(data.results ?? [Result()])
        }, onError: { error in
            print("Error => \(error.localizedDescription)")
            self.behaviorRelay.accept([Result()])
        }).disposed(by: disposeBag)
    }
}

