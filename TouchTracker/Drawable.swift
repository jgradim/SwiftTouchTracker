//
//  Drawable.swift
//  TouchTracker
//
//  Created by João Gradim on 18/03/16.
//  Copyright © 2016 jgradim. All rights reserved.
//

import UIKit

protocol Drawable {
  var color: UIColor { get set }
  var selectedColor: UIColor { get }
  var selected: Bool { get }
  var finished: Bool { get }
  
  func draw()
  mutating func begin(point: CGPoint)
  mutating func move(point: CGPoint)
  mutating func end(point: CGPoint)
  mutating func select()
  mutating func deselect()
}
