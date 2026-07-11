import Cocoa

let S = 1024.0
let rep = NSBitmapImageRep(bitmapDataPlanes: nil, pixelsWide: Int(S), pixelsHigh: Int(S),
    bitsPerSample: 8, samplesPerPixel: 4, hasAlpha: true, isPlanar: false,
    colorSpaceName: .deviceRGB, bytesPerRow: 0, bitsPerPixel: 0)!
NSGraphicsContext.saveGraphicsState()
NSGraphicsContext.current = NSGraphicsContext(bitmapImageRep: rep)

func rgb(_ r: Double, _ g: Double, _ b: Double) -> NSColor {
    NSColor(srgbRed: r, green: g, blue: b, alpha: 1)
}

// Rounded-square background with an ocean gradient
let inset = 96.0
let bgRect = NSRect(x: inset, y: inset, width: S - 2*inset, height: S - 2*inset)
let bg = NSBezierPath(roundedRect: bgRect, xRadius: 200, yRadius: 200)
let grad = NSGradient(colors: [rgb(0.078,0.722,0.651), rgb(0.231,0.510,0.965)])!
grad.draw(in: bg, angle: -50)

// Gauge donut
let center = NSPoint(x: S/2, y: S/2 - 6)
let radius = 268.0
let lw = 84.0

// track ring (translucent white)
let track = NSBezierPath()
track.appendArc(withCenter: center, radius: radius, startAngle: 0, endAngle: 360)
track.lineWidth = lw
rgb(1,1,1).withAlphaComponent(0.22).setStroke()
track.stroke()

// progress arc (~70%), from top going clockwise, rounded caps
let prog = NSBezierPath()
prog.lineWidth = lw
prog.lineCapStyle = .round
prog.appendArc(withCenter: center, radius: radius, startAngle: 90, endAngle: 90 - 252, clockwise: true)
rgb(1,1,1).setStroke()
prog.stroke()

// center dot
let dotR = 62.0
let dot = NSBezierPath(ovalIn: NSRect(x: center.x - dotR, y: center.y - dotR, width: dotR*2, height: dotR*2))
rgb(1,1,1).setFill()
dot.fill()

NSGraphicsContext.restoreGraphicsState()
let data = rep.representation(using: .png, properties: [:])!
try! data.write(to: URL(fileURLWithPath: CommandLine.arguments[1]))
print("wrote \(CommandLine.arguments[1])")
