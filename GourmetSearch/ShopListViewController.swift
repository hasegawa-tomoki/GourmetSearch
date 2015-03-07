import UIKit

class ShopListViewController: UIViewController,
	UITableViewDelegate, UITableViewDataSource {
	
	@IBOutlet weak var tableView: UITableView!

	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view, typically from a nib.
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}

	// MARK: - UITableViewDelegate
	func tableView(tableView: UITableView,
		heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
			return 100
	}
	// MARK: - UITableViewDataSource
	func tableView(tableView: UITableView,
		numberOfRowsInSection section: Int) -> Int {
			return 20
	}
	func tableView(tableView: UITableView,
		cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
			if indexPath.section == 0 {
				let cell = tableView.dequeueReusableCellWithIdentifier("ShopListItem") as ShopListItemTableViewCell
				cell.name.text = "\(indexPath.row)"
				return cell
			}
			return UITableViewCell()
	}
}

