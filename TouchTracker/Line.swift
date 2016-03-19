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

struct Line {
  var begin = CGPoint.zero
  var end = CGPoint.zero
  var color = UIColor.blackColor()

  func points() -> (CGPoint, CGPoint) {
    return (begin, end)
  }
}