//
//  ModelBinding.swift
//  VideoFrames
//
//  Created by Vincent Coetzee on 06/02/2024.
//

import Foundation
import Logging

public class ModelBinding: Binding
    {
    private static var identifierCounter = 1
    
    public var isBound: Bool = false
    public let identifier: String
    public let aspectKind: Aspect.Kind
    private var modelReference: WeakReference<AnyModel>
    public var dependent: AnyDependent?
    
    public var model: AnyModel?
        {
        self.modelReference.value
        }
    
    public init(model: AnyModel,aspectKind: Aspect.Kind,dependent: AnyDependent)
        {
        self.identifier = "ModelBinding.\(Self.identifierCounter)"
        Self.identifierCounter += 1
        self.modelReference = WeakReference(model)
        self.dependent = dependent
        self.aspectKind = aspectKind
        }
        
    public func setIsBound(_ state: Bool)
        {
        self.isBound = state
        }
        
    public func setValue(of aspect: Aspect) throws
        {
        SystemLogger.shared.logDebug("Setting value of \(aspect)")
        try self.model?.setValue(of: aspect)
        }
        
    public func value(of kind: Aspect.Kind) -> Aspect?
        {
        self.model?.value(of: kind)
        }
        
    public func unbind()
        {
        guard self.isBound else
            {
            return
            }
        self.model?.unbind(self)
        self.dependent = nil
        self.isBound = false
        }
        
    public func modelChanged(aspect: Aspect) throws
        {
        self.dependent?.aspectChanged(aspect,for: self)
        }
        
    public static func ==(lhs: ModelBinding,rhs: ModelBinding) -> Bool
        {
        guard let lhsModel = lhs.model,let rhsModel = rhs.model else
            {
            return(false)
            }
        return(lhsModel.identifier == rhsModel.identifier)
        }
    }


