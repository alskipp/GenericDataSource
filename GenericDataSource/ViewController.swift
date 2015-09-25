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
    let person = Person(
        name: "Fred Smith",
        birthDate: DOB(year: 1900, month: 9, day: 12),
        cash: Cash(amount: 1500, currency: .GBP),
        height: Height(value: 176, unit: .cm),
        weight: Weight(value: 65, unit: .kg),
        eyeColor: .blueColor(),
        hairColor: .brownColor()
    )
    
    lazy var tableViewDataSource: TableViewDataSource<TableSection<TableSectionItem>> = {
        return TableViewDataSource(sections: [
            TableSection(title: .None, items: [
                .Header(viewData: HeadlineCell.ViewData(title: self.person.name))
            ]),
            TableSection(title: "Details", items: [
                .Detail(viewData: DetailCell.ViewData(title: "Date of Birth:", detail: self.person.birthDate)),
                .Detail(viewData: DetailCell.ViewData(title: "Cash:", detail: self.person.cash)),
                .Detail(viewData: DetailCell.ViewData(title: "Weight:", detail: self.person.weight)),
                .Detail(viewData: DetailCell.ViewData(title: "Height:", detail: self.person.height)),
                .Color(viewData: ColorCell.ViewData(title: "Eye Color:", color: self.person.eyeColor)),
                .Color(viewData: ColorCell.ViewData(title: "Hair Color:", color: self.person.hairColor))
                ])
            ])
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = tableViewDataSource
    }
}
