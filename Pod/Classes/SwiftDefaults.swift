import Foundation
import SwiftUI

open class SwiftDefaults: NSObject {
    private static var instances: [ObjectIdentifier: SwiftDefaults] = [:]
    let userDefaults: UserDefaults
    
    public static var shared: Self {
        let id = ObjectIdentifier(self)
        print(#function, id, type(of: self))
        if let instance = instances[id] as? Self {
            print(#function, 1)
            return instance
        }
        print(#function, 2)
        let newInstance = self.init()
        instances[id] = newInstance
        return newInstance
    }
    
    public required init(suiteName: String? = nil) {
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
            if let value = change?[.newKey], !(value is NSNull) {
                if let valueForStorage = valueForStorage(value) {
                    userDefaults.set(valueForStorage, forKey: storeKey(keyPath))
                }
            } else {
                userDefaults.removeObject(forKey: storeKey(keyPath))
            }
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

public class AppDefaultObserver<Store: SwiftDefaults, Value>: ObservableObject {
    public var value: Value {
        get { store[keyPath: keyPath] }
        set { store[keyPath: keyPath] = newValue }
    }
    
    private let keyPath: ReferenceWritableKeyPath<Store, Value>
    private let store: Store
    private var observation: NSKeyValueObservation?
    
    public init(keyPath: ReferenceWritableKeyPath<Store, Value>, store: Store) {
        self.keyPath = keyPath
        self.store = store
        
        observation = store.observe(keyPath, options: [.new]) { [weak self] _, _ in
            Task { @MainActor in
                self?.objectWillChange.send()
            }
        }
    }
    
    public var bindingValue: Binding<Value> {
        Binding(
            get: { self.value },
            set: { self.value = $0 }
        )
    }
}
