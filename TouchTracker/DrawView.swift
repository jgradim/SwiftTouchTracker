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
  var selectedLineIndex: Int? {
    didSet {
      if selectedLineIndex == nil {
        UIMenuController.sharedMenuController().setMenuVisible(false, animated: true)
      }
    }
  }
  
  convenience init() {
    self.init(frame: UIScreen.mainScreen().bounds)
    self.backgroundColor = UIColor.whiteColor()

    self.multipleTouchEnabled = true

    let doubleTapRecognizer = UITapGestureRecognizer(target: self, action: "doubleTap:")
    doubleTapRecognizer.numberOfTapsRequired = 2
    doubleTapRecognizer.delaysTouchesBegan = true
    addGestureRecognizer(doubleTapRecognizer)

    let tapRecognizer = UITapGestureRecognizer(target: self, action: "tap:")
    tapRecognizer.numberOfTapsRequired = 1
    doubleTapRecognizer.delaysTouchesBegan = true
    tapRecognizer.requireGestureRecognizerToFail(doubleTapRecognizer)
    addGestureRecognizer(tapRecognizer)
  }


  func strokeLine(line: Line) {
    let path = UIBezierPath()
    path.lineWidth = 10
    path.lineCapStyle = CGLineCap.Round
    
    path.moveToPoint(line.begin)
    path.addLineToPoint(line.end)
    path.stroke()
  }
  
  func indexOfLineAtPoint(point: CGPoint) -> Int? {
    for (i, line) in finishedLines.enumerate() {
      let (begin, end) = line.points()

      for t in CGFloat(0).stride(to: 1, by: 0.05) {
        let x = begin.x + ((end.x - begin.x) * t)
        let y = begin.y + ((end.y - begin.y) * t)

        // If the tapped point is within 20 points, let's return this line
        if hypot(x - point.x, y - point.y) < 20.0 {
          return i
        }
      }
    }

    return nil
  }

  func deleteLine(sender: AnyObject) {
    if let index = selectedLineIndex {
      finishedLines.removeAtIndex(index)
      selectedLineIndex = nil

      setNeedsDisplay()
    }
  }

  //----------------------------------------------------------------------------
  // Gesture recognizers
  //----------------------------------------------------------------------------
  func tap(gestureRecognizer: UIGestureRecognizer) {
    print("recognized single tap")
      
    let point = gestureRecognizer.locationInView(self)
    selectedLineIndex = indexOfLineAtPoint(point)
      
    let menu = UIMenuController.sharedMenuController()
    if selectedLineIndex != nil {
      becomeFirstResponder()
      
      menu.menuItems = [
        UIMenuItem(title: "Delete", action: "deleteLine:")
      ]
      
      menu.setTargetRect(CGRect(x: point.x, y: point.y, width: 2, height: 2), inView: self)
      menu.setMenuVisible(true, animated: true)
    }
    
    setNeedsDisplay()
  }

  func doubleTap(gestureRecognizer: UIGestureRecognizer) {
    print("recognized a double tap")

    currentLines.removeAll(keepCapacity: false)
    finishedLines.removeAll(keepCapacity: false)
    selectedLineIndex = nil
    setNeedsDisplay()
  }
  
  //----------------------------------------------------------------------------
  // UIView overrides
  //----------------------------------------------------------------------------
  
  override func canBecomeFirstResponder() -> Bool {
    return true
  }
  
  //----------------------------------------------------------------------- Draw
  override func drawRect(rect: CGRect) {
    UIColor.blackColor().setStroke()
    
    // finished
    for line in finishedLines {
      strokeLine(line)
    }
    
    // current
    for line in currentLines.values {
      UIColor.redColor().setStroke()
      strokeLine(line)
    }
    
    // selected
    if let index = selectedLineIndex {
      UIColor.greenColor().setStroke()
      let selectedLine = finishedLines[index]
      strokeLine(selectedLine)
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
