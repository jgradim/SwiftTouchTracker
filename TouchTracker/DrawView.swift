//
//  DrawView.swift
//  TouchTracker
//
//  Created by João Gradim on 17/03/16.
//  Copyright © 2016 jgradim. All rights reserved.
//

import UIKit

class DrawView: UIView {
  var currentLine: Line?
  var finishedLines: [Line] = []
  
  convenience init() {
    self.init(frame: UIScreen.mainScreen().bounds)
    self.backgroundColor = UIColor.whiteColor()
  }
  
  func strokeLine(line: Line) {
    let path = UIBezierPath()
    path.lineWidth = 10
    path.lineCapStyle = CGLineCap.Round
    
    path.moveToPoint(line.begin)
    path.addLineToPoint(line.end)
    path.stroke()
  }
  
  
  //----------------------------------------------------------------------------
  // UIView overrides
  //----------------------------------------------------------------------------
  
  //----------------------------------------------------------------------- Draw
  override func drawRect(rect: CGRect) {
    UIColor.blackColor().setStroke()
    
    for line in finishedLines {
      strokeLine(line)
    }
    
    if let line = currentLine {
      UIColor.redColor().setStroke()
      strokeLine(line)
    }
  }
  
  //-------------------------------------------------------------------- Touches
  override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
    let touch = touches.first!
    let location = touch.locationInView(self)
    
    currentLine = Line(begin: location, end: location)
    
    setNeedsDisplay()
  }
  
  override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
    let touch = touches.first!
    let location = touch.locationInView(self)
    
    currentLine?.end = location
    
    setNeedsDisplay()
  }
  
  override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
    if var line = currentLine {
      let touch = touches.first!
      let location = touch.locationInView(self)
      
      line.end = location
      
      finishedLines.append(line)
    }
    
    currentLine = nil
    
    setNeedsDisplay()
  }
}
