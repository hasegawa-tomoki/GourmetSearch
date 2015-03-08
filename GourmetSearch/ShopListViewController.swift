import UIKit

class ShopListViewController: UIViewController,
UITableViewDelegate, UITableViewDataSource {
	
	@IBOutlet weak var tableView: UITableView!
	
	var yls: YahooLocalSearch = YahooLocalSearch()
	var loadDataObserver: NSObjectProtocol?
	
	override func viewDidLoad() {
		super.viewDidLoad()
	}
	
	override func viewWillAppear(animated: Bool) {
		super.viewWillAppear(animated)
		
		var qc = QueryCondition()
		qc.query = "ハンバーガー"
		
		yls = YahooLocalSearch(condition: qc)
		
		// 読込完了通知を受信した時の処理
		loadDataObserver = NSNotificationCenter.defaultCenter().addObserverForName(
			yls.YLSLoadCompleteNotification,
			object: nil,
			queue: nil,
			usingBlock: {
				(notification) in
				
				self.tableView.reloadData()
				
				// エラーがあればダイアログを開く
				if notification.userInfo != nil {
					if let userInfo = notification.userInfo as? [String: String!] {
						if userInfo["error"] != nil {
							let alertView = UIAlertController(title: "通信エラー",
								message: "通信エラーが発生しました。",
								preferredStyle: .Alert)
							alertView.addAction(
								UIAlertAction(title: "OK", style: .Default) {
									action in return
								}
							)
							self.presentViewController(alertView,
								animated: true, completion: nil)
						}
					}
				}
			}
		)
		
		yls.loadData(reset: true)
	}
	
	override func viewWillDisappear(animated: Bool) {
		// 通知の監視を終了
		NSNotificationCenter.defaultCenter().removeObserver(self.loadDataObserver!)
	}
	
	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
	}
	
	// MARK: - UITableViewDelegate
	func tableView(tableView: UITableView,
		heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
			return 100
	}
	// MARK: - UITableViewDataSource
	func tableView(tableView: UITableView,
		numberOfRowsInSection section: Int) -> Int {
			if section == 0 {
				// セルの数は店舗数
				return yls.shops.count
			}
			// 通常はここに到達しない
			return 0
	}
	func tableView(tableView: UITableView,
		cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
			if indexPath.section == 0 {
				if indexPath.row < yls.shops.count {
					// rowが店舗数以下なら店舗セルを返す
					let cell = tableView.dequeueReusableCellWithIdentifier("ShopListItem") as
					ShopListItemTableViewCell
					cell.shop = yls.shops[indexPath.row]
					return cell
				}
			}
			// 通常はここに到達しない
			return UITableViewCell()
	}
}

