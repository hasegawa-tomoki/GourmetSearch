import Foundation

public struct Favorite {
	public static var favorites = [String]()
	
	public static func load(){
		let ud = NSUserDefaults.standardUserDefaults()
		ud.registerDefaults(["favorites": [String]()])
		favorites = ud.objectForKey("favorites") as! [String]
	}
	
	public static func save(){
		let ud = NSUserDefaults.standardUserDefaults()
		ud.setObject(favorites, forKey: "favorites")
		ud.synchronize()
	}
	
	public static func add(gid: String?){
		if gid == nil || gid == "" { return }
		
		if contains(favorites, gid!) {
			remove(gid!)
		}
		favorites.append(gid!)
		save()
	}
	
	public static func remove(gid: String?){
		if gid == nil || gid == "" { return }
		
		if let index = find(favorites, gid!) {
			favorites.removeAtIndex(index)
		}
		save()
	}
	
	public static func toggle(gid: String?){
		if gid == nil || gid == "" { return }
		
		if inFavorites(gid!) {
			remove(gid!)
		} else {
			add(gid!)
		}
	}
	
	public static func inFavorites(gid: String?) -> Bool {
		if gid == nil || gid == "" { return false }
		
		return contains(favorites, gid!)
	}
	
	public static func move(sourceIndex: Int, _ destinationIndex: Int){
		if sourceIndex >= favorites.count || destinationIndex >= favorites.count {
			return
		}
		
		let srcGid = favorites[sourceIndex]
		favorites.removeAtIndex(sourceIndex)
		favorites.insert(srcGid, atIndex: destinationIndex)
		
		save()
	}
}