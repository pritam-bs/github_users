//
//  UserOrderedSet.swift
//  github_users
//
//  Created by Pritam Biswas on 14.07.2024.
//

import Foundation

import Foundation

struct UserOrderedSet<T: Hashable>: ExpressibleByArrayLiteral {
    private var array: [T]
    private var set: Set<T>
    
    init() {
        self.array = []
        self.set = Set()
    }
    
    init(array: [T]) {
        self.array = []
        self.set = Set()
        for item in array {
            self.append(item)
        }
    }
    
    init(arrayLiteral elements: T...) {
        self.init(array: elements)
    }
    
    var count: Int {
        return array.count
    }
    
    var isEmpty: Bool {
        return array.isEmpty
    }
    
    func contains(_ member: T) -> Bool {
        return set.contains(member)
    }
    
    func index(of member: T) -> Int? {
        return array.firstIndex(of: member)
    }
    
    mutating func append(_ newElement: T) {
        if !set.contains(newElement) {
            array.append(newElement)
            set.insert(newElement)
        }
    }
    
    mutating func append(contentsOf newElements: [T]) {
        for element in newElements {
            self.append(element)
        }
    }
    
    mutating func remove(_ element: T) {
        if let index = array.firstIndex(of: element) {
            array.remove(at: index)
            set.remove(element)
        }
    }
    
    mutating func removeAll() {
        array.removeAll()
        set.removeAll()
    }
    
    func toArray() -> [T] {
        return array
    }
}

extension UserOrderedSet: CustomStringConvertible {
    var description: String {
        return array.description
    }
}

extension UserOrderedSet: RandomAccessCollection {
    typealias Index = Int
    typealias Element = T

    var startIndex: Index {
        return array.startIndex
    }
    
    var endIndex: Index {
        return array.endIndex
    }
    
    func index(after i: Index) -> Index {
        return array.index(after: i)
    }
    
    func index(before i: Index) -> Index {
        return array.index(before: i)
    }
    
    var first: Element? {
        return array.first
    }
    
    var last: Element? {
        return array.last
    }
    
    subscript(position: Index) -> Element {
        return array[position]
    }
}
