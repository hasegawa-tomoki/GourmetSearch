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

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
