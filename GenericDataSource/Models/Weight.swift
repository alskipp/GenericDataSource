//
//  Weight.swift
//  GenericDataSource
//
//  Created by Alan Skipp on 25/09/2015.
//  Copyright © 2015 Alan Skipp. All rights reserved.
//

enum Mass: String { case kg, Pounds }

struct Weight { let value: Double, unit: Mass }

extension Weight: CustomStringConvertible {
    var description: String { return "\(value) \(unit)" }
}
