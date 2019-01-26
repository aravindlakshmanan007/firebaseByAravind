//
//  category.swift
//  firebaseByAravind
//
//  Created by Aravind on 26/01/19.
//  Copyright © 2019 Aravind. All rights reserved.
//

import Foundation
import  RealmSwift
class Category : Object{
    @objc dynamic var name:String = ""
    let items = List<Item>()
}
