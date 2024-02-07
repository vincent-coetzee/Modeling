//
//  BindingList.swift
//  VideoFrames
//
//  Created by Vincent Coetzee on 07/02/2024.
//

import Foundation

public struct BindingArray
    {
    private var bindings: Array<AnyBinding>
    
    public var isEmpty: Bool
        {
        self.bindings.isEmpty
        }
        
    public var count: Int
        {
        self.bindings.count
        }
        
    public init()
        {
        self.bindings = Array<AnyBinding>()
        }
        
    public mutating func append(_ binding: AnyBinding)
        {
        self.bindings.append(binding)
        }
        
    public func forEach(_ closure: (AnyBinding) throws -> Void) throws
        {
        try self.bindings.forEach(closure)
        }
        
    public func modelChanged(aspect: Aspect) throws
        {
        try self.bindings.forEach { try $0.modelChanged(aspect: aspect) }
        }
        
    public mutating func unbind(_ inputBinding: AnyBinding)
        {
        var index = 0
        for binding in self.bindings
            {
            if binding.model?.identifier == inputBinding.identifier && binding.aspectKind == inputBinding.aspectKind
                {
                binding.unbind()
                self.bindings.remove(at: index)
                return
                }
            index += 1
            }
        }
    }
