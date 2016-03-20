import Foundation
import CoreGraphics
import UIKit

class Circle: Drawable {
  var center = CGPoint.zero
  var radius = CGFloat(0)
  var color = UIColor.blackColor()
  var selectedColor: UIColor {
    return color.lighterColor(0.3)
  }
  var selected = false
  var finished = false
  
  func draw() {
    let path = UIBezierPath()
    path.lineWidth = 7
    path.lineCapStyle = .Round
    
    path.addArcWithCenter(center, radius: radius, startAngle: 0, endAngle: 360, clockwise: true)
    
    let currentColor = selected ? selectedColor : color
    currentColor.colorWithAlphaComponent(finished ? 1 : 0.5).setStroke()
    path.stroke()
  }
  
  
  func begin(point: CGPoint) {
    center = point
    radius = 0
    finished = false
  }
  
  func move(point: CGPoint) {
    let xDist = point.x - center.x
    let yDist = point.y - center.y
    
    radius = sqrt((xDist * xDist) + (yDist * yDist));
  }
  
  func end(point: CGPoint) {
    move(point)
    finished = true
  }
  
  func select() {
    selected = true
  }
  
  func deselect() {
    selected = false
  }
  
}