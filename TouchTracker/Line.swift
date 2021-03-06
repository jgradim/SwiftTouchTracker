//
//  Line.swift
//  TouchTracker
//
//  Created by João Gradim on 17/03/16.
//  Copyright © 2016 jgradim. All rights reserved.
//

import Foundation
import CoreGraphics
import UIKit

class Line: Drawable {
  var start = CGPoint.zero
  var end = CGPoint.zero
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
    
    path.moveToPoint(start)
    path.addLineToPoint(end)
    
    let currentColor = selected ? selectedColor : color
    currentColor.colorWithAlphaComponent(finished ? 1 : 0.5).setStroke()
    path.stroke()
  }
  
  func begin(point: CGPoint) {
    start = point
    end = point
    finished = false
  }
  
  func move(point: CGPoint) {
    end = point
  }
  
  func end(point: CGPoint) {
    end = point
    finished = true
  }
  
  func select() {
    selected = true
  }
  
  func deselect() {
    selected = false
  }
}