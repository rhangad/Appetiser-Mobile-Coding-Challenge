//
//  UserDefault+Extensions.swift
//  Appetiser Mobile Coding Challenge
//
//  Created by Dev Partners on 3/23/19.
//  Copyright © 2019 Dev Partners. All rights reserved.
//

import Foundation

extension UserDefaults {
    
    func getSelectedRow() -> Int {
        return integer(forKey: "selectedRow")
    }
    
    func setSelectedRow(_ row: Int) {
        set(row, forKey: "selectedRow")
    }
    
    func isDetailView() -> Bool {
        return bool(forKey: "isDetailView")
    }
    
    func isDetailView(_ bool: Bool) {
        set(bool, forKey: "isDetailView")
    }
    
}
