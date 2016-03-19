//
//  DrawViewController.swift
//  TouchTracker
//
//  Created by João Gradim on 18/03/16.
//  Copyright © 2016 jgradim. All rights reserved.
//

import UIKit

class DrawViewController: UIViewController {
  
  var drawView: DrawView!
  var toolBarView: UISegmentedControl!
  var colorBarView: UISegmentedControl!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    //view.translatesAutoresizingMaskIntoConstraints = false
    view.backgroundColor = UIColor.whiteColor()
    
    // drawView
    drawView = DrawView()
    view.addSubview(drawView)
    
    // tools bar
    toolBarView = UISegmentedControl(items: [
      "Line",
      "Square",
      "Circle",
    ])
    toolBarView.selectedSegmentIndex = 0
    toolBarView.addTarget(self, action: "setTool:", forControlEvents: .ValueChanged)
    view.addSubview(toolBarView)
    
    toolBarView.translatesAutoresizingMaskIntoConstraints = false
    let tc1 = toolBarView.topAnchor.constraintEqualToAnchor(topLayoutGuide.bottomAnchor, constant: 10)
    let tc2 = toolBarView.centerXAnchor.constraintEqualToAnchor(view.centerXAnchor)
    
    // color bar
    colorBarView = UISegmentedControl(items: [
      "Black",
      "White",
      "Red",
      "Green",
      "Blue",
    ])
    colorBarView.selectedSegmentIndex = 0
    colorBarView.addTarget(self, action: "setColor:", forControlEvents: .ValueChanged)
    view.addSubview(colorBarView)
    
    colorBarView.translatesAutoresizingMaskIntoConstraints = false
    let cc1 = colorBarView.bottomAnchor.constraintEqualToAnchor(bottomLayoutGuide.topAnchor, constant: -20)
    let cc2 = colorBarView.centerXAnchor.constraintEqualToAnchor(view.centerXAnchor)
    
    // activate all constraints
    [tc1, tc2, cc1, cc2].forEach{ $0.active = true }
  }
  
  func setTool(sender: AnyObject?) {
    let selectedTool = [
      Tool.LineTool,
      Tool.SquareTool,
      Tool.CircleTool,
    ][toolBarView.selectedSegmentIndex]
    
    drawView.setTool(selectedTool)
  }
  
  func setColor(sender: AnyObject?) {
    let selectedColor = [
      UIColor.blackColor(),
      UIColor.whiteColor(),
      UIColor(red: 0.7, green: 0, blue: 0, alpha: 1),
      UIColor(red: 0, green: 0.7, blue: 0, alpha: 1),
      UIColor(red: 0, green: 0, blue: 0.7, alpha: 1),
    ][colorBarView.selectedSegmentIndex]
    
    drawView.setColor(selectedColor)
  }
}
