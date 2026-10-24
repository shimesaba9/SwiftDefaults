import SwiftUI

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
