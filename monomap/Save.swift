//
//  Save.swift
//  monomap
//
//  Created by 中島詩草 on 2022/05/08.
//

import Foundation
import RealmSwift

class  Pin: Object {
    // 緯度
    @objc dynamic var latitude = ""
    
    // 経度
    @objc dynamic var longitude = ""
    
    
    @objc dynamic var type = ""
 }
