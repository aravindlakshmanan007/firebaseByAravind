//
//  item.swift
//  firebaseByAravind
//
//  Created by Aravind on 26/01/19.
//  Copyright © 2019 Aravind. All rights reserved.
//

import Foundation
import RealmSwift

class Item : Object{
    @objc dynamic var done : Bool = false
    @objc dynamic var title : String = ""
    @objc dynamic var date :Date?
    var parentCategory = LinkingObjects(fromType: Category.self, property: "items")
}
