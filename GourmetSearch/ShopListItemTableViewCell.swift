import UIKit

class ShopListItemTableViewCell: UITableViewCell {
	@IBOutlet weak var photo: UIImageView!
	@IBOutlet weak var name: UILabel!
	@IBOutlet weak var iconContainer: UIView!
	@IBOutlet weak var coupon: UILabel!
	@IBOutlet weak var station: UILabel!
	
	@IBOutlet weak var nameHeight: NSLayoutConstraint!
	@IBOutlet weak var stationWidth: NSLayoutConstraint!
	@IBOutlet weak var stationX: NSLayoutConstraint!
	
	var shop: Shop = Shop() {
		didSet {
			// URLがあれば画像を表示する
			if let url = shop.photoUrl {
				photo.sd_cancelCurrentAnimationImagesLoad()
				photo.sd_setImageWithURL(
					NSURL(string: url),
					placeholderImage: UIImage(named: "loading"),
					options: .RetryFailed)
			}
			// 店舗名をラベルに設定
			name.text = shop.name
			// クーポン表示
			var x: CGFloat = 0
			let margin: CGFloat = 10
			if shop.hasCoupon {
				coupon.hidden = false
				x += coupon.frame.size.width + margin
				// ラベルを角丸にする
				coupon.layer.cornerRadius = 4
				coupon.clipsToBounds = true
			} else {
				coupon.hidden = true
			}
			// 駅表示
			if shop.station != nil {
				station.hidden = false
				station.text = shop.station
				// ラベルの位置を設定する
				stationX.constant = x
				// ラベルの幅を計算する
				let size = station.sizeThatFits(CGSizeMake(CGFloat.max, CGFloat.max))
				if x + size.width + margin > iconContainer.frame.width {
					// ラベルの幅が右端を越える場合最大サイズを設定する
					stationWidth.constant = iconContainer.frame.width - x
				} else {
					// ラベルの幅が右端を越えない場合そのまま設定する
					stationWidth.constant = size.width + margin
				}
				// ラベルを角丸にする
				station.clipsToBounds = true
				station.layer.cornerRadius = 4
			} else {
				station.hidden = true
			}
		}
	}
	
	override func awakeFromNib() {
		super.awakeFromNib()
	}
	
	override func setSelected(selected: Bool, animated: Bool) {
		super.setSelected(selected, animated: animated)
	}
	
	override func layoutSubviews() {
		super.layoutSubviews()
		// 行数を最大2行に限定してラベルの高さを計算する。
		let maxFrame = CGRectMake(0, 0, name.frame.size.width, CGFloat.max)
		let actualFrame = name.textRectForBounds(maxFrame, limitedToNumberOfLines: 2)
		// 計算したサイズを設定する
		nameHeight.constant = actualFrame.size.height
	}
}
