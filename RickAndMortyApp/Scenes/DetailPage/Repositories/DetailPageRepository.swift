//
//  DetailPageRepository.swift
//  RickAndMortyApp
//
//  Created by Muhammed Sevük on 14.03.2021.
//

import Foundation
import RxSwift

final class DetailPageRepository {
    func getEpisode<T>(_ dump: T.Type, episodeNumber: String) -> Observable<T> where T : Decodable, T: Encodable {
        return provider.rx
            .request(.episode(episodeNumber))
            .observeOn(MainScheduler.instance)
            .map(T.self)
            .asObservable()
    }
}

