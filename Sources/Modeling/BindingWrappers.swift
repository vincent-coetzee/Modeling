//
//  BindingWrappers.swift
//  VideoFrames
//
//  Created by Vincent Coetzee on 06/02/2024.
//

import Foundation

@propertyWrapper
public class AspectWrapper<T>
    {
    public let binding: ValueHolder<AnyBinding>
    private let aspect: Aspect
    public var value: T?
    
    public var wrappedValue: T?
        {
        get
            {
            self.value = self.binding.value?.value(of: self.aspect.kind) as? T
            return(self.value)
            }
        set
            {
            self.value = newValue
            let newAspect = self.aspect.withValue(newValue)
            try? self.binding.value?.modelChanged(aspect: newAspect)
            try? self.binding.value?.setValue(of: newAspect)
            }
        }
        
    public func setAspect(_ aspect: Aspect)
        {
        switch(aspect)
            {
            case(.ciImage(let image)):
                self.wrappedValue = image as? T
            case(.detectedObjects(let objects)):
                self.wrappedValue = objects as? T
            case(.serviceState(let state)):
                self.wrappedValue = state as? T
            case(.videoPacket(let packet)):
                self.wrappedValue = packet as? T
            default:
                break
            }
        }
        
    public init(binding: ValueHolder<AnyBinding>,aspect: Aspect)
        {
        self.binding = binding
        self.aspect = aspect
        self.setAspect(aspect)
        }
    }
