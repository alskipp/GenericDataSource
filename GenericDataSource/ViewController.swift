//
//  ViewController.swift
//  GenericDataSource
//
//  Created by Alan Skipp on 23/09/2015.
//  Copyright © 2015 Alan Skipp. All rights reserved.
//

import UIKit

enum TableSectionItem: SectionItem {
    case Header(viewData: HeadlineCell.ViewData)
    case Detail(viewData: DetailCell.ViewData)
    case Color(viewData: ColorCell.ViewData)
    
    var cellID: String {
        switch self {
        case .Header: return CellID.HeadlineCell.rawValue
        case .Detail: return CellID.DetailCell.rawValue
        case .Color: return CellID.ColorCell.rawValue
        }
    }
    
    var viewData: ViewDataProvider {
        switch self {
        case let .Header(viewData): return viewData as ViewDataProvider
        case let .Detail(viewData): return viewData as ViewDataProvider
        case let .Color(viewData): return viewData as ViewDataProvider
        }
    }
}

enum CellID: String { case HeadlineCell, DetailCell, ColorCell }

class ViewController: UITableViewController {
    let person = Person(name: "Fred Smith", age: 20, height: 176, weight: 65, eyeColor: .blueColor(), hairColor: .brownColor())
    
    let tableViewDataSource: TableViewDataSource<TableSection<TableSectionItem>> = TableViewDataSource()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let sections: [TableSection<TableSectionItem>] = [
            TableSection(title: .None, items: [
                .Header(viewData: HeadlineCell.ViewData(title: person.name))
                ]),
            TableSection(title: "Details", items: [
                .Detail(viewData: DetailCell.ViewData(title: "Age:", detail: person.age.description)),
                .Detail(viewData: DetailCell.ViewData(title: "Weight:", detail: person.weight.description)),
                .Detail(viewData: DetailCell.ViewData(title: "Height:", detail: person.height.description)),
                .Color(viewData: ColorCell.ViewData(title: "Eye Color:", color: person.eyeColor)),
                .Color(viewData: ColorCell.ViewData(title: "Hair Color:", color: person.hairColor))
                ])
        ]
        
        tableViewDataSource.sections = sections
        tableView.dataSource = tableViewDataSource
    }
}

