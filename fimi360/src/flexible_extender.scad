use <../lib/gopro_mounts_mooncactus.scad>
use <../lib/ujoint.scad>

translate ([0, -23, 0]) {
  rotate([0, 90, 0]) gopro_connector("triple");
  //gopro_extended(100, th=3);
}

rotate([90, 0, 0]) ujoint(R=21);
translate ([0, 23, 0]) rotate([0, 90, 180]) gopro_connector("double");
