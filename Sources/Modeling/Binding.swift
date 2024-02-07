//
//  Binding.swift
//  VideoFrames
//
//  Created by Vincent Coetzee on 06/02/2024.
//

import Foundation

//
// Bindings are used to create ( weak ) links between models and their dependents.
// References to both Models and Dependents are weak to ensure bindings do not create
// memory cycles.
//
public protocol Binding: AnyObject where Self: Equatable
    {
    var identifier: String { get }
    var aspectKind: Aspect.Kind { get }
    var model: AnyModel? { get }
    var isBound: Bool { get }
    func modelChanged(aspect: Aspect) throws
    func setValue(of: Aspect) throws
    func value(of: Aspect.Kind) -> Aspect?
    func setIsBound(_ state: Bool)
    func unbind()
    }
    
extension Binding
    {
    public static func ==(lhs: Self,rhs: Self) -> Bool
        {
        lhs.aspectKind == rhs.aspectKind && lhs.model?.identifier == rhs.model?.identifier
        }
    }
    
public typealias AnyBinding = any Binding
