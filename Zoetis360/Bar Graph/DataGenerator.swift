//
//  DataGenerator.swift
//  ChartsDemo
//
//  Created by Piotr Sochalewski on 22.03.2016.
//  Copyright © 2016 Droids On Roids. All rights reserved.
//

import Foundation

struct Sale {
    var month: String
    var value: Double
}

class DataGenerator {
    
    static var randomizedSale: Double {
        return Double(arc4random_uniform(10000) + 1) / 10
    }
    
    static func data() -> [Sale] {
        let months = ["Week1", "Week2", "Week3", "Week4", "Week5", "Week6","Week7"]
        var sales = [Sale]()
        for month in months {
            let sale = Sale(month: month, value: randomizedSale)
            sales.append(sale)
        }
        
        return sales
    }
}