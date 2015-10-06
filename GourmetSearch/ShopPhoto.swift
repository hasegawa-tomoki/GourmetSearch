import Foundation

public class ShopPhoto {
	var photos = [String: [String]]()
	var names = [String: String]()
	var gids = [String]()
	let path: String
	
	// シングルトン実装
	public class var sharedInstance: ShopPhoto? {
		struct Static {
			static let instance = ShopPhoto()
		}
		return Static.instance
	}
	
	// イニシャライザ（失敗可能）
	private init?(){
		// データ保存先パスを取得
		let paths = NSSearchPathForDirectoriesInDomains(.DocumentDirectory,
			.UserDomainMask, true)
		// 基本的には成功するが念のため要素数をチェックしてから使う
		if paths.count > 0 {
			path = paths[0] 
		} else {
			path = ""
			return nil
		}
		// UserDefaultsからデータを読み込む
		load()
	}
	
	// データを読み込む
	private func load(){
		photos.removeAll()
		names.removeAll()
		gids.removeAll()
		
		let ud = NSUserDefaults.standardUserDefaults()
		ud.registerDefaults([
			"photos": [String: [String]](),
			"names": [String: String](),
			"gids": [String]()
			])
		ud.synchronize()
		if let photos = ud.objectForKey("photos") as? [String: [String]] {
			self.photos = photos
		}
		if let names = ud.objectForKey("names") as? [String: String] {
			self.names = names
		}
		if let gids = ud.objectForKey("gids") as? [String] {
			self.gids = gids
		}
	}
	
	// データを書き込む
	private func save(){
		let ud = NSUserDefaults.standardUserDefaults()
		ud.setObject(photos, forKey: "photos")
		ud.setObject(names, forKey: "names")
		ud.setObject(gids, forKey: "gids")
		ud.synchronize()
	}
	
	// 写真を追加する
	public func append(shop shop: Shop, image: UIImage){
		// 店舗IDか店舗名が無ければ終わり
		if shop.gid == nil { return }
		if shop.name == nil { return }
		// ファイル名作成
		let filename = NSUUID().UUIDString + ".jpg"
		let fullpath = NSURL(fileURLWithPath: path).URLByAppendingPathComponent(filename).absoluteString
		// UIImageからJPEGデータ作成
		let data = UIImageJPEGRepresentation(image, 0.8)!
		// データを書き込んで成功したら配列に格納して保存
		if data.writeToFile(fullpath, atomically: true) {
			if photos[shop.gid!] == nil {
				// 初めての店舗なら準備する
				photos[shop.gid!] = [String]()
			} else {
				// 初めての店舗でなければ順番だけ変更する
				gids = gids.filter { $0 != shop.gid! }
			}
			gids.append(shop.gid!)
			// ファイル名を配列に格納
			photos[shop.gid!]?.append(filename)
			// 店舗名を格納
			names[shop.gid!] = shop.name
			// UserDefaultに保存
			save()
		}
	}
	
	// 指定された店舗・インデックスの写真を返す
	public func image(gid: String, index: Int) -> UIImage {
		if photos[gid] == nil { return UIImage() }
		if index >= photos[gid]?.count { return UIImage() }
		
		if let filename = photos[gid]?[index] {
			let fullpath = NSURL(fileURLWithPath: path).URLByAppendingPathComponent(filename).absoluteString
			
			if let image = UIImage(contentsOfFile: fullpath) {
				return image
			}
		}
		return UIImage()
	}
	
	// 店舗IDで指定された店舗の写真枚数を返す
	public func count(gid: String) -> Int {
		if photos[gid] == nil { return 0 }
		return photos[gid]!.count
	}
	
	// インデックスで指定された店舗の写真枚数を返す
	public func numberOfPhotosInIndex(index: Int) -> Int { 
		if index >= gids.count { return 0 }
		if let photos = photos[gids[index]] {
			return photos.count
		}
		return 0
	}
}