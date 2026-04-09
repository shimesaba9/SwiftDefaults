//
//  ViewController.swift
//  SwiftDefaults
//
//  Created by shimesaba9 on 01/12/2016.
//  Copyright (c) 2016 shimesaba9. All rights reserved.
//

import UIKit
import SwiftUI

class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(MyDefaults().value2)
        MyDefaults().value2 = "2"
        print(MyDefaults().value2)
        
        print("Stored person instance: \(String(describing: MyDefaults().value4))")
        let p = Person()
        p.firstName = "Elvis"
        p.lastName = "Presley"
        p.age = 42
        MyDefaults().value4 = p
        print("Stored person instance: \(String(describing: MyDefaults().value4))")
        MyDefaults().value4 = nil
        print("Stored nil person: \(String(describing: MyDefaults().value4))")
        
        let button = UIButton(type: .system)
        button.setTitle("Show SwiftUI View", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(button)
        NSLayoutConstraint.activate([
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        button.addTarget(self, action: #selector(tapButton), for: .touchUpInside)
    }
    
    @objc func tapButton() {
        present(UIHostingController(rootView: MyView()), animated: true, completion: nil)
    }
}

struct MyView: View {
    @AppDefault(\.value3) var value3
    
    var body: some View {
        Text("Hello, World! \(value3)")
        Button(action: {
            value3 += 1
        }) {
            Text("increment")
        }
    }
}
