// Define module for reusable hinge base
module drawHingeBase(wingWidth, wingHeight, wingDepth, drillRadius, knuckleRadius, notchLength){
  difference(){
    union(){
      translate([wingWidth/2, wingDepth/2, 0]){
        difference(){
          
          // This draws a wing
          cube([wingWidth, wingDepth, wingHeight], center = true);

          // This draws the upper hole drill
          translate([knuckleRadius / 2, 0, wingHeight / 4]){
            wingHoleDrill(wingDepth, drillRadius);
          }

          // This draws the lower hole drill
          translate([knuckleRadius / 2, 0, -wingHeight / 4]){
            wingHoleDrill(wingDepth, drillRadius);
          }
        }
      }
    
      // Draw bottom part of the knuckle
      translate([0, 0, -wingHeight / 4]){
        cylinder(h = wingHeight / 2, r = knuckleRadius, center = true, $fn = 40);
      }
    }

    // Draw the top part of the knuckle that will be used 
    // for biting off a part of the wing.
    translate([0, 0, wingHeight / 4]){
      cube([knuckleRadius * 2 + notchLength, knuckleRadius * 2, wingHeight / 2], center = true);
    }  
  }
}

// Define the reusable drill for the holes in the wing
module wingHoleDrill(wingDepth, drillRadius){
  rotate([90, 0, 0]){
    cylinder(h = wingDepth + 10, r = drillRadius, center = true, $fn = 40);
  }
}

// This function call will be discarded if "use" is used 
// instead of "include". We leave it here to be able to get visual feedback here.
drawHingeBase(25, 50, 2, 2, 5, 1);