//
//  Model.swift
//  VideoFrames
//
//  Created by Vincent Coetzee on 06/02/2024.
//

import Foundation

public protocol Model where Self: Equatable
    {
    var identifier: String { get }
    func setValue(of aspect: Aspect) throws
    func value(of: Aspect.Kind) -> Aspect?
    func bind(aspectKind: Aspect.Kind,dependent: AnyDependent) -> AnyBinding
    func unbind<B:Binding>(_ binding: B)
    }
    
public typealias AnyModel = any Model
