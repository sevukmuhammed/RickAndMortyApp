//
//  ListCharacterCell+Subscribe.swift
//  RickAndMortyApp
//
//  Created by Muhammed Sevük on 13.03.2021.
//

import Foundation
import RxSwift
import RealmSwift

extension ListCharacterCell {
    func subscribeButton() {
        favButton.rx.tap.subscribe(onNext: {
            self.load()
            var temp = false
            self.characters.forEach { character in
                if character.id == self.cellData?.id{
                    temp = true
                }
            }
            let character = Characters()
            character.id = self.cellData?.id ?? 0
            if temp {
                self.deleteData()
                self.star.isHidden = false
                self.starFill.isHidden = true
            } else {
                self.save(character: character)
                self.star.isHidden = true
                self.starFill.isHidden = false
            }
            
        }).disposed(by: self.disposeBag)
    }
}
