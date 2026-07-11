import Cocoa

// AIdometer app icon: a speedometer at ~72%, redline at 90%.
// Usage: swift makeicon.swift out.png

let S = 1024.0
let rep = NSBitmapImageRep(bitmapDataPlanes: nil, pixelsWide: Int(S), pixelsHigh: Int(S),
    bitsPerSample: 8, samplesPerPixel: 4, hasAlpha: true, isPlanar: false,
    colorSpaceName: .deviceRGB, bytesPerRow: 0, bitsPerPixel: 0)!
NSGraphicsContext.saveGraphicsState()
NSGraphicsContext.current = NSGraphicsContext(bitmapImageRep: rep)

func rgb(_ r: Double, _ g: Double, _ b: Double) -> NSColor {
    NSColor(srgbRed: r, green: g, blue: b, alpha: 1)
}

// Rounded-square background: night-dashboard gradient
let inset = 96.0
let bgRect = NSRect(x: inset, y: inset, width: S - 2*inset, height: S - 2*inset)
let bg = NSBezierPath(roundedRect: bgRect, xRadius: 200, yRadius: 200)
let grad = NSGradient(colors: [rgb(0.10, 0.11, 0.15), rgb(0.16, 0.19, 0.28)])!
grad.draw(in: bg, angle: -60)

bg.addClip()

let center = NSPoint(x: S/2, y: S/2 - 60)
let radius = 300.0
let lw = 66.0

func arc(_ from: Double, _ to: Double, _ color: NSColor, width: Double) {
    let p = NSBezierPath()
    p.lineWidth = width
    p.lineCapStyle = .round
    p.appendArc(withCenter: center, radius: radius, startAngle: from, endAngle: to, clockwise: true)
    color.setStroke()
    p.stroke()
}

// Track (180° → 0° over the top), then redline zone (last 10%), then fill to 72%
arc(180, 0, rgb(1, 1, 1).withAlphaComponent(0.16), width: lw)
arc(180 - 1.8 * 90, 0, rgb(0.937, 0.267, 0.267).withAlphaComponent(0.92), width: lw)
arc(180, 180 - 1.8 * 72, rgb(1.0, 0.72, 0.25), width: lw)

// Tick marks at 0 / 25 / 50 / 75 / 100
for mark in stride(from: 0.0, through: 100.0, by: 25.0) {
    let a = (180 - 1.8 * mark) * Double.pi / 180
    let r1 = radius - lw - 26
    let r2 = radius - lw - 70
    let tick = NSBezierPath()
    tick.move(to: NSPoint(x: center.x + cos(a) * r1, y: center.y + sin(a) * r1))
    tick.line(to: NSPoint(x: center.x + cos(a) * r2, y: center.y + sin(a) * r2))
    tick.lineWidth = 14
    tick.lineCapStyle = .round
    rgb(1, 1, 1).withAlphaComponent(0.45).setStroke()
    tick.stroke()
}

// Needle at 72%
let na = (180 - 1.8 * 72) * Double.pi / 180
let needle = NSBezierPath()
needle.move(to: center)
needle.line(to: NSPoint(x: center.x + cos(na) * (radius - 40), y: center.y + sin(na) * (radius - 40)))
needle.lineWidth = 30
needle.lineCapStyle = .round
rgb(1, 1, 1).setStroke()
needle.stroke()

// Hub: white ring, amber core
let hubR = 66.0
rgb(1, 1, 1).setFill()
NSBezierPath(ovalIn: NSRect(x: center.x - hubR, y: center.y - hubR, width: hubR*2, height: hubR*2)).fill()
let coreR = 34.0
rgb(1.0, 0.72, 0.25).setFill()
NSBezierPath(ovalIn: NSRect(x: center.x - coreR, y: center.y - coreR, width: coreR*2, height: coreR*2)).fill()

NSGraphicsContext.restoreGraphicsState()
let data = rep.representation(using: .png, properties: [:])!
try! data.write(to: URL(fileURLWithPath: CommandLine.arguments[1]))
print("wrote \(CommandLine.arguments[1])")
