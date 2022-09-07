//
//  Box.swift
//  ListMovieExample
//
//  Created by Pham Kien on 07.09.22.
//

import Foundation

final class Box<T> {
    typealias Listener = (T) -> Void
    var listener:Listener?
    
    var value:T {
        didSet {
            listener?(value)
        }
    }
    init(_ value:T) {
        self.value = value
    }
    func bind(listenner:Listener?) {
        self.listener = listenner
        listenner?(value)
    }
    
    
}
