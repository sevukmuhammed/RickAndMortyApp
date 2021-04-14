//
//  MainPageRepository.swift
//  RickAndMortyApp
//
//  Created by Muhammed Sevük on 13.03.2021.
//

import Foundation
import RxSwift

final class MainPageRepository {
    
    func getCharacterList<T>(_ dump: T.Type, page: Int) -> Observable<T> where T : Decodable, T: Encodable {
        return provider.rx
            .request(.characters(page))
            .observeOn(MainScheduler.instance)
            .map(T.self)
            .asObservable()
    }
    
    func getFilter<T>(_ dump: T.Type, name: String?, status: String?) -> Observable<T> where T : Decodable, T: Encodable {
        return provider.rx
            .request(.filter(name ?? "", status ?? ""))
            .observeOn(MainScheduler.instance)
            .map(T.self)
            .asObservable()
    }
}
