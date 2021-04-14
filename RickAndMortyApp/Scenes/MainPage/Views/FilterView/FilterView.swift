//
//  FilterView.swift
//  RickAndMortyApp
//
//  Created by Muhammed Sevük on 13.03.2021.
//

import Foundation
import Reusable
import SwiftMessages
import RxSwift

final class FilterView: MessageView, NibLoadable, UITextFieldDelegate {
    
    @IBOutlet weak var aliveCheckbox: UIButton!
    @IBOutlet weak var unkownCheckbox: UIButton!
    @IBOutlet weak var deadCheckbox: UIButton!
    @IBOutlet weak var nameText: UITextField!
    @IBOutlet weak var goButton: UIButton!
    
    var viewModel: MainPageViewModel!
    var disposeBag = DisposeBag()
    var arrButtons:[UIButton] = []
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.nameText.delegate = self
        if #available(iOS 13.0, *) {
            overrideUserInterfaceStyle = .light
        }
        nameText.resignFirstResponder()

        
    }
    
    func textFieldShouldReturn(userText: UITextField!) -> Bool {
        nameText.resignFirstResponder()
        return true;
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches,
                           with: event)
        self.endEditing(true)
    }
    
    @IBAction func goButtonClicked(_ sender: Any) {
        var status: String?
        if aliveCheckbox.isSelected {
            status = "alive"
        } else if deadCheckbox.isSelected {
            status = "dead"
        } else if unkownCheckbox.isSelected {
            status = "unknown"
        } else {
            status = ""
        }
        viewModel.filterMode.accept(true)
        self.viewModel.getFilterData(name: self.nameText.text, status: status)
        self.endEditing(true)
        SwiftMessages.hide()
    }
    
    @IBAction func aliveClicked(_ sender: Any) {
        self.aliveCheckbox.isSelected = true
        self.unkownCheckbox.isSelected = false
        self.deadCheckbox.isSelected = false
    }
    
    @IBAction func deadClicked(_ sender: Any) {
        self.aliveCheckbox.isSelected = false
        self.unkownCheckbox.isSelected = false
        self.deadCheckbox.isSelected = true
    }
    @IBAction func unkownClicked(_ sender: Any) {
        self.aliveCheckbox.isSelected = false
        self.unkownCheckbox.isSelected = true
        self.deadCheckbox.isSelected = false
    }
    @IBAction func ignoreClicked(_ sender: Any) {
        viewModel.filterMode.accept(false)
        self.viewModel.getData(page: 1)
        self.endEditing(true)
        SwiftMessages.hide()
        
    }
    
    
}


