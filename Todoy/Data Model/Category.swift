//
//  Category.swift
//  Todoy
//
//  Created by Mohamed on 1/26/21.
//  Copyright © 2021 Mohamed. All rights reserved.
//

import Foundation
import RealmSwift
class Category: Object {
    @objc dynamic var name : String = ""
    let Items = List<Item>()
}
