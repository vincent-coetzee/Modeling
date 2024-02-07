//
//  Dependent.swift
//  VideoFrames
//
//  Created by Vincent Coetzee on 06/02/2024.
//

import Foundation

public protocol Dependent
    {
    func aspectChanged(_ aspect: Aspect,for: AnyBinding)
    func bind(model: AnyModel)
    }
    
public typealias AnyDependent = any Dependent
    
