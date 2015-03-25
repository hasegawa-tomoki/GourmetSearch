import UIKit
class AboutViewController: UIViewController,
UITableViewDelegate, UITableViewDataSource {
	@IBOutlet weak var tableView: UITableView!
	
	override func viewDidLoad() {
		super.viewDidLoad()
	}
	
	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
	}
	
	// MARK: - UITableViewDelegate
	func tableView(tableView: UITableView,
		heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
			if indexPath.row == 0 {
				return 110
			}
			return 44
	}
	// MARK: - UITableViewDataSource
	func tableView(tableView: UITableView,
		cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
			if indexPath.row == 0 {
				let cell = tableView.dequeueReusableCellWithIdentifier("AboutApp") as UITableViewCell
				return cell
			}
			let cell = tableView.dequeueReusableCellWithIdentifier("License") as UITableViewCell
			return cell
	}
	func tableView(tableView: UITableView,
		numberOfRowsInSection section: Int) -> Int {
			return 2
	}
}