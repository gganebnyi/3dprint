use <../lib/gopro_mounts_mooncactus.scad>

extender(30);

module extender(len=100) {
  translate ([10, 7 - len, 7.35]) {
    rotate([0, 90, 0]) gopro_connector("double");
    gopro_extended(len, th=3);
  }

  $fn=50;
  difference() {
    minkowski()
    {
      cube([20, 16, 13.7]);
      cylinder(r=4,h=1);
    }
    translate ([1, 1, -1]) minkowski()
    {
      cube([18, 14, 16]);
      cylinder(r=2,h=1);
    }
    translate ([10, 20, (3.6 + 3.25)]) 
      rotate([90, 0, 0]) 
        cylinder(h=5, d1=6.5, d2=6.5);
  }
}
