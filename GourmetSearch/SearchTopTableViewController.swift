import UIKit

class SearchTopTableViewController: UITableViewController, UITextFieldDelegate {
	var freeword: UITextField? = nil
	
	override func viewDidLoad() {
		super.viewDidLoad()
	}
	
	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
	}
	
	// MARK: - Table view data source
	override func tableView(tableView: UITableView,
		heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
			return 44
	}
	
	// MARK: - UITableViewDataSource
	override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
		return 1
	}
	
	override func tableView(tableView: UITableView,
		numberOfRowsInSection section: Int) -> Int {
			if section == 0 {
				return 1
			}
			return 0
	}
	
	override func tableView(tableView: UITableView,
		cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
			if indexPath.section == 0 && indexPath.row == 0 {
				let cell = tableView.dequeueReusableCellWithIdentifier("Freeword",
					forIndexPath: indexPath) as FreewordTableViewCell
				// UITextFieldへの参照を保存しておく
				freeword = cell.freeword
				// UITextFieldDelegateを自身に設定
				cell.freeword.delegate = self
				// タップを無視
				cell.selectionStyle = .None
				return cell
			}
			return UITableViewCell()
	}
	
	// MARK: - UITextFieldDelegate
	func textFieldShouldReturn(textField: UITextField) -> Bool {
		textField.resignFirstResponder()
		performSegueWithIdentifier("PushShopList", sender: self)
		return true
	}
	
	// MARK: - Navigation
	override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
		if segue.identifier == "PushShopList" {
			let vc = segue.destinationViewController as ShopListViewController
			vc.yls.condition.query = freeword?.text
		}
	}
	@IBAction func onTap(sender: UITapGestureRecognizer) {
		freeword?.resignFirstResponder()
	}
}
