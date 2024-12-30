import UIKit

class ProgressBar: UIView {
    private var backgroundLayer: CAShapeLayer?
    private var foregroundLayer: CAShapeLayer?
    
    public var progress: CGFloat = 0.0 {
        didSet {
            if let foregroundLayer = foregroundLayer {
                foregroundLayer.strokeEnd = progress
            }
        }
    }
    
    override func draw(_ rect: CGRect) {
        let width = rect.width
        let height = rect.height
        
        let lineWidth = 0.1 * min(width, height)
        
        let center = CGPoint(x: width / 2, y: height / 2)
        let radius = (min(height, width) - lineWidth) / 2
        
        let startAngle = -CGFloat.pi / 2
        let endAngle = startAngle + 2 * CGFloat.pi
        
        let circularPath = UIBezierPath(arcCenter: center, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: true)
        
        if backgroundLayer == nil {
            backgroundLayer = CAShapeLayer()
            backgroundLayer?.path = circularPath.cgPath
            backgroundLayer?.strokeColor = UIColor.lightGray.cgColor
            backgroundLayer?.fillColor = UIColor.clear.cgColor
            backgroundLayer?.lineWidth = lineWidth
            backgroundLayer?.lineCap = .round
            if let backgroundLayer = backgroundLayer {
                layer.addSublayer(backgroundLayer)
            }
        }
        
        if foregroundLayer == nil {
            foregroundLayer = CAShapeLayer()
            foregroundLayer?.path = circularPath.cgPath
            foregroundLayer?.strokeColor = UIColor.blue.cgColor
            foregroundLayer?.fillColor = UIColor.clear.cgColor
            foregroundLayer?.lineWidth = lineWidth
            foregroundLayer?.lineCap = .round
            if let foregroundLayer = foregroundLayer {
                layer.addSublayer(foregroundLayer)
            }
        }
        
        if let foregroundLayer = foregroundLayer {
            foregroundLayer.strokeEnd = progress
        }
    }
}
