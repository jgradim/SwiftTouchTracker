//
//  DrawView.swift
//  TouchTracker
//
//  Created by João Gradim on 17/03/16.
//  Copyright © 2016 jgradim. All rights reserved.
//

import UIKit

class DrawView: UIView {
  var currentColor = UIColor.blackColor()
  var currentTool = Tool.LineTool
  
  var drawables: [Drawable] = []
  var currentDrawables: [NSValue:Drawable] = [:]
  
  // var selectedLineIndex: Int? {
  //   didSet {
  //     if selectedLineIndex == nil {
  //       UIMenuController.sharedMenuController().setMenuVisible(false, animated: true)
  //     }
  //   }
  // }
  
  //-----------------------------------------------------------------------------
  // Initializer
  //-----------------------------------------------------------------------------
  convenience init() {
    self.init(frame: UIScreen.mainScreen().bounds)
    self.backgroundColor = UIColor.whiteColor()

    self.multipleTouchEnabled = true
    setupGestureRecognizers()
  }
  
  func setupGestureRecognizers() {
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

  //-----------------------------------------------------------------------------
  // Internal API
  //-----------------------------------------------------------------------------
  
  private func indexOfLineAtPoint(point: CGPoint) -> Int? {
    // for (i, line) in finishedLines.enumerate() {
    //   let (begin, end) = line.points()

    //   for t in CGFloat(0).stride(to: 1, by: 0.05) {
    //     let x = begin.x + ((end.x - begin.x) * t)
    //     let y = begin.y + ((end.y - begin.y) * t)

    //     // If the tapped point is within 20 points, let's return this line
    //     if hypot(x - point.x, y - point.y) < 20.0 {
    //       return i
    //     }
    //   }
    // }

    return nil
  }

  private func deleteLine(sender: AnyObject) {
    // if let index = selectedLineIndex {
    //   finishedLines.removeAtIndex(index)
    //   selectedLineIndex = nil

    //   setNeedsDisplay()
    // }
  }

  //----------------------------------------------------------------------------
  // Gesture recognizers
  //----------------------------------------------------------------------------
  func tap(gestureRecognizer: UIGestureRecognizer) {
    // print("recognized single tap")
    //   
    // let point = gestureRecognizer.locationInView(self)
    // selectedLineIndex = indexOfLineAtPoint(point)
    //   
    // let menu = UIMenuController.sharedMenuController()
    // if selectedLineIndex != nil {
    //   becomeFirstResponder()
    //   
    //   menu.menuItems = [
    //     UIMenuItem(title: "Delete", action: "deleteLine:")
    //   ]
    //   
    //   menu.setTargetRect(CGRect(x: point.x, y: point.y, width: 2, height: 2), inView: self)
    //   menu.setMenuVisible(true, animated: true)
    // }
    // 
    // setNeedsDisplay()
  }

  func doubleTap(gestureRecognizer: UIGestureRecognizer) {
     print("recognized a double tap")

     drawables.removeAll(keepCapacity: false)
     currentDrawables.removeAll(keepCapacity: false)
     setNeedsDisplay()
  }

  //-----------------------------------------------------------------------------
  // Delegates
  //-----------------------------------------------------------------------------
  func setTool(tool: Tool) {
    print("DrawView#setTool called with \(tool)")
    currentTool = tool
  }
  
  func setColor(color: UIColor) {
    print("DrawView#setColor called with \(color)")
    currentColor = color
  }
  
  //----------------------------------------------------------------------------
  // UIView overrides
  //----------------------------------------------------------------------------
  override func canBecomeFirstResponder() -> Bool {
    return true
  }
  
  //----------------------------------------------------------------------- Draw
  override func drawRect(rect: CGRect) {
    // finished
    drawables.forEach{ $0.draw() }
  }
  
  //-------------------------------------------------------------------- Touches
  override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
    for touch in touches {
      var drawable: Drawable!
      
      switch currentTool {
      case .LineTool:
        drawable = Line()
      case .RectangleTool:
        drawable = Rectangle()
      case .CircleTool:
        drawable = Circle()
      default:
        return
      }
      
      drawable.begin(touch.locationInView(self))
      drawable.color = currentColor
      
      let key = NSValue(nonretainedObject: touch)
      currentDrawables[key] = drawable
      drawables.append(drawable)
    }
    
    setNeedsDisplay()
  }

  override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
    for touch in touches {
      let key = NSValue(nonretainedObject: touch)
      currentDrawables[key]?.move(touch.locationInView(self))
      print(currentDrawables)
    }
    
    setNeedsDisplay()
  }
  
  override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
    print("touchesEnded")
    for touch in touches {
      let key = NSValue(nonretainedObject: touch)
      
      if var d = currentDrawables[key] {
        d.end(touch.locationInView(self))
        currentDrawables.removeValueForKey(key)
      }
    }

    setNeedsDisplay()
  }

  override func touchesCancelled(touches: Set<UITouch>?, withEvent event: UIEvent?) {
    currentDrawables.removeAll()
    
    setNeedsDisplay()
  }
}
