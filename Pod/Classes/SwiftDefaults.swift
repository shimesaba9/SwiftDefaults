import Foundation

open class SwiftDefaults: NSObject {
    let userDefaults: UserDefaults

    public init(suiteName: String? = nil) {
        if let suiteName = suiteName {
            userDefaults = UserDefaults(suiteName: suiteName) ?? UserDefaults.standard
        } else {
            userDefaults = UserDefaults.standard
        }
        
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
    override open func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if let keyPath = keyPath {
            let key = NSKeyValueChangeKey(rawValue: "new")
            if let value = change?[key], !(value is NSNull) {
                do {
                    userDefaults.set(value is NSCoding ? try NSKeyedArchiver.archivedData(withRootObject: value, requiringSecureCoding: false) : value, forKey: storeKey(keyPath))
                } catch {}
            }else{
                userDefaults.removeObject(forKey: storeKey(keyPath))
            }

            userDefaults.synchronize()
        }
    }
}

extension SwiftDefaults {
    fileprivate func storeKey(_ propertyName: String) -> String{
        return "\(type(of: self))_\(propertyName)"
    }

    fileprivate func registerDefaults() {
        let dic = propertyNames.reduce([String:AnyObject]()) { (dic, key) -> [String:AnyObject] in
            var mutableDic = dic
            mutableDic[storeKey(key)] = value(forKey: key) as AnyObject?
            return mutableDic
        }
        userDefaults.register(defaults: dic)
    }

    fileprivate func setupProperty() {
        propertyNames.forEach {
            let value = userDefaults.object(forKey: storeKey($0))
            if let data = value as? Data, let decodedValue = try? NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data) {
                setValue(decodedValue, forKey: $0)
            } else {
                setValue(value, forKey: $0)
            }
        }
    }

    fileprivate func addObserver() {
        propertyNames.forEach {
            addObserver(self, forKeyPath: $0, options: .new, context: nil)
        }
    }

    fileprivate func removeObserver() {
        propertyNames.forEach {
            removeObserver(self, forKeyPath: $0)
        }
    }

    fileprivate var propertyNames: [String] {
        return Mirror(reflecting: self).children.compactMap { $0.label }
    }
}
