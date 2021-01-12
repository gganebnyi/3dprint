length = 241;
depth = 60;
height_front = 30;
height_side = 60;
back_stand_width = 15;

border = 5;

difference() {
    halfshelf1();
    middlesupport();
}

translate([-(border + length/2), -100, 0]) union() {
    halfshelf2();
    middlesupport();
}


module middlesupport() { 
    translate([border + (length - back_stand_width)/2, 0, 0]) {
        backstand();
        cube ([back_stand_width, depth + 2 * border, border/2]);
        cube ([back_stand_width, border/2, height_front + border]);
    }
}


module halfshelf1() {
    difference () {
        shelf();
        translate([border + length/2, -5, -5]) cube([length/2 + 5, 100, 100]);
    }
}

module halfshelf2() {
    difference () {
        shelf();
        translate([0, -5, -5]) cube([length/2 + 5, 100, 100]);
    }
}

module shelf() {

    long_bar = [length + 2 * border, border, border];
    side_bar = [border, depth + 2 * border, border];
    front_stand = [border, border, height_front + border];

    cube (long_bar);
    translate([0, depth + border, 0]) cube (long_bar);

    cube (side_bar);
    translate([length + border, 0, 0]) cube (side_bar);

    linear_extrude(5) honeycomb([10, 4], length + 2 * border + 17, depth + 2 * border);

    cube (front_stand);
    translate([length + border, 0, 0]) cube (front_stand);

    translate([0, 1, 5]) 
        rotate([0, -90, -90]) 
            linear_extrude(3) 
                honeycomb([10, 4], height_front + border - 6.5, length + 2 * border );

    backstand();
    translate([4, 0, 5]) 
        rotate([0, -90, 0]) 
            linear_extrude(3) 
                honeycomb([10, 4], height_front + border - 6.5, depth + 2 * border);

    translate([length + 2 * border - back_stand_width, 0, 0]) 
        backstand();
    translate([4 + length + border, 0, 5]) 
        rotate([0, -90, 0]) 
            linear_extrude(3) 
                honeycomb([10, 4], height_front + border - 6.5, depth + 2 * border);
}

module backstand() {
    back_stand = [back_stand_width, border, height_side + border];
    translate([0, depth + border, 0]) 
        difference() {
            cube (back_stand);  
            translate([back_stand_width/2, 6, height_side-2]) 
                rotate ([90, 0, 0])
                    cylinder (h=7, r1=1, r2=4);
        }
    
}

module honeycomb(a, xdim, ydim){
	
	module hex(a){
		difference(){
			circle(d=a[0], $fn=6);
			circle(d=a[0]-a[1], $fn=6);
		}
	}
	
	h0 = a[0]/4 * sqrt(3);
	h1 = (a[0]-a[1])/4 * sqrt(3); 
	
	intersection()
	{
		for (j = [0:ydim/(a[0]-a[1])+1]) {
			translate([0,( 2*h0  - (h0-h1) ) * j ,0])			
			for(i = [0:xdim*0.075]){
				translate([  i * ( a[0]/2 - a[1]/4  + a[0] - a[1]/2   )  ,0,0])hex(a);
				translate([  ( a[0]/4 -a[1]/8 + (a[0]-a[1]/2)/2 ) +  i * ( a[0]/2 - a[1]/4  + a[0] - a[1]/2  ) ,(2*h0  - (h0-h1))/2,0])hex(a);
			}
		}
		square([xdim,ydim]);
	}	
}



