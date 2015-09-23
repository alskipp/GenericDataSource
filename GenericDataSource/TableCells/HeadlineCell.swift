//
//  HeadlineCell.swift
//  GenericDataSource
//
//  Created by Alan Skipp on 23/09/2015.
//  Copyright © 2015 Alan Skipp. All rights reserved.
//

import UIKit

final class HeadlineCell: UITableViewCell, Cell {
    
    @IBOutlet private weak var titleLabel: UILabel!
    
    struct ViewData: ViewDataProvider {
        let title: String
        
        init(title: String = "") {
            self.title = title
        }
    }
    
    var viewData: ViewDataProvider = ViewData() {
        didSet {
            let data = viewData as! ViewData
            titleLabel.text = data.title
        }
    }
}
