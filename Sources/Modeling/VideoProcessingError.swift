//
//  VideoProcessingError.swift
//  VideoFrames
//
//  Created by Vincent Coetzee on 28/01/2024.
//

import Foundation
import CoreMedia

public enum VideoProcessingErrorKind: String
    {
    case cvPixelBufferMissingFromFrame                  = "The cvPixelBuffer is missing the specified video frame"
    case videoTracksMissingFromAsset                    = "The specified video asset does not have any asset tracks"
    case unexpectedError                                = "Unexpected unknown error"
    case startingSourceFailed                           = "The specified source could not be started"
    case attemptToAddToMoreThanOneSource                = "A sink can only be added to a single source"
    case couldNotLoadFirstFrame                         = "The first video frame could not be read from the video asset"
    case invalidSource                                  = "The specified source is not valid"
    case pausingTaskFailed                              = "The specified task could not be paused because it is cancelled"
    case servicelreadyStarted                           = "The specified service was already running"
    case serviceNotRunning                              = "The specified service is not running"
    case serviceNotPaused                               = "The specified service is not paused"
    case invalidCounter                                 = "The specified counter key is not valid"
    case couldNotCreatePixelBufferPool                  = "Unable to create the pixel buffer pool"
    case couldNotCreateMetalDevice                      = "Unabled to create the Metal device"
    case writingFailed                                  = "Writing out video failed"
    case timedOutWaitingForInputReadiness               = "Timed out waiting for the input to become ready"
    case unableToConfigureCamera                        = "Unable to configure the camera"
    }

public struct VideoProcessingError: Error
    {
    public let kind: VideoProcessingErrorKind
    public let message: String
    
    public init(kind: VideoProcessingErrorKind,message: String? = nil)
        {
        self.kind = kind
        self.message = message.isNil ? kind.rawValue : message!
        }
    }
