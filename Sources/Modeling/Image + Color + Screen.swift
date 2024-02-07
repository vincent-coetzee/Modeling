//
//  File.swift
//  
//
//  Created by Vincent Coetzee on 07/02/2024.
//

import Foundation

//
//  Image.swift
//  VideoFrames
//
//  Created by Vincent Coetzee on 30/01/2024.
//

import Foundation

#if os(macOS)
    import AppKit
    public typealias Image = NSImage
    public typealias Color = NSColor
    public typealias Screen = NSScreen
#else
    import UIKit
    public typealias Image = UIImage
    public typealias Color = UIColor
    public typealias Screen = UIScreen
#endif

#if os(macOS)
extension NSImage
    {
    internal convenience init(ciImage: CIImage)
        {
        let represenation = NSCIImageRep(ciImage: ciImage)
        self.init(size: represenation.size)
        self.addRepresentation(represenation)
        }
    }
#endif

extension Color
    {
    internal static func randomColor() -> Self
        {
        Color(red: CGFloat.random(in: 0...1), green: CGFloat.random(in: 0...1), blue: CGFloat.random(in: 0...1), alpha: 1) as! Self
        }
    }

internal typealias Colors = Array<Color>
