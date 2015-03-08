import UIKit
import MapKit

class ShopDetailViewController: UIViewController, UIScrollViewDelegate {
	@IBOutlet weak var scrollView: UIScrollView!
	@IBOutlet weak var photo: UIImageView!
	@IBOutlet weak var name: UILabel!
	@IBOutlet weak var tel: UILabel!
	@IBOutlet weak var address: UILabel!
	@IBOutlet weak var map: MKMapView!
	@IBOutlet weak var favoriteIcon: UIImageView!
	@IBOutlet weak var favoriteLabel: UILabel!
	
	@IBOutlet weak var nameHeight: NSLayoutConstraint!
	@IBOutlet weak var addressContainerHeight: NSLayoutConstraint!
	
	var shop = Shop()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		// 写真
		if let url = shop.photoUrl {
			photo.sd_setImageWithURL(NSURL(string: url),
				placeholderImage: UIImage(named: "loading"),
				options: nil);
		} else {
			photo.image = UIImage(named: "loading")
		}
		// 店舗名
		name.text = shop.name
		// 電話番号
		tel.text = shop.tel
		// 住所
		address.text = shop.address
		
		// お気に入り状態をボタンラベルに反映
		updateFavoriteButton()
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
	// MARK: - IBAction
	@IBAction func telTapped(sender: UIButton) {
		println("telTapped")
	}
	@IBAction func addressTapped(sender: UIButton) {
		println("addressTapped")
	}
	@IBAction func favoriteTapped(sender: UIButton) {
		// お気に入りセル: お気に入り状態を変更する
		Favorite.toggle(shop.gid)
		updateFavoriteButton()
	}
}
