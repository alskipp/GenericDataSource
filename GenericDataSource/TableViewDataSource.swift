//
//  ViewController.swift
//  GenericDataSource
//
//  Created by Alan Skipp on 23/09/2015.
//  Copyright © 2015 Alan Skipp. All rights reserved.
//

import UIKit

/*
`TableViewDataSection` has an Optional title and an Array of items conforming to `SectionItem`.
Each `SectionItem` contains the data for a row in the TableView.
*/
protocol TableViewDataSection {
    typealias Item: SectionItem
    var title: String? { get }
    var items: [Item] { get }
}

struct TableSection<Item: SectionItem>: TableViewDataSection  {
    let title: String?
    let items: [Item]
}

/*
`SectionItem` represents a single row in the DataSource.
`ViewDataProvider` is a value that contains all the data required to configure the TableViewCell.
*/
protocol SectionItem {
    var cellID: String { get }
    var viewData: ViewDataProvider { get }
}

/*
TableViewCells must conform to the `Cell` protocol to allow the `TableViewDataSource` 
to pass `viewData` values from each `SectionItem` to each TableViewCell.
*/
protocol Cell {
    var viewData: ViewDataProvider { get set }
}

/*
TableViewCells use `ViewDataProvider` values to configure their appearance.
Currently the tableViewCell must force coerce `ViewDataProvider` to the concrete type needed.
Take a look at `DetailCell` for an example.
*/
protocol ViewDataProvider {}


class TableViewDataSource<A: TableViewDataSection> : NSObject, UITableViewDataSource {
    var sections: [A]
    
    init(sections: [A]) { self.sections = sections }
    
    @objc func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let rowInfo = sections[indexPath.section].items[indexPath.row]
        let cellId = rowInfo.cellID
        var cell = tableView.dequeueReusableCellWithIdentifier(cellId, forIndexPath: indexPath) as! Cell
        cell.viewData = rowInfo.viewData
        
        return cell as! UITableViewCell
    }
    
    @objc func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sections[section].title
    }
    
    @objc func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections[section].items.count
    }
    
    @objc func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return sections.count
    }
}
