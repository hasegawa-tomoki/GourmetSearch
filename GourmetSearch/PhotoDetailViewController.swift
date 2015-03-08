import UIKit

class PhotoDetailViewController: UIViewController, UIScrollViewDelegate {
	@IBOutlet weak var scrollView: UIScrollView!
	@IBOutlet weak var photo: UIImageView!
	
	var image: UIImage = UIImage()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		photo.alpha = 0
		photo.image = image
	}
	
	override func viewDidLayoutSubviews() {
		scrollView.contentInset.top = (scrollView.bounds.size.height -
			photo.bounds.size.height) / 2.0
		scrollView.contentInset.bottom = (scrollView.bounds.size.height -
			photo.bounds.size.height) / 2.0
		
		scrollView.setZoomScale(1, animated: false)
		scrollView.minimumZoomScale = 1
		scrollView.maximumZoomScale = 3
	}
	
	override func viewDidAppear(animated: Bool) {
		UIView.animateWithDuration(0.1, animations: {
			self.photo.alpha = 1
		})
	}
	
	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
	}
	
	// MARK: - UIScrollViewDelegate
	func viewForZoomingInScrollView(scrollView: UIScrollView) -> UIView? {
		return photo
	}
}
