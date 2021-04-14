//
//  ListCharacterCell.swift
//  RickAndMortyApp
//
//  Created by Muhammed Sevük on 13.03.2021.
//

import UIKit
import Reusable
import Kingfisher
import RealmSwift
import RxSwift

class ListCharacterCell: UICollectionViewCell, NibReusable {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var speciesLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var statusImage: UIImageView!
    @IBOutlet weak var favButton: UIButton!
    @IBOutlet weak var star: UIImageView!
    @IBOutlet weak var starFill: UIImageView!
    var characters: Results<Characters>!
    let realm = try! Realm()
    var disposeBag = DisposeBag()
    var cellData: Result? {
        didSet {
            guard let data = cellData else { return }
            imageView.kf.setImage(with: URL(string: data.image ?? ""))
            nameLabel.text = data.name ?? ""
            speciesLabel.text = data.species ?? ""
            statusLabel.text = data.status ?? ""
            if data.status == "Alive" {
                statusImage.image = UIImage(named: "aliveDark")
            } else if data.status == "Dead" {
                statusImage.image = UIImage(named: "dead")
            } else if data.status == "unknown" {
                statusImage.image = UIImage(named: "question-mark")
            }
            self.load()

            var temp = false
            characters.forEach { character in
                if character.id == data.id {
                    temp = true
                }
            }
            if temp {
                self.star.isHidden = true
                self.starFill.isHidden = false
            } else {
                
                self.star.isHidden = false
                self.starFill.isHidden = true
            }
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        subscribeButton()
    }
    
    func save(character: Characters) {
        do {
            try realm.write {
                realm.add(character)
            }
        } catch {
            print("An error occurred while saving the category: \(error)")
        }
    }
    
    func load() {
        characters = realm.objects(Characters.self)
    }
    
    func deleteData() {
        do {
            try self.realm.write {
                
                self.realm.delete(self.realm.objects(Characters.self).filter("id=%@",self.cellData?.id ?? 0))
                
            }
        } catch {
            print("An error occurred while deleting the item: \(error)")
        }
    }
}
