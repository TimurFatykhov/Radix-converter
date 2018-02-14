//
//  Convertion.swift
//  Converter
//
//  Created by Sergey Suslov on 06/02/2018.
//  Copyright © 2018 Fatykhov&Suslov. All rights reserved.
//
import UIKit
import Realm
import RealmSwift

class Convertion: Object {
    @objc dynamic var srcNumber = ""
    @objc dynamic var dstNumber = ""
    @objc dynamic var srcBase = 0
    @objc dynamic var dstBase = 0
    @objc dynamic var date = Date()

    init(srcNumber: String, dstNumber: String, srcBase: Int, dstBase: Int, date: Date) {
        super.init()
        self.srcNumber = srcNumber
        self.srcBase = srcBase
        self.dstNumber = dstNumber
        self.dstBase = dstBase
        self.date = date
    }
    
    required init() {
        super.init()
    }
    
    required init(realm: RLMRealm, schema: RLMObjectSchema) {
        super.init(realm: realm, schema: schema)
    }
    
    required init(value: Any, schema: RLMSchema) {
        super.init(value: value, schema: schema)
    }
    
    
    
}
