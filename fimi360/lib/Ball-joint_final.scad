innerRadBig = 8;
wallThicknessBig = 4;
outerRadSmall = 8.1;
slotWidth = 4;
connectorHeight = 4;
connectorRad = 5;
cutoffHeight = 8.5;
indentDist = .5;
clipHeight = 8;
adjustment = -.5;

sphere(r=outerRadSmall, $fn=100, center = true);

cylinder(h=outerRadSmall+connectorHeight, r=connectorRad, center = false, $fn =100);


    difference(){
    translate([0,0,(outerRadSmall+connectorHeight+innerRadBig)])
    sphere(r=(innerRadBig+wallThicknessBig), center = false, $fn=100);
    translate([0,0,outerRadSmall+connectorHeight+innerRadBig])
    sphere(r=innerRadBig, center = false, $fn=100);
    translate([-innerRadBig*3/2,-innerRadBig*3/2,outerRadSmall+connectorHeight+innerRadBig+(innerRadBig+wallThicknessBig - cutoffHeight)])
    cube([3*innerRadBig,3*innerRadBig,cutoffHeight*3], center = false, $fn=100);translate([-innerRadBig*3/2,-innerRadBig*3/2,outerRadSmall+connectorHeight+innerRadBig+(innerRadBig+wallThicknessBig - cutoffHeight)])
    cube([3*innerRadBig,3*innerRadBig,cutoffHeight*3], center = false, $fn=100);
    //slot
    translate([0,innerRadBig,outerRadSmall+connectorHeight+3/2*innerRadBig+2])
    cube([slotWidth,innerRadBig*2,innerRadBig*3], center = true, $fn=100);
    translate([0,innerRadBig,outerRadSmall+connectorHeight+2])
    rotate([90,00,180])
    cylinder(h = 2*wallThicknessBig, r = slotWidth/2, center=true, $fn=100);
    
    difference(){
    translate([0,0,outerRadSmall+connectorHeight+3/2*innerRadBig+cutoffHeight-3/2*clipHeight])
    cylinder(h = clipHeight, r = innerRadBig+wallThicknessBig+2*indentDist+adjustment, center=true, $fn = 100);
    translate([0,0,outerRadSmall+connectorHeight+3/2*innerRadBig+cutoffHeight-3/2*clipHeight])
    cylinder(h = clipHeight, r = innerRadBig+wallThicknessBig-indentDist+adjustment, center=true, $fn = 100);
   }
 }
