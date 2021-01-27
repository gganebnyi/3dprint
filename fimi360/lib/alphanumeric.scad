RAD=5;

module line(length) {
	cylinder(r=RAD, h=length);
	sphere(r=RAD);
	translate([0,0,length]) sphere(r=RAD);
}

module arcsegment(arcradius, degrees) {
	stepsize=10;
	steps=floor(degrees/stepsize);
	for(i=[1:1:steps]) {
		translate([0,0,-7]) {
			linear_extrude(height=15) {
				polygon(points=[
						[0,0], 
						[arcradius*sin((i-1)*stepsize),
							arcradius*cos((i-1)*stepsize)], 
						[arcradius*sin(i*stepsize+.1), 
							arcradius*cos(i*stepsize+.1)]], 
					paths=[[0,2,1]]);
			}
		}
	}
	translate([0,0,-7]) {
		linear_extrude(height=15) {
			polygon(points=[
					[0,0], 
					[arcradius*sin(steps*stepsize),
						arcradius*cos(steps*stepsize)], 
					[arcradius*sin(degrees), 
						arcradius*cos(degrees)]], 
				paths=[[0,2,1]]);
		}
	}
}

module arctube(arcradius, degrees, ballend=true) {
	render() {
		difference() {
			rotate_extrude(convexity=4) {
				translate([arcradius,0,0]) {
					circle(5);
				}
			}
			arcsegment(arcradius*2, 360-degrees);
		}
		if (ballend) {
			translate([0,arcradius,0]) sphere(RAD);
			rotate([0,0,degrees]) translate([0,arcradius,0]) sphere(RAD);
		}
	}
}

module halfcircle(stublength=0) {
	union() {
		arctube(20,180);
		translate([0,20,0]) {
			rotate([0,90,0]) {
				cylinder(r=5,h=stublength);
			}
		}
		translate([0,-20,0]) {
			rotate([0,90,0]) {
				cylinder(r=5,h=stublength);
			}
		}
	}
}

module d() {
	translate([30,-RAD,0]) rotate([90,0,0]) {
 		line(80);
	}
	translate([20,-25,0]) {
		halfcircle(10);
	}
}

module k() {
	translate([0,-RAD,0]) rotate([90,0,0]) {
 		line(80);
	}
	translate([0,-25,0]) rotate([90,0,45]) {
 		line(30);
	}
	translate([7,-30,0]) rotate([90,0,145]) {
 		line(30);
	}
}

module n() {
	translate([0,-RAD,0]) rotate([90,0,0]) {
 		line(40);
	}
	translate([17,-29,0]) {
		rotate([0,0,90]) {
			arctube(17,180);
		}
	}
	translate([34,-RAD,0]) rotate([90,0,0]) {
 		line(24);
	}
}

module p() {
	translate([30,-50,0]) {
		rotate([0,0,180]) {
			d();
		}
	}
}

module r() {
	translate([0,-RAD,0]) rotate([90,0,0]) {
 		line(40);
	}
	translate([20,-25,0]) {
		rotate([0,0,90]) {
			arctube(20,120);
		}
	}
}

module v() {
	translate([20,-RAD,0]) {
		rotate([90,0,25]) {
 			line(43);
		}
		rotate([90,0,-25]) {
 			line(43);
		}
	}
}

module zero() {
	// TODO: make an ellipse function so scale doesn't ruin line
	// thickness. better yet, control line thickness so can have thing
	// parts on top and bottom, like "real" letters/numbers
	scale([.75,1,1]) arctube(25,360);
}

module one() {
	rotate([90,0,0]) translate([0,0,-25]) line(50);
}

module two() {
	translate([0,10,0]) rotate([0,0,-150]) arctube(15,230);
	translate([11,0,0]) rotate([90,0,-45]) line(35);
	translate([-13,-25,0]) rotate([90,0,90]) line(29);
}

module three() {
	translate([0,10,0]) rotate([0,0,-140]) arctube(14,190);
	translate([0,-11,0]) rotate([0,0,-230]) arctube(14,190);
	translate([5,0,0]) rotate([90,0,90]) line(3);
}

module four() {
	translate([10,25,0]) rotate([90,0,-45]) line(35);
	translate([10,25,0]) rotate([90,0,0]) line(50);
	translate([-15,0,0]) rotate([90,0,90]) line(35);
}

module five() {
	translate([-7,23,0]) rotate([90,0,90]) line(20);
	translate([-7,23,0]) rotate([90,0,0]) line(20);
	translate([0,-11,0]) rotate([0,0,-225]) arctube(14,255);
}

module six() {
	translate([26,-10,0]) rotate([0,0,30]) arctube(40,60);
	translate([0,-13,0]) rotate([0,0,0]) arctube(14,360);
}

module seven() {
	translate([-15,25,0]) rotate([90,0,90]) line(35);
	translate([95,-40,0]) rotate([0,0,50]) arctube(100,31);
}

module eight() {
	translate([0,13,0]) rotate([0,0,0]) arctube(12,360);
	translate([0,-13,0]) rotate([0,0,0]) arctube(14,360);
}

module nine() {
	rotate([0,0,180]) {
		translate([26,-10,0]) rotate([0,0,30]) arctube(40,60);
		translate([0,-13,0]) rotate([0,0,0]) arctube(14,360);
	}
}

module point() {
	translate([0,-25,0]) sphere(RAD);
}

module digit(n) {
	if (n==0) {
		zero();
	} else if (n==1) {
		one();
	} else if (n==2) {
		two();
	} else if (n==3) {
		three();
	} else if (n==4) {
		four();
	} else if (n==5) {
		five();
	} else if (n==6) {
		six();
	} else if (n==7) {
		seven();
	} else if (n==8) {
		eight();
	} else if (n==9) {
		nine();
	}
}

// spacing will never be right here...
module write(letters) {
	for (letter = letters) {
		if (letter == "d") d();
		if (letter == "p") p();
	}
}

module dpr() {
	d();
	translate([45,0,0]) {
		p();
	}
	translate([87,0,0]) {
		r();
	}
}

module knvr() {
	k();
	translate([40,0,0]) n();
	translate([85,0,0]) v();
	translate([140,0,0]) r();
}

// translate([0,0,0]) d();
// translate([45,0,0]) k();
// translate([85,0,0]) n();
// translate([135,0,0]) p();
// translate([180,0,0]) r();
// translate([220,0,0]) v();
// knvr();
// dpr();
//one();
// translate([-100,0,0]) zero();
// translate([-70,0,0]) one();
// translate([-40,0,0]) two();
// translate([0,0,0]) three();
// translate([25,0,0]) four();
// translate([90,0,0]) five();
// translate([135,0,0]) six();
// translate([160,0,0]) seven();
// translate([215,0,0]) eight();
// translate([255,0,0]) nine();
//point();
//one();
// for (i=[0:9]) {
// 	digit(i);
// }