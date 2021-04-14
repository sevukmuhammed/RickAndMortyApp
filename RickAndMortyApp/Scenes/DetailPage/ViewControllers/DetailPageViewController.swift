//
//  DetailPageViewController.swift
//  RickAndMortyApp
//
//  Created by Muhammed Sevük on 14.03.2021.
//

import Foundation
import RxSwift
import RxCocoa
import Swinject
import Kingfisher
import RealmSwift

final class DetailPageViewController: BaseViewController, DetailPageStoryboardLoadable {
    
    @IBOutlet weak var characterImage: UIImageView!
    @IBOutlet weak var genderImage: UIImageView!
    @IBOutlet weak var characterName: UILabel!
    @IBOutlet weak var originalLocationLabel: UILabel!
    @IBOutlet weak var lastKnownLocationLabel: UILabel!
    @IBOutlet weak var lastEpisodeLabel: UILabel!
    @IBOutlet weak var lastEpisodeAirDateLabel: UILabel!
    @IBOutlet weak var numberOfEpisodesLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var statusImage: UIImageView!
    @IBOutlet weak var speciesLabel: UILabel!
    @IBOutlet weak var speciesImage: UIImageView!
    @IBOutlet weak var star: UIImageView!
    @IBOutlet weak var favButton: UIButton!
    @IBOutlet weak var starFill: UIImageView!
    var characters: Results<Characters>!
    var container: Container!
    var disposeBag: DisposeBag!
    var viewModel: DetailPageViewModel!
    var character: Result!
    let realm = try! Realm()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        self.viewModel.getEpisodeData(character: character)
        setData()
        subscribeViewModel()
        setFavButton()
        subscribeButton()
    }
    
    func setupNavigationBar() {
        self.navigationItem.title = "Detail"
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor : UIColor.white]
        
    }
    
    func setData() {
        characterImage.kf.setImage(with: URL(string: character.image ?? ""))
        if character.gender == "Male" {
            genderImage.image = UIImage(named: "mars")
        } else if character.gender == "Female" {
            genderImage.image = UIImage(named: "femenine")
        }
        
        characterName.text = character.name ?? ""
        statusLabel.text = character.status ?? ""
        if character.status == "Alive" {
            statusImage.image = UIImage(named: "aliveDark")
        } else if character.status == "unknown" {
            statusImage.image = UIImage(named: "question-mark")
        } else if character.status == "Dead" {
            statusImage.image = UIImage(named: "dead")
        }
        speciesLabel.text = character.species ?? ""
        if character.species == "Human" {
            speciesImage.image = UIImage(named: "user-icon")
        } else if character.species == "Alien" {
            speciesImage.image = UIImage(named: "outer-space-alien")
        }
        
        originalLocationLabel.text = character.origin?.name ?? ""
        lastKnownLocationLabel.text = character.location?.name ?? ""
        numberOfEpisodesLabel.text = String(character.episode?.count ?? 0)
    }
    
    func subscribeViewModel() {
        self.viewModel.behaviorRelay.subscribe(onNext: { data in
            self.lastEpisodeLabel.text = data.name ?? ""
            self.lastEpisodeAirDateLabel.text = data.airDate ?? ""
        }).disposed(by: disposeBag)
    }
    
    func setFavButton() {
        self.load()

        var temp = false
        characters.forEach { ch in
            if ch.id == character.id {
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
    
    func subscribeButton() {
        favButton.rx.tap.subscribe(onNext: {
            self.load()
            var temp = false
            self.characters.forEach { character in
                if character.id == self.character?.id{
                    temp = true
                }
            }
            let ch = Characters()
            ch.id = self.character?.id ?? 0
            if temp {
                self.deleteData()
                self.star.isHidden = false
                self.starFill.isHidden = true
            } else {
                self.save(character: ch)
                self.star.isHidden = true
                self.starFill.isHidden = false
            }
            
        }).disposed(by: self.disposeBag)
    }
    
    func load() {
        characters = realm.objects(Characters.self)
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
    
    func deleteData() {
        do {
            try self.realm.write {
                
                self.realm.delete(self.realm.objects(Characters.self).filter("id=%@",self.character.id ?? 0))
                
            }
        } catch {
            print("An error occurred while deleting the item: \(error)")
        }
    }
}
