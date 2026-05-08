import Foundation
import AVFoundation

let args = CommandLine.arguments
if args.count < 3 {
    fputs("Usage: swift scripts/compress-video.swift input-video output-video [preset]\n", stderr)
    exit(2)
}

let source = URL(fileURLWithPath: args[1])
let output = URL(fileURLWithPath: args[2])
let preset = args.count >= 4 ? args[3] : AVAssetExportPresetMediumQuality
let asset = AVURLAsset(url: source)

guard AVAssetExportSession.exportPresets(compatibleWith: asset).contains(preset) else {
    fputs("This video cannot be exported with preset: \(preset)\n", stderr)
    exit(3)
}

guard let session = AVAssetExportSession(asset: asset, presetName: preset) else {
    fputs("Could not create a video export session.\n", stderr)
    exit(4)
}

try? FileManager.default.removeItem(at: output)
session.metadata = []
session.shouldOptimizeForNetworkUse = true

let semaphore = DispatchSemaphore(value: 0)
var exportError: Error?

Task {
    do {
        try await session.export(to: output, as: .mp4)
    } catch {
        exportError = error
    }
    semaphore.signal()
}

semaphore.wait()

if let exportError {
    fputs("Video export failed: \(exportError.localizedDescription)\n", stderr)
    exit(1)
}

print("Compressed video written to: \(output.path)")
