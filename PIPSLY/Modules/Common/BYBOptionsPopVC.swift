//
//  BYBOptionsPopVC.swift
//  PIPSLY
//
//  Created by KiwiTech on 11/12/18.
//  Copyright © 2018 PIPSLY. All rights reserved.
//

import UIKit

protocol OptionsPopDelegate:class {
    func didSelectCamera()
    func didSelectGallery()
    func didSelectRemovePhoto()
}

class BYBOptionsPopVC: BaseVC {
    
    weak var delegate:OptionsPopDelegate?
    @IBOutlet weak var mainView: UIView?
    @IBOutlet weak var topConstraint: NSLayoutConstraint?
    var isDataAvailable:Bool = true
    
    override func viewDidLoad(){
        super.viewDidLoad()
        setupView()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func setupView() {
    }
    
    @IBAction func tapCamera(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
        delay(delay: 0.2) {
            self.delegate?.didSelectCamera()
        }
    }
    
    @IBAction func tapGallery(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
        self.delegate?.didSelectGallery()
    }
    
    @IBAction func tapRemovePhoto(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
            self.delegate?.didSelectRemovePhoto()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch: UITouch? = touches.first
        if touch?.view != mainView {
            self.dismiss(animated: true, completion: nil)
        }
    }
}
