import UIKit
import MapKit

class ShopMapDetailViewController: UIViewController {
	@IBOutlet weak var map: MKMapView!
	@IBOutlet weak var showHereButton: UIBarButtonItem!
	
	let ls = LocationService()
	let nc = NSNotificationCenter.defaultCenter()
	var observers = [NSObjectProtocol]()
	var shop: Shop = Shop()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		// 店舗所在地を地図に反映
		if let lat = shop.lat {
			if let lon = shop.lon {
				// 地図の表示範囲を指定
				let cllc = CLLocationCoordinate2D(latitude: lat, longitude: lon)
				let mkcr = MKCoordinateRegionMakeWithDistance(cllc, 500, 500)
				map.setRegion(mkcr, animated: false)
				
				// ピンを設定
				let pin = MKPointAnnotation()
				pin.coordinate = cllc
				pin.title = shop.name
				map.addAnnotation(pin)
			}
		}
		self.navigationItem.title = shop.name
	}
	
	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
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
					// 現在地を表示ボタンを非アクティブにする
					self.showHereButton.enabled = false
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
					// 現在地を表示ボタンを非アクティブにする
					self.showHereButton.enabled = false
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
					// 現在地を表示ボタンを非アクティブにする
					self.showHereButton.enabled = false
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
							// userInfoがキーlocationを持っている
							
							if let lat = self.shop.lat {
								if let lon = self.shop.lon {
									// 店舗が位置情報を持っている→地図の表示範囲を設定する
									let center = CLLocationCoordinate2D(
										latitude: (lat + clloc.coordinate.latitude) / 2,
										longitude: (lon + clloc.coordinate.longitude) / 2
									)
									let diff = (
										lat: abs(clloc.coordinate.latitude - lat),
										lon: abs(clloc.coordinate.longitude - lon))
									
									// 表示範囲を設定する
									let mkcs = MKCoordinateSpanMake(diff.lat * 1.4, diff.lon * 1.4)
									let mkcr = MKCoordinateRegionMake(center, mkcs)
									self.map.setRegion(mkcr, animated: true)
									
									// 現在地を表示する
									self.map.showsUserLocation = true
								}
							}
						}
					}
					// [現在地を表示]ボタンをアクティブにする
					self.showHereButton.enabled = true 
			})
		)
		// 位置情報が利用可能になった場合
		observers.append( 
			nc.addObserverForName(ls.LSAuthorizedNotification,
				object: nil,
				queue: nil,
				usingBlock: {
					notification in
					
					// [現在地を表示]ボタンをアクティブにする
					self.showHereButton.enabled = true
			})
		)
	}
	
	override func viewWillDisappear(animated: Bool) {
		// 通知の待受を解除する
		for observer in observers { 
			nc.removeObserver(observer)
		}
		observers = [] 
	}
	
	// MARK: - IBAction
	@IBAction func showHereButtonTapped(sender: UIBarButtonItem) {
		ls.startUpdatingLocation()
	}
}
