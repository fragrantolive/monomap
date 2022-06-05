//
//  ViewController2.swift
//  monomap
//
//  Created by 中島詩草 on 2022/01/16.
//

import UIKit
import MapKit
import RealmSwift

class ViewController2: UIViewController {
 
    var delegate: ViewController?
    
    @IBOutlet weak var button1: UIButton!
    @IBOutlet weak var button2: UIButton!
    @IBOutlet weak var button3: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewDidLayoutSubviews() {
           super.viewDidLayoutSubviews()
        self.button1.backgroundColor = UIColor.systemGray
        self.button2.backgroundColor = UIColor.systemGray
        self.button3.backgroundColor = UIColor.systemGray
        
           //角丸の程度を指定
           self.button1.layer.cornerRadius = 35.0
        self.button2.layer.cornerRadius = 35.0
        self.button3.layer.cornerRadius = 35.0
          
       }
    
    @IBAction func toilet() {
        delegate?.switchMarker(type: "toilet")
    }

    @IBAction func dustbox() {
        delegate?.switchMarker(type: "dustbox")
    }

    @IBAction func jihanki() {
        delegate?.switchMarker(type: "vendingmachine")
    }
}
