//
//  Height.swift
//  GenericDataSource
//
//  Created by Alan Skipp on 25/09/2015.
//  Copyright © 2015 Alan Skipp. All rights reserved.
//

enum Length: String { case cm, Inches}

struct Height { let value: Double, unit: Length }

extension Height: CustomStringConvertible {
    var description: String { return "\(value) \(unit)" }
}
