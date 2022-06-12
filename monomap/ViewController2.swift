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
    
    @IBOutlet weak var scrollView: UIScrollView!
    
//    var positionY: CGFloat!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let titles = ["月","火","水","木","金","土","日"] //タブのタイトル

        //タブの横幅
        let tabLabelWidth:CGFloat = 100
        //タブの縦幅(UIScrollViewと一緒にします)
        let tabLabelHeight:CGFloat = scrollView.frame.height

        //タブのx座標．0から始まり，少しずつずらしていく．
        var originX:CGFloat = 0
        //titlesで定義したタブを1つずつ用意していく
        for title in titles {
            //タブになるUILabelを作る
            let label = UILabel()
            label.textAlignment = .center
            label.frame = CGRect(x:originX, y:0, width:tabLabelWidth, height:tabLabelHeight)
            label.text = title

            //scrollViewにぺたっとする
            scrollView.addSubview(label)

            //次のタブのx座標を用意する
            originX += tabLabelWidth
        }

        //scrollViewのcontentSizeを，タブ全体のサイズに合わせてあげる(ここ重要！)
        //最終的なoriginX = タブ全体の横幅 になります
        scrollView.contentSize = CGSize(width:originX, height:tabLabelHeight)

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


//extension ViewController2: UIScrollViewDelegate {
//    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
//        positionY = scrollView.contentOffset.y
//    }
//
//    func scrollViewDidScroll(scrollView: UIScrollView) {
//        scrollView.contentOffset.y = positionY
//    }
//}
