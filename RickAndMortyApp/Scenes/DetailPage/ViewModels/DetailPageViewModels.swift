//
//  DetailPageViewModels.swift
//  RickAndMortyApp
//
//  Created by Muhammed Sevük on 14.03.2021.
//

import Foundation
import RxSwift
import RxCocoa

final class DetailPageViewModel: BaseViewModel {
    private var repository: DetailPageRepository!
    var behaviorRelay = BehaviorRelay<Episode>(value: Episode())
    init(disposeBag: DisposeBag, DetailPageRepository: DetailPageRepository) {
        super.init()
        self.disposeBag = disposeBag
        self.repository = DetailPageRepository
    }
    
    func getEpisodeData(character: Result) {
        let array = character.episode?.last?.components(separatedBy: "/")
        let episodeNumber = array?.last
        
        self.repository.getEpisode(Episode.self, episodeNumber: episodeNumber ?? "").subscribe(onNext: { data in
            print("dataaa=> ",data)
            self.behaviorRelay.accept(data)
        }, onError: { error in
            print("Error => \(error.localizedDescription)")
        }).disposed(by: disposeBag)
    }
}
