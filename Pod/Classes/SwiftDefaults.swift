import Foundation

public class SwiftDefaults: NSObject {
    let userDefaults = NSUserDefaults.standardUserDefaults()
    
    public override init() {
        super.init()
        
        registerDefaults()
        setupProperty()
        addObserver()
    }
    
    deinit {
        removeObserver()
    }
}

extension SwiftDefaults {
    override public func observeValueForKeyPath(keyPath: String?, ofObject object: AnyObject?, change: [String : AnyObject]?, context: UnsafeMutablePointer<Void>) {
        if let keyPath = keyPath {
            if let value = change?["new"] where !(value is NSNull) {
                userDefaults.setObject(value is NSCoding ? NSKeyedArchiver.archivedDataWithRootObject(value) : value, forKey: storeKey(keyPath))
            }else{
                userDefaults.removeObjectForKey(storeKey(keyPath))
            }

            userDefaults.synchronize()
        }
    }
}

extension SwiftDefaults {
    private func storeKey(propertyName: String) -> String{
        return "\(self.dynamicType)_\(propertyName)"
    }
    
    private func registerDefaults() {
        let dic = propertyNames.reduce([String:AnyObject]()) { (var dic, key) -> [String:AnyObject] in
            dic[storeKey(key)] = valueForKey(key)
            return dic
        }
        userDefaults.registerDefaults(dic)
    }
    
    private func setupProperty() {
        propertyNames.forEach {
            let value = userDefaults.objectForKey(storeKey($0))
            if let data = value as? NSData, decodedValue = NSKeyedUnarchiver.unarchiveObjectWithData(data){
                setValue(decodedValue, forKey: $0)
            }else{
                setValue(value, forKey: $0)
            }
        }
    }
    
    private func addObserver() {
        propertyNames.forEach {
            addObserver(self, forKeyPath: $0, options: .New, context: nil)
        }
    }
    
    private func removeObserver() {
        propertyNames.forEach {
            removeObserver(self, forKeyPath: $0)
        }
    }
    
    private var propertyNames: [String] {
        return Mirror(reflecting: self).children.flatMap { $0.label }
    }
}


