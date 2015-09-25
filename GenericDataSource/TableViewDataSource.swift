//
//  ViewController.swift
//  GenericDataSource
//
//  Created by Alan Skipp on 23/09/2015.
//  Copyright © 2015 Alan Skipp. All rights reserved.
//

import UIKit

protocol TableViewDataSection {
    typealias Item: SectionItem
    var title: String? { get }
    var items: [Item] { get }
}

struct TableSection<A: SectionItem>: TableViewDataSection  {
    typealias Item = A
    let title: String?
    let items: [Item]
}

/*
viewData `ViewDataProvider` is a generic value that is used to configure the tableViewCell
*/
protocol SectionItem {
    var cellID: String { get }
    var viewData: ViewDataProvider { get }
}

/*
TableViewCells must conform to the `Cell` protocol
They must have a `viewData` var which conforms to `ViewDataProvider`
*/
protocol Cell {
    var viewData: ViewDataProvider { get set }
}

/*
`ViewDataProvider` is a generic value that is used to configure the tableViewCell
Currently the tableViewCell must force coerce `ViewDataProvider` to the concrete type needed
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
