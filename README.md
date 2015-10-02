Generic TableView DataSource
========

This is an experimental approach to writing a generic `UITableViewDataSource` in Swift, that handles cell creation and the various boilerplate methods:

```swift
func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String?
func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
func numberOfSectionsInTableView(tableView: UITableView) -> Int
```

The idea is to avoid reimplementing the above methods for every `UITableViewController` and to use a generic `TableViewDataSource` instead. A typical use case is a ‘details’ view where multiple properties of a single value are displayed in a tableView (potentially using several kinds of tableViewCell). To support multiple types of cell, the requirement is to declare a data structure that represents the data for each type of cell in your `TableView`. A simple example is shown below:

The Good…
---

For a `TableView` with only one type of cell, the implementation is very simple:

```swift
struct CellInfo: SectionItem {
    let cellID = "DetailCell"
    let viewData: ViewDataProvider
}

class ViewController: UITableViewController {
    let person = Person(name: "Fred Smith", age: 20, height: 176, weight: 65)
    
    lazy var tableViewDataSource: TableViewDataSource<TableSection<CellInfo>> = {
        return TableViewDataSource(sections: [
            TableSection(title: "Details", items: [
                CellInfo(viewData: DetailCell.ViewData(title: "Name:", detail: person.name)),
                CellInfo(viewData: DetailCell.ViewData(title: "Age:", detail: person.age)),
                CellInfo(viewData: DetailCell.ViewData(title: "Height:", detail: person.height)),
                CellInfo(viewData: DetailCell.ViewData(title: "Weight:", detail: person.weight))
            ])
        ])
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = tableViewDataSource
    }
}
```

The full implementation of the `DetailCell` is as follows:

```swift
final class DetailCell: UITableViewCell, Cell {
    
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var detailLabel: UILabel!
    
    struct ViewData: ViewDataProvider {
        let title: String
        let detail: String
        
        init(title: String = "", detail: CustomStringConvertible = "") {
            self.title = title
            self.detail = detail.description
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
```

![screenshot] (http://alskipp.github.io/GenericDataSource/img/tableView1.png)

* * *

A data structure that represents several types of `TableViewCell` can be written using an enum:

```swift
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
```

A full example of using a dataSource with multiple cell types is demonstrated in the Xcode project.

![screenshot] (http://alskipp.github.io/GenericDataSource/img/tableView2.png)

…The Bad & The Ugly
---

The current implementation works, but there is room for improvement. One aspect I'm unhappy with is the use of forced casts in a couple of places. One place where a forced cast is required is in any `TableCell` which implements the `Cell` protocol (take a look at the `DetailCell` shown above). The `viewData` `var` needs to be cast from the protocol `ViewDataProvider` to the specific type of `ViewData` to access its properties – it's pretty ugly.

I'd be really interested to hear any ideas on how to improve matters, should you have a cunning plan, do let me know.


Inspiration
---

The initial idea came from this [blog post](http://blog.human-friendly.com/swift-2-xcode-7-gm-at-least-generic-support-for-at-objc-protocols) by [Joseph Lord](https://twitter.com/jl_hfl). Additional ideas were gleaned from a [talk](https://realm.io/news/andy-matuschak-refactor-mega-controller/) by [Andy Matuschak](https://twitter.com/andy_matuschak).
