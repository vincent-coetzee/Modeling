//
//  Aspect.swift
//  VideoFrames
//
//  Created by Vincent Coetzee on 06/02/2024.
//

import Foundation
import CoreImage

public enum ServiceState
    {
    case off                // hasn't yet been started
    case running            // is running after being started
    case pausing(UInt64)    // is pausing for the specified number of nanoseconds
    case paused             // paused indefinitely
    case stopped            // stopped permananently
    case ended              // the service terminated normally
    
    public var isStoppedState: Bool
        {
        switch(self)
            {
            case(.stopped):
                return(true)
            default:
                return(false)
            }
        }
        
    public var isRunningState: Bool
        {
        switch(self)
            {
            case(.running):
                return(true)
            default:
                return(false)
            }
        }
        
    public var isPausingState: Bool
        {
        switch(self)
            {
            case(.pausing):
                return(true)
            default:
                return(false)
            }
        }
        
    public var scheduledPauseInNanoseconds: UInt64
        {
        switch(self)
            {
            case(.pausing(let delay)):
                return(delay)
            default:
                fatalError("Attempt to call scheduledDelayInNanoseconds on something not a .pausing state")
            }
        }
        
    }
    
public enum Aspect: Equatable
    {
    public enum Kind
        {
        case none
        case ciImage
        case videoPacket
        case detectedObjects
        case annotatedBounds
        case serviceState
        }
        
    public var kind: Kind
        {
        switch(self)
            {
            case(.ciImage):
                return(.ciImage)
            case(.videoPacket):
                return(.videoPacket)
            case(.detectedObjects):
                return(.detectedObjects)
            case(.serviceState):
                return(.serviceState)
            case(.annotatedBounds):
                return(.annotatedBounds)
            default:
                return(.none)
            }
        }
        
    public var videoPacketPayload: VideoPacket?
        {
        switch(self)
            {
            case(.videoPacket(let packet)):
                return(packet)
            default:
                fatalError("Asked for videoPacketPayload of something not a videoPacket")
            }
        }
        
    public var serviceStatePayload: ServiceState
        {
        switch(self)
            {
            case(.serviceState(let state)):
                return(state)
            default:
                fatalError("Asked for serviceStatePayload of something not a serbiceState")
            }
        }
        
    case ciImage(CIImage?)
    case videoPacket(VideoPacket?)
    case detectedObjects(DetectedObjects?)
    case serviceState(ServiceState)
    case annotatedBounds(AnnotatedBoundsArray?)
    case none
    
    public init(_ serviceState: ServiceState)
        {
        self = .serviceState(serviceState)
        }
        
    public init(_ ciImage: CIImage?)
        {
        self = .ciImage(ciImage)
        }
        
    public init(_ detectedObjects: DetectedObjects?)
        {
        self = .detectedObjects(detectedObjects)
        }
        
    public init(_ videoPacket: VideoPacket?)
        {
        self = .videoPacket(videoPacket)
        }
        
    public init(_ array: AnnotatedBoundsArray?)
        {
        self = .annotatedBounds(array)
        }
        
    public func withValue(_ serviceState: ServiceState) -> Aspect
        {
        assert(self.kind == .serviceState,"attempt to set serviceState value on aspect \(self)")
        return(.serviceState(serviceState))
        }
        
    public func withValue(_ array: AnnotatedBoundsArray?) -> Aspect
        {
        assert(self.kind == .annotatedBounds,"attempt to set annotatedBounds value on aspect \(self)")
        return(.annotatedBounds(array))
        }
        
    public func withValue(_ videoPacket: VideoPacket?) -> Aspect
        {
        assert(self.kind == .videoPacket,"attempt to set videoPacket value on aspect \(self)")
        return(.videoPacket(videoPacket))
        }
        
    public func withValue(_ detectedObjects: DetectedObjects?) -> Aspect
        {
        assert(self.kind == .detectedObjects,"attempt to set detectedObjects value on aspect \(self)")
        return(.detectedObjects(detectedObjects))
        }
        
    public func withValue(_ ciImage: CIImage?) -> Aspect
        {
        assert(self.kind == .ciImage,"attempt to set ciImage value on aspect \(self)")
        return(.ciImage(ciImage))
        }
        
    public func withValue<T>(_ value: T) -> Aspect
        {
        return(.none)
        }
        
    public static func ==(lhs: Aspect,rhs: Aspect) -> Bool
        {
        lhs.kind == rhs.kind
        }
    }
