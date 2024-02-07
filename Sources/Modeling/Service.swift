//
//  Service.swift
//  VideoFrames
//
//  Created by Vincent Coetzee on 07/02/2024.
//

import Foundation

public protocol Service where Self: Model
    {
    func start() throws
    func stop() async throws
    func resume() async throws
    func pause() async throws
    }

public typealias AnyService = any Service
