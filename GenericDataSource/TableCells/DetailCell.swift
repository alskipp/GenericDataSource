//
//  DetailCell.swift
//  GenericDataSource
//
//  Created by Alan Skipp on 23/09/2015.
//  Copyright © 2015 Alan Skipp. All rights reserved.
//

import UIKit

final class DetailCell: UITableViewCell, Cell {
    
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var detailLabel: UILabel!
    
    struct ViewData: ViewDataProvider {
        let title: String
        let detail: String
        
        init(title: String = "", detail: String = "") {
            self.title = title
            self.detail = detail
        }
    }
    
    var viewData: ViewDataProvider = ViewData() {
        didSet {
            let data = viewData as! ViewData
            titleLabel.text = data.title
            detailLabel.text = data.detail
        }
    }
}
