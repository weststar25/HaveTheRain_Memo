//
//  MemoVO.swift
//  HaveTheRain_Memo
//
//  Created by 김지우 on 16/02/2020.
//  Copyright © 2020 김지우. All rights reserved.
//

import Foundation
import Realm
import RealmSwift

class MemoVO: Object {
    @objc dynamic var title: String = ""
    @objc dynamic var content: String = ""
    @objc dynamic var images: [UIImage] = []
}
