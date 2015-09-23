//
//  ColorCell.swift
//  GenericDataSource
//
//  Created by Alan Skipp on 23/09/2015.
//  Copyright © 2015 Alan Skipp. All rights reserved.
//

import UIKit

final class ColorCell: UITableViewCell, Cell {
    
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var colorBox: UIView!
    
    struct ViewData: ViewDataProvider {
        let title: String
        let color: UIColor
        
        init(title: String = "", color: UIColor = UIColor.whiteColor()) {
            self.title = title
            self.color = color
        }
    }
    
    var viewData: ViewDataProvider = ViewData() {
        didSet {
            let data = viewData as! ViewData
            titleLabel.text = data.title
            colorBox.backgroundColor = data.color
        }
    }
}
