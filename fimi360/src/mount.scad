use <../lib/gopro_mounts_mooncactus.scad>

rotate([0, -90, 0]) {
  difference() {
    translate([-16, -96, -100])
      rotate([90, 0, 90]) 
        import("../lib/fimi_x8_camera_mount_bottom.stl");
    cube([100, 16, 100], center=true);
  }

  gopro_connector("triple", withnut=true);
}