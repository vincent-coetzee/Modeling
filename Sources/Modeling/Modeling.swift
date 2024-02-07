// The Swift Programming Language
// https://docs.swift.org/swift-book
import simd

public struct VertexIn
    {
    let point: simd_float2
    let color: simd_float4;
    let screenWidth: Float;
    let screenHeight: Float;
    let lineWidth: Float;
    }
