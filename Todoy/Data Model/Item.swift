//
//  Item.swift
//  Todoy
//
//  Created by Mohamed on 1/26/21.
//  Copyright © 2021 Mohamed. All rights reserved.
//

import Foundation
import RealmSwift
class Item: Object {
    @objc dynamic var title : String = ""
    @objc dynamic var done : Bool = false
    @objc dynamic var dateCreated : Date? = Date()
    let parentCategory = LinkingObjects(fromType:Category.self ,property:"Items" )
}

