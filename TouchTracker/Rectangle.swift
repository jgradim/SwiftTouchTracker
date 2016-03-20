//
//  Square.swift
//  TouchTracker
//
//  Created by João Gradim on 18/03/16.
//  Copyright © 2016 jgradim. All rights reserved.
//

import Foundation
import CoreGraphics
import UIKit

class Rectangle: Drawable {
  var topLeft = CGPoint.zero
  var bottomRight = CGPoint.zero
  var topRight: CGPoint {
    return CGPoint(x: topLeft.x, y: bottomRight.y)
  }
  var bottomLeft: CGPoint {
    return CGPoint(x: bottomRight.x, y: topLeft.y)
  }
  
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
    
    path.moveToPoint(topLeft)
    path.addLineToPoint(topRight)
    path.addLineToPoint(bottomRight)
    path.addLineToPoint(bottomLeft)
    path.addLineToPoint(topLeft)
    
    let currentColor = selected ? selectedColor : color
    currentColor.colorWithAlphaComponent(finished ? 1 : 0.5).setStroke()
    path.stroke()
  }
  
  
  func begin(point: CGPoint) {
    topLeft = point
    bottomRight = point
    finished = false
  }
  
  func move(point: CGPoint) {
    bottomRight = point
  }
  
  func end(point: CGPoint) {
    bottomRight = point
    finished = true
  }
  
  func select() {
    selected = true
  }
  
  func deselect() {
    selected = false
  }
  
}
