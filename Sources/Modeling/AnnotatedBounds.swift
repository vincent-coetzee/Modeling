//
//  AnnotatedRectangle.swift
//  VideoFrames
//
//  Created by Vincent Coetzee on 02/02/2024.
//

import Foundation
import simd
import CoreMedia

public struct AnnotatedBounds
    {
    public let bounds: CGRect
    public let label: String
    public let confidenceLevel: CGFloat
    public let color: Color
    public let colorIndex: Int
    
    public init(bounds: CGRect,label: String?,confidenceLevel: CGFloat,color: Color,colorIndex: Int)
        {
        self.colorIndex = colorIndex
        self.color = color
        self.bounds = bounds
        self.label = label ?? ""
        self.confidenceLevel = confidenceLevel
        }
        
    public func boundsVertices(in imageSize: CGSize) -> Array<VertexIn>
        {
        var points = Array<VertexIn>()
#if os(macOS)
        guard let size = Screen.main?.frame.size else
            {
            return(points)
            }
#endif

#if os(iOS)
        let size = Screen.main.bounds
#endif
        let screenWidth = Float(size.width)
        let screenHeight = Float(size.width)
        points.append(VertexIn(point: [Float(self.bounds.minX),Float(self.bounds.minY)],color: self.color.float4,screenWidth: screenWidth,screenHeight: screenHeight,lineWidth: 5))
        points.append(VertexIn(point: [Float(self.bounds.maxX),Float(self.bounds.minY)],color: self.color.float4,screenWidth: screenWidth,screenHeight: screenHeight,lineWidth: 5))
        points.append(VertexIn(point: [Float(self.bounds.minX),Float(self.bounds.maxY)],color: self.color.float4,screenWidth: screenWidth,screenHeight: screenHeight,lineWidth: 5))
        points.append(VertexIn(point: [Float(self.bounds.maxX),Float(self.bounds.maxY)],color: self.color.float4,screenWidth: screenWidth,screenHeight: screenHeight,lineWidth: 5))
        return(points)
        }
    }

public struct AnnotatedBoundsArray
    {
    public var createdTime: CMTime = CMClock.hostTimeClock.time
    public var presentationTimestamp: CMTime
    public var isEmpty: Bool
        {
        self.array.isEmpty
        }
        
    public var array: Array<AnnotatedBounds>
    
    public init(presentationTimestamp: CMTime,array: Array<AnnotatedBounds>)
        {
        self.presentationTimestamp = presentationTimestamp
        self.array = array
        }
        
    public init(presentationTimestamp: CMTime)
        {
        self.presentationTimestamp = presentationTimestamp
        self.array = Array<AnnotatedBounds>()
        }
        
    public init(presentationTimestamp: CMTime,bounds: AnnotatedBounds)
        {
        self.presentationTimestamp = presentationTimestamp
        self.array = Array<AnnotatedBounds>()
        self.array.append(bounds)
        }
        
    public func appending(_ bounds: AnnotatedBounds) -> AnnotatedBoundsArray
        {
        var newArray = self.array
        newArray.append(bounds)
        return(AnnotatedBoundsArray(presentationTimestamp: self.presentationTimestamp,array: newArray))
        }
    }

extension Color
    {
    public var float4: simd_float4
        {
        let redPointer = UnsafeMutablePointer<CGFloat>.allocate(capacity: 1)
        let greenPointer = UnsafeMutablePointer<CGFloat>.allocate(capacity: 1)
        let bluePointer = UnsafeMutablePointer<CGFloat>.allocate(capacity: 1)
        let alphaPointer = UnsafeMutablePointer<CGFloat>.allocate(capacity: 1)
        defer
            {
            redPointer.deallocate()
            greenPointer.deallocate()
            bluePointer.deallocate()
            alphaPointer.deallocate()
            }
        self.getRed(redPointer, green: greenPointer, blue: bluePointer, alpha: alphaPointer)
        return(simd_float4([Float(redPointer.pointee),Float(greenPointer.pointee),Float(bluePointer.pointee),Float(alphaPointer.pointee)]))
        }
    }
