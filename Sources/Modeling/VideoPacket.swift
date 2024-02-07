//
//  VideoPacket.swift
//  VideoFrames
//
//  Created by Vincent Coetzee on 06/02/2024.
//

import Foundation
import CoreVideo
import CoreMedia
import CoreImage

public struct VideoPacket
    {
    public let imageSize: CGSize
    public let pixelBuffer: CVPixelBuffer
    public let presentationTimestamp: CMTime
    public let loadedTimestamp: CMTime
    public let imageTransform: CGAffineTransform
    public let ciImage: CIImage
    
    public init(sampleBuffer: CMSampleBuffer,loadedTimestamp: CMTime,frameTransform: CGAffineTransform) throws
        {
        self.presentationTimestamp = sampleBuffer.presentationTimeStamp
        guard let buffer = sampleBuffer.imageBuffer else
            {
            throw(VideoProcessingError(kind: .cvPixelBufferMissingFromFrame))
            }
        self.pixelBuffer = buffer
        let image = CIImage(cvPixelBuffer: buffer).transformed(by: frameTransform)
        self.imageSize = image.extent.size
        let xOffset = image.extent.minX != 0 ? -image.extent.minX : 0
        let yOffset = image.extent.minY != 0 ? -image.extent.minY : 0
        let translation = CGAffineTransform(translationX: xOffset, y: yOffset)
        self.ciImage = image.transformed(by: translation)
        self.imageTransform = frameTransform.concatenating(translation)
        self.loadedTimestamp = loadedTimestamp
        }
    }
