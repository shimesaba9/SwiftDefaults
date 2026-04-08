import Foundation

open class SwiftDefaults: NSObject {
    let userDefaults: UserDefaults
    
    public init(suiteName: String? = nil) {
        if let suiteName {
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
    override open func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey: Any]?, context: UnsafeMutableRawPointer?) {
        if let keyPath {
            let key = NSKeyValueChangeKey(rawValue: "new")
            if let value = change?[key], !(value is NSNull) {
                do {
                    userDefaults.set(value is NSCoding ? try NSKeyedArchiver.archivedData(withRootObject: value, requiringSecureCoding: false) : value, forKey: storeKey(keyPath))
                } catch {}
            } else {
                userDefaults.removeObject(forKey: storeKey(keyPath))
            }
            
            userDefaults.synchronize()
        }
    }
}

extension SwiftDefaults {
    fileprivate func storeKey(_ propertyName: String) -> String {
        return "\(type(of: self))_\(propertyName)"
    }
    
    fileprivate func valueForStorage(_ value: Any) -> Any? {
        return if PropertyListSerialization.propertyList(value, isValidFor: .binary) {
            value
        } else if value is NSCoding {
            try? NSKeyedArchiver.archivedData(withRootObject: value, requiringSecureCoding: false)
        } else {
            nil
        }
    }
    
    fileprivate func registerDefaults() {
        let dic = propertyNames.reduce([String: Any]()) { (dic, key) -> [String: Any] in
            var mutableDic = dic
            if let value = value(forKey: key), let valueForStorage = valueForStorage(value) {
                mutableDic[storeKey(key)] = valueForStorage
            }
            return mutableDic
        }
        userDefaults.register(defaults: dic)
    }
    
    fileprivate func setupProperty() {
        propertyNames.forEach {
            let value = userDefaults.object(forKey: storeKey($0))
            if let data = value as? Data, let decodedValue = try? NSKeyedUnarchiver.unarchivedObject(ofClasses: [NSObject.self], from: data) {
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
