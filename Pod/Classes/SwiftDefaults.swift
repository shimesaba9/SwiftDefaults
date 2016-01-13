import Foundation

public class SwiftDefaults: NSObject {
    let userDefaults = NSUserDefaults.standardUserDefaults()
    
    public override init() {
        super.init()
        
        registerDefaults()
        setupProperty()
        addObserver()
    }
    
    private func registerDefaults() {
        let dic = propertyNames.reduce([String:AnyObject]()) { (var dic, key) -> [String:AnyObject] in
            dic[key] = valueForKey(key)
            return dic
        }
        userDefaults.registerDefaults(dic)
    }
    
    private func setupProperty() {
        propertyNames.forEach {
            setValue(userDefaults.objectForKey($0), forKey: $0)
        }
    }
    
    private func addObserver() {
        propertyNames.forEach {
            addObserver(self, forKeyPath: $0, options: .New, context: nil)
        }
    }
    
    private var propertyNames: [String] {
        return Mirror(reflecting: self).children.flatMap { $0.label }
    }
    
    override public func observeValueForKeyPath(keyPath: String?, ofObject object: AnyObject?, change: [String : AnyObject]?, context: UnsafeMutablePointer<Void>) {
        
        if let keyPath = keyPath {
            userDefaults.setObject(change?["new"], forKey: keyPath)
        }
    }
}
