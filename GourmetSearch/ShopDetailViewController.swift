import UIKit
import MapKit
import Social

class ShopDetailViewController: UIViewController, UIScrollViewDelegate,
UIImagePickerControllerDelegate, UINavigationControllerDelegate {
	
	@IBOutlet weak var scrollView: UIScrollView!
	@IBOutlet weak var photo: UIImageView!
	@IBOutlet weak var name: UILabel!
	@IBOutlet weak var tel: UILabel!
	@IBOutlet weak var address: UILabel!
	@IBOutlet weak var map: MKMapView!
	@IBOutlet weak var favoriteIcon: UIImageView!
	@IBOutlet weak var favoriteLabel: UILabel!
	@IBOutlet weak var line: UIButton!
	@IBOutlet weak var twitter: UIButton!
	@IBOutlet weak var facebook: UIButton!
	
	@IBOutlet weak var nameHeight: NSLayoutConstraint!
	@IBOutlet weak var addressContainerHeight: NSLayoutConstraint!
	
	var shop = Shop()
	let ipc = UIImagePickerController()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		// 写真
		if let url = shop.photoUrl {
			photo.sd_setImageWithURL(NSURL(string: url),
				placeholderImage: UIImage(named: "loading"));
		} else {
			photo.image = UIImage(named: "loading")
		}
		// 店舗名
		name.text = shop.name
		// 電話番号
		tel.text = shop.tel
		// 住所
		address.text = shop.address
		
		// 地図
		if let lat = shop.lat {
			if let lon = shop.lon {
				// 地図の表示範囲を指定
				let cllc = CLLocationCoordinate2D(latitude: lat, longitude: lon)
				let mkcr = MKCoordinateRegionMakeWithDistance(cllc, 200, 200)
				map.setRegion(mkcr, animated: false)
				// ピンを設定
				let pin = MKPointAnnotation()
				pin.coordinate = cllc
				map.addAnnotation(pin)
			}
		}
		
		// お気に入り状態をボタンラベルに反映
		updateFavoriteButton()
		
		// UIImagePickerControllerDelegateの設定
		// Delegate設定
		ipc.delegate = self
		// トリミングなどを行う
		ipc.allowsEditing = true
		
		// Facebook, Twitter, LINEの利用可能状態をチェック
		if UIApplication.sharedApplication().canOpenURL(NSURL(string: "line://")!) {
			line.enabled = true
		}
		if SLComposeViewController.isAvailableForServiceType(SLServiceTypeTwitter) {
			twitter.enabled = true
		}
		if SLComposeViewController.isAvailableForServiceType(SLServiceTypeFacebook) {
			facebook.enabled = true
		}
	}
	
	override func viewWillAppear(animated: Bool) {
		self.scrollView.delegate = self
		super.viewWillAppear(animated)
	}
	
	override func viewDidDisappear(animated: Bool) {
		self.scrollView.delegate = nil
		super.viewDidDisappear(animated)
	}
	
	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
	}
	
	override func viewDidLayoutSubviews() {
		let nameFrame = name.sizeThatFits(
			CGSizeMake(name.frame.size.width, CGFloat.max))
		nameHeight.constant = nameFrame.height
		
		let addressFrame = address.sizeThatFits(
			CGSizeMake(address.frame.size.width, CGFloat.max))
		addressContainerHeight.constant = addressFrame.height
	}
	
	// MARK: - UIScrollViewDelegate
	func scrollViewDidScroll(scrollView: UIScrollView) {
		let scrollOffset = scrollView.contentOffset.y + scrollView.contentInset.top
		if scrollOffset <= 0 {
			photo.frame.origin.y = scrollOffset
			photo.frame.size.height = 200 - scrollOffset
		}
	}
	
	// MARK: - UIImagePickerControllerDelegate
	func imagePickerControllerDidCancel(picker: UIImagePickerController) {
		ipc.dismissViewControllerAnimated(true, completion: nil)
	}
	func imagePickerController(picker: UIImagePickerController,
		didFinishPickingMediaWithInfo info: [String : AnyObject]) {
			
			if let image = info[UIImagePickerControllerEditedImage] as? UIImage {
				ShopPhoto.sharedInstance?.append(shop: shop, image: image)
			}
			ipc.dismissViewControllerAnimated(true, completion: nil)
	}
	
	// MARK: - Navigation
	override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
		if segue.identifier == "PushMapDetail" {
			let vc = segue.destinationViewController as! ShopMapDetailViewController
			vc.shop = shop
		}
	}
	
	// MARK: - アプリケーションロジック
	func updateFavoriteButton(){
		if Favorite.inFavorites(shop.gid) {
			// お気に入りに入っている
			favoriteIcon.image = UIImage(named: "star-on")
			favoriteLabel.text = "お気に入りからはずす"
		} else {
			// お気に入りに入っていない
			favoriteIcon.image = UIImage(named: "star-off")
			favoriteLabel.text = "お気に入りに入れる"
		}
	}
	
	// MARK: - アプリケーションロジック
	func share(type: String){
		let vc = SLComposeViewController(forServiceType: type)
		if let name = shop.name {
			vc.setInitialText(name + "\n")
		}
		if let gid = shop.gid {
			if ShopPhoto.sharedInstance?.count(gid) > 0 {
				// 写真があれば追加する
				vc.addImage(ShopPhoto.sharedInstance?.image(gid, index: 0))
			}
		}
		if let url = shop.url {
			// URLを作って追加する
			vc.addURL(NSURL(string: url))
		}
		
		self.presentViewController(vc, animated: true, completion: nil)
	}
	
	// MARK: - IBAction
	@IBAction func telTapped(sender: UIButton) {
		if let tel = shop.tel {
			let url = NSURL(string: "tel:\(tel)")
			if (url == nil){ return }
			
			if !UIApplication.sharedApplication().canOpenURL(url!) {
				let alert = UIAlertController(title: "電話をかけることができません",
					message: "この端末には電話機能が搭載されていません。",
					preferredStyle: .Alert)
				alert.addAction(
					UIAlertAction(title: "OK", style: .Default, handler: nil)
				)
				presentViewController(alert, animated: true, completion: nil)
				return
			}
			
			if let name = shop.name {
				let alert = UIAlertController(title: name,
					message: "\(name)に電話をかけます。",
					preferredStyle: .Alert)
				
				alert.addAction(
					UIAlertAction(title: "電話をかける", style: .Destructive, handler: {
						action in
						UIApplication.sharedApplication().openURL(url!)
						return
					})
				)
				alert.addAction(
					UIAlertAction(title: "キャンセル", style: .Cancel, handler: nil)
				)
				presentViewController(alert, animated: true, completion: nil)
			}
		}
	}
	
	@IBAction func addressTapped(sender: UIButton) {
		performSegueWithIdentifier("PushMapDetail", sender: nil)
	}
	
	@IBAction func favoriteTapped(sender: UIButton) {
		// お気に入りセル: お気に入り状態を変更する
		Favorite.toggle(shop.gid)
		updateFavoriteButton()
	}
	
	@IBAction func addPhotoTapped(sender: UIBarButtonItem) {
		let alert = UIAlertController(title: nil,
			message: nil, preferredStyle: .ActionSheet)
		// カメラが使えるか確認して使えるなら「写真を撮る」選択肢を表示
		if UIImagePickerController.isSourceTypeAvailable(.Camera) {
			alert.addAction(
				UIAlertAction(title: "写真を撮る", style: .Default, handler: {
					action in
					// ソースはカメラ
					self.ipc.sourceType = .Camera
					// カメラUIを起動
					self.presentViewController(self.ipc, animated: true, completion: nil)
				})
			)
		}
		// 「写真を選択」ボタンはいつでも使える
		alert.addAction(
			UIAlertAction(title: "写真を選択", style: .Default, handler: {
				action in
				// ソースは写真選択
				self.ipc.sourceType = .PhotoLibrary
				// 写真選択UIを起動
				self.presentViewController(self.ipc, animated: true, completion: nil)
			})
		)
		alert.addAction(
			UIAlertAction(title: "キャンセル", style: .Cancel, handler: {
				action in
			})
		)
		presentViewController(alert, animated: true, completion: nil) 
	}
	@IBAction func lineTapped(sender: UIButton) {
		var message = ""
		if let name = shop.name {
			message += name + "\n"
		}
		if let url = shop.url {
			message += url + "\n"
		}
		if let encoded = message.stringByAddingPercentEncodingWithAllowedCharacters(.URLQueryAllowedCharacterSet()) {
				if let uri = NSURL(string: "line://msg/text/" + encoded) {
					UIApplication.sharedApplication().openURL(uri)
				}
		}
	}
	@IBAction func twitterTapped(sender: UIButton) {
		share(SLServiceTypeTwitter)
	}
	@IBAction func facebookTapped(sender: UIButton) {
		share(SLServiceTypeFacebook)
	}
}
