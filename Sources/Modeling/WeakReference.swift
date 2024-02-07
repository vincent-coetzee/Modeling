//
//  File.swift
//  
//
//  Created by Vincent Coetzee on 02/02/2024.
//

import Foundation

internal struct WeakReference<T>
    {
    private enum ValueType
        {
        case none
        case object
        case value
        }
        
    private weak var objectValue: AnyObject?
    private var valueValue: T?
    private var valueType: ValueType = .none
    
    public var value: T?
        {
        switch(self.valueType)
            {
            case(.none):
                return(nil)
            case(.object):
                return(self.objectValue as? T)
            case(.value):
                return(self.valueValue)
            }
        }
        
    public init() where T: AnyObject
        {
        self.valueType = .object
        self.objectValue = nil
        }
        
    public init()
        {
        self.valueType = .value
        self.valueValue = nil
        }
        
    public init(_ value: T?) where T: AnyObject
        {
        self.valueType = .object
        self.objectValue =  value
        }
        
    public init(_ value: T?)
        {
        self.valueType = .value
        self.valueValue = value
        }
        
    public mutating func setValue(_ value: T?) where T: AnyObject
        {
        self.valueType = .object
        self.objectValue = value
        }
        
    public mutating func setValue(_ value: T?)
        {
        self.valueType = .value
        self.valueValue = value
        }
    }
    
