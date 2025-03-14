//
//  SignaturePopupVC.swift
//

import UIKit
public struct Signature{
    private(set) public var image: UIImage
    private(set) public var date: Date
    init(signature: UIImage){
        self.image = signature
        self.date = Date()
    }
}

public protocol SignatureViewDelegate: class {
    func SignatureViewDidCaptureSignature(view: SignatureView, signature: Signature?)
    func SignatureViewDidBeginDrawing(view: SignatureView)
    func SignatureViewIsDrawing(view: SignatureView)
    func SignatureViewDidFinishDrawing(view: SignatureView)
    func SignatureViewDidCancelDrawing(view: SignatureView)
}

extension SignatureViewDelegate {
    func SignatureViewDidCaptureSignature(view: SignatureView, signature: Signature?) {
        //optional
    }
    func SignatureViewDidBeginDrawing(view: SignatureView) {
        //optional
    }
    
    func SignatureViewIsDrawing(view: SignatureView) {
        //optional
    }
    
    func SignatureViewDidFinishDrawing(view: SignatureView) {
        //optional
    }
    
    func SignatureViewDidCancelDrawing(view: SignatureView) {
        //optional
    }
}

// MARK: - Class Decleration

@IBDesignable
open class SignatureView: UIView {
    
    // MARK: - Public properties
    
    var capturedsignature: String = ""
    
    @IBInspectable public var lineColor: UIColor   = UIColor.black
    @IBInspectable public var lineWidth: CGFloat   = 3.0
    @IBInspectable public var lineOpacity: CGFloat   = 1.0
    @IBInspectable public var drawingEnabled: Bool      = true
    @IBInspectable public var signatureIsOpaque: Bool      = false
    public weak var delegate: SignatureViewDelegate?
    public var signaturePresent: Bool {
        if pathArray.isEmpty {
            return false
        } else {
            return true
        }
    }
    
    // MARK: - Private properties
    
    private var pathArray: [Line]    = []
    private var currentPoint: CGPoint   = CGPoint()
    private var previousPoint: CGPoint   = CGPoint()
    private var previousPreviousPoint: CGPoint   = CGPoint()
    
    private struct Line {
        var path: CGMutablePath
        var color: UIColor
        var width: CGFloat
        var opacity: CGFloat
        
        init(path: CGMutablePath, color: UIColor, width: CGFloat, opacity: CGFloat) {
            self.path    = path
            self.color   = color
            self.width   = width
            self.opacity = opacity
        }
    }
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.clear
    }
    
    required public init?(coder aDecoder: NSCoder){
        super.init(coder: aDecoder)
        backgroundColor = UIColor.clear
    }
    
    override open func draw(_ rect: CGRect) {
        let context: CGContext = UIGraphicsGetCurrentContext()!
        context.setLineCap(.round)
        
        for line in pathArray {
            context.setLineWidth(line.width)
            context.setAlpha(line.opacity)
            context.setStrokeColor(line.color.cgColor)
            context.addPath(line.path)
            context.beginTransparencyLayer(auxiliaryInfo: nil)
            context.strokePath()
            context.endTransparencyLayer()
        }
    }
    
    override open func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
        guard drawingEnabled == true else {
            return
        }
        delegate?.SignatureViewDidBeginDrawing(view: self)
        if let touch = touches.first as UITouch?{
            setTouchPoints(touch, view: self)
            let newLine = Line(path: CGMutablePath(), color: lineColor, width: lineWidth, opacity: lineOpacity)
            newLine.path.addPath(createNewPath())
            pathArray.append(newLine)
        }
    }
    
    override open func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?){
        guard drawingEnabled == true else {
            return
        }
        delegate?.SignatureViewIsDrawing(view: self)
        if let touch = touches.first as UITouch? {
            updateTouchPoints(touch, view: self)
            let newLine = createNewPath()
            if let currentPath = pathArray.last {
                currentPath.path.addPath(newLine)
            }
        }
    }
    
    override open func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard drawingEnabled == true else {
            return
        }
        delegate?.SignatureViewDidFinishDrawing(view: self)
    }
    
    override open func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?){
        guard drawingEnabled == true else {
            return
        }
        delegate?.SignatureViewDidCancelDrawing(view: self)
    }
    
    public func clearCanvas() {
        pathArray = []
        setNeedsDisplay()
    }
    
    public func captureSignature(){
        guard signaturePresent != false else {
            delegate?.SignatureViewDidCaptureSignature(view: self, signature: nil)
            return
        }
        
        let signatureImage = captureSignatureFromView()
        if let image = signatureImage {
            delegate?.SignatureViewDidCaptureSignature(view: self, signature: Signature(signature: image))
        } else {
            delegate?.SignatureViewDidCaptureSignature(view: self, signature: nil)
        }
    }
    
    /********************************** Private Functions **********************************/
    
    public func captureSignatureFromView() -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(bounds.size, signatureIsOpaque, 0.0)
        
        guard let context = UIGraphicsGetCurrentContext() else {
            return nil
        }
        
        layer.render(in: context)
        let viewImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        //
        
        saveSignature(img: viewImage!)
        
        return viewImage
        
    }
    
    func saveSignature(img: UIImage) {
        let fileManager = FileManager.default
        do {
            let documentDirectory = try fileManager.url(for: .applicationSupportDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
            let fileURL = documentDirectory.appendingPathComponent("name")
            
            if let imageData = img.jpegData(compressionQuality: 0.5) {
                try imageData.write(to: fileURL)
                UserDefaults.standard.set(fileURL, forKey: "capturedsignature")
                print(fileURL)
            }
        } catch {
            print(error)
        }
    }
    
    private func setTouchPoints(_ touch: UITouch, view: UIView) {
        previousPoint = touch.previousLocation(in: view)
        previousPreviousPoint = touch.previousLocation(in: view)
        currentPoint = touch.location(in: view)
    }
    
    private func updateTouchPoints(_ touch: UITouch, view: UIView) {
        previousPreviousPoint = previousPoint
        previousPoint = touch.previousLocation(in: view)
        currentPoint = touch.location(in: view)
    }
    
    private func createNewPath() -> CGMutablePath {
        let midPoints = getMidPoints()
        let subPath = createSubPath(midPoints.0, mid2: midPoints.1)
        let newPath = addSubPathToPath(subPath)
        return newPath
    }
    
    private func calculateMidPoint(_ p1: CGPoint, p2: CGPoint) -> CGPoint {
        return CGPoint(x: (p1.x + p2.x) * 0.5, y: (p1.y + p2.y) * 0.5)
    }
    
    private func getMidPoints() -> (CGPoint, CGPoint) {
        let mid1: CGPoint = calculateMidPoint(previousPoint, p2: previousPreviousPoint)
        let mid2: CGPoint = calculateMidPoint(currentPoint, p2: previousPoint)
        return (mid1, mid2)
    }
    
    private func createSubPath(_ mid1: CGPoint, mid2: CGPoint) -> CGMutablePath {
        let subpath: CGMutablePath = CGMutablePath()
        subpath.move(to: CGPoint(x: mid1.x, y: mid1.y))
        subpath.addQuadCurve(to: CGPoint(x: mid2.x, y: mid2.y), control: CGPoint(x: previousPoint.x, y: previousPoint.y))
        return subpath
    }
    
    private func addSubPathToPath(_ subpath: CGMutablePath) -> CGMutablePath {
        let bounds: CGRect = subpath.boundingBox
        let drawBox: CGRect = bounds.insetBy(dx: -2.0 * lineWidth, dy: -2.0 * lineWidth)
        setNeedsDisplay(drawBox)
        return subpath
    }
}
