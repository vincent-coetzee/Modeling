//
//  DetectedObject.swift
//  VideoFrames
//
//  Created by Vincent Coetzee on 01/02/2024.
//

import Foundation
import simd
import CoreMedia

public struct DetectedObject
    {
    public let bounds: CGRect
    public let confidenceLevel: CGFloat
    public let label: String?
    public let color: Color
    public let colorIndex: Int
    
    public init(bounds: CGRect,confidenceLevel: CGFloat,label: String?,color: Color,colorIndex: Int)
        {
        self.bounds = bounds
        self.confidenceLevel = confidenceLevel
        self.label = label
        self.color = color
        self.colorIndex = colorIndex
        }
        
    public func annotatedBounds(in imageSize: CGSize) -> AnnotatedBounds
        {
        AnnotatedBounds(bounds: self.bounds, label: self.label, confidenceLevel: self.confidenceLevel, color: self.color,colorIndex: colorIndex)
        }
        
    public func transformed(by transform: CGAffineTransform) -> Self
        {
        let newBounds = self.bounds.applying(transform)
        return(Self(bounds: newBounds, confidenceLevel: self.confidenceLevel, label: self.label, color: self.color, colorIndex: self.colorIndex))
        }
    }

public struct DetectedObjects
    {
    public var count: Int
        {
        self.detectedObjects.count
        }
        
    public var presentationTimestamp: CMTime
    public var detectedObjects: Array<DetectedObject>
    
    public init(presentationTimestamp: CMTime,detectedObjects: Array<DetectedObject>?)
        {
        self.presentationTimestamp = presentationTimestamp
        self.detectedObjects = detectedObjects ?? Array<DetectedObject>()
        }
        
    public mutating func append(_ object: DetectedObject)
        {
        self.detectedObjects.append(object)
        }
    }
