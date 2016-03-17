//
//  DrawView.swift
//  TouchTracker
//
//  Created by João Gradim on 17/03/16.
//  Copyright © 2016 jgradim. All rights reserved.
//

import UIKit

class DrawView: UIView {
  // var currentLine: Line?
  var currentLines:[NSValue:Line] = [:]
  var finishedLines: [Line] = []
  
  convenience init() {
    self.init(frame: UIScreen.mainScreen().bounds)
    self.backgroundColor = UIColor.whiteColor()
    self.multipleTouchEnabled = true
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
    
    for line in currentLines.values {
      UIColor.redColor().setStroke()
      strokeLine(line)
    }
  }
  
  //-------------------------------------------------------------------- Touches
  override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
    for touch in touches {
      let location = touch.locationInView(self)
      let newLine = Line(begin: location, end: location)

      let key = NSValue(nonretainedObject: touch)
      currentLines[key] = newLine
    }
    
    setNeedsDisplay()
  }

  override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
    for touch in touches {
      let key = NSValue(nonretainedObject: touch)
      currentLines[key]?.end = touch.locationInView(self)
    }
    
    setNeedsDisplay()
  }
  
  override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
    for touch in touches {
      let key = NSValue(nonretainedObject: touch)
      
      if var line = currentLines[key] {
        line.end = touch.locationInView(self)

        finishedLines.append(line)
        currentLines.removeValueForKey(key)
      }
    }

    setNeedsDisplay()
  }

  override func touchesCancelled(touches: Set<UITouch>?, withEvent event: UIEvent?) {
    currentLines.removeAll()
    
    setNeedsDisplay()
  }
}
