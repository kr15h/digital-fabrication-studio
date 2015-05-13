// Parametric 3D-Printable Hinge
// Author:  Krisjanis Rijnieks
// Date:    2015-05-13
// 
// This hinge project consists of two files:
//  - A reusable hinge base file;
//  - This file, that makes a male and 
//    female part out of the hinge base.

// Import modules from hinge base file.
use <hinge-base.scad>

// Define variables, these can be easily changed
// for each next iteration, if fail.
wingWidth = 25;
wingHeight = 50;
wingDepth = 2;

drillRadius = 2;
knuckleRadius = 5;
knuckleInnerRadius = 2.5;

maleFemaleSpacing = 0.2;
notchLength = 1;

// Draw male hinge.
union() {
  drawHingeBase(wingWidth, wingHeight, wingDepth, drillRadius, knuckleRadius, notchLength);
  cylinder(r = knuckleInnerRadius - maleFemaleSpacing / 2, 
           h = wingHeight / 2, $fn = 40);
}

// Draw female hinge.
difference() {
  translate([0, knuckleRadius * 2 + 10, 0]){
    drawHingeBase(wingWidth, wingHeight, wingDepth, drillRadius, knuckleRadius, notchLength);
  }

  translate([0, knuckleRadius * 2 + 10, -wingHeight / 2 - 2]){
    cylinder(r = knuckleInnerRadius + maleFemaleSpacing / 2, 
             h = wingHeight / 2 + 4, $fn = 40);
  }
}
        
