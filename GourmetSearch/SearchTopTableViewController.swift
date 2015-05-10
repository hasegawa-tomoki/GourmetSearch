import UIKit
import CoreLocation

class SearchTopTableViewController: UITableViewController, UITextFieldDelegate,
UIGestureRecognizerDelegate {
	
	var freeword: UITextField? = nil
	
	let ls = LocationService()
	let nc = NSNotificationCenter.defaultCenter()
	var observers = [NSObjectProtocol]()
	var here: (lat: Double, lon: Double)? = nil
	
	override func viewDidLoad() {
		super.viewDidLoad()
	}
	
	override func viewWillAppear(animated: Bool) {
		// 位置情報取得を禁止している場合
		observers.append(
			nc.addObserverForName(ls.LSAuthDeniedNotification,
				object: nil,
				queue: nil,
				usingBlock: {
					notification in
					// 位置情報がONになっていないダイアログ表示
					self.presentViewController(self.ls.locationServiceDisabledAlert,
						animated: true,
						completion: nil)
			})
		)
		// 位置情報取得を制限している場合
		observers.append(
			nc.addObserverForName(ls.LSAuthRestrictedNotification,
				object: nil,
				queue: nil,
				usingBlock: {
					notification in
					// 位置情報が制限されているダイアログ表示
					self.presentViewController(self.ls.locationServiceRestrictedAlert,
						animated: true,
						completion: nil)
			})
		)
		// 位置情報取得に失敗した場合
		observers.append(
			nc.addObserverForName(ls.LSDidFailLocationNotification,
				object: nil,
				queue: nil,
				usingBlock: {
					notification in
					// 位置情報取得に失敗したダイアログ
					self.presentViewController(self.ls.locationServiceDidFailAlert,
						animated: true,
						completion: nil)
			})
		)
		// 位置情報を取得した場合
		observers.append(
			nc.addObserverForName(ls.LSDidUpdateLocationNotification,
				object: nil,
				queue: nil,
				usingBlock: {
					notification in
					if let userInfo = notification.userInfo as? [String: CLLocation] {
						// userInfoが[String: CLLocation]の形をしている
						if let clloc = userInfo["location"] {
							self.here = (lat: clloc.coordinate.latitude, 
								lon: clloc.coordinate.longitude)
							self.performSegueWithIdentifier("PushShopListFromHere", 
								sender: self)
						}
					}
			})
		)
	}
	
	override func viewWillDisappear(animated: Bool) {
		// Notificationの待ち受けを解除する
		for observer in observers {
			nc.removeObserver(observer)
		}
		observers = []
	}
	
	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
	}
	
	// MARK: - UITableViewDelegate
	override func tableView(tableView: UITableView,
		didSelectRowAtIndexPath indexPath: NSIndexPath) {
			if indexPath.section == 0 && indexPath.row == 1 {
				ls.startUpdatingLocation()
				tableView.deselectRowAtIndexPath(indexPath, animated: true)
			}
	}
	
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
			switch section {
			case 0:
				return 2
			default:
				return 0
			}
	}
	
	override func tableView(tableView: UITableView,
		cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
			
			if indexPath.section == 0 {
				switch indexPath.row {
				case 0:
					let cell = tableView.dequeueReusableCellWithIdentifier("Freeword",
						forIndexPath: indexPath) as! FreewordTableViewCell
					// UITextFieldへの参照を保存しておく
					freeword = cell.freeword
					// UITextFieldDelegateを自身に設定
					cell.freeword.delegate = self
					// タップを無視
					cell.selectionStyle = .None
					return cell
				case 1:
					let cell = UITableViewCell()
					cell.textLabel?.text = "現在地から検索"
					cell.accessoryType = .DisclosureIndicator
					return cell
				default:
					return UITableViewCell()
				}
			}
			return UITableViewCell()
	}
	
	// MARK: - UITextFieldDelegate
	func textFieldShouldReturn(textField: UITextField) -> Bool {
		textField.resignFirstResponder()
		performSegueWithIdentifier("PushShopList", sender: self)
		return true
	}
	
	// MARK: - UIGestureRecognizerDelegate
	func gestureRecognizer(gestureRecognizer: UIGestureRecognizer,
		shouldReceiveTouch touch: UITouch) -> Bool {
			if let ifr = freeword?.isFirstResponder() {
				return ifr
			}
			return false
	}
	
	// MARK: - Navigation
	override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
		if segue.identifier == "PushShopList" {
			let vc = segue.destinationViewController as! ShopListViewController
			vc.yls.condition.query = freeword?.text
		}
		if segue.identifier == "PushShopListFromHere" {
			let vc = segue.destinationViewController as! ShopListViewController
			vc.yls.condition.lat = self.here?.lat
			vc.yls.condition.lon = self.here?.lon
		}
	}
	
	@IBAction func onTap(sender: UITapGestureRecognizer) {
		freeword?.resignFirstResponder()
	}
}
