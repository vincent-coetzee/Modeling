//
//  File.swift
//  
//
//  Created by Vincent Coetzee on 04/02/2024.
//

import Foundation

public struct WeakArray<Element>: Sequence
    {
    public typealias Index = Int
    
    private var array = Array<WeakReference<Element>>()
    
    public var count: Int
        {
        self.array.count
        }
        
    public init()
        {
        }
        
    public init(_ element: Element)
        {
        self.array.append(WeakReference(element))
        }
        
    public init(_ element: Element) where Element: AnyObject
        {
        self.array.append(WeakReference(element))
        }
        
    public mutating func append(_ element: Element) where Element: AnyObject
        {
        self.array.append(WeakReference(element))
        }
        
    public mutating func append(_ element: Element)
        {
        self.array.append(WeakReference(element))
        }
        
    public subscript(_ index: Index) -> Element? where Element: AnyObject
        {
        get
            {
            assert(index < self.count,"Index >= array count")
            return(self.array[index].value)
            }
        set
            {
            assert(index < self.count,"Index >= array count")
            self.array[index] = WeakReference(newValue)
            }
        }
        
    public subscript(_ index: Index) -> Element?
        {
        get
            {
            assert(index < self.count,"Index >= array count")
            return(self.array[index].value)
            }
        set
            {
            assert(index < self.count,"Index >= array count")
            self.array[index] = WeakReference(newValue)
            }
        }
    }
    
extension WeakArray
    {
    public func makeIterator() -> WeakArrayIterator<Element>
        {
        return(WeakArrayIterator<Element>(weakArray: self))
        }
    }
    
public struct WeakArrayIterator<Element>: IteratorProtocol
    {
    private var index:WeakArray.Index
    private let weakArray: WeakArray<Element>
    
    public init(weakArray: WeakArray<Element>)
        {
        self.weakArray = weakArray
        self.index = 0
        }
        
    public mutating func next() -> Element?
        {
        guard self.index < self.weakArray.count else
            {
            return(nil)
            }
        let element = self.weakArray[self.index]
        self.index += 1
        return(element)
        }
    }
