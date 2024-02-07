//
//  Optional+Extensions.swift
//  VideoFrames
//
//  Created by Vincent Coetzee on 07/02/2024.
//

import Foundation

extension Optional
    {
    internal var isNotNil: Bool
        {
        switch(self)
            {
            case(.some):
                return(true)
            default:
                return(false)
            }
        }
        
    internal var isNil: Bool
        {
        switch(self)
            {
            case(.some):
                return(false)
            default:
                return(true)
            }
        }

    }
