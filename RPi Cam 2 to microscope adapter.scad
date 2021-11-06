wall_thickness           = 5;

eyepiece_holder_id       = 28.5;
eyepiece_holder_od       = eyepiece_holder_id + wall_thickness;
eyepiece_holder_h        = 32;

camera_base_w            = 60;
camera_base_h            = 5;
camera_lid_w             = camera_base_w;
camera_lid_h             = 6;

rpi_zero_l               = 75;

camera_board_w           = 25 + 0.75;
camera_board_to_lens     = 5;
camera_board_inset       = 4;
camera_lens_offset       = 14.25 - camera_board_w/2;
camera_lens_aperture     = 15;
camera_connector_w       = 10;
camera_connector_inset   = 3;

camera_mount_hole_offset = 20.75 / 2;
camera_mount_hole_d      = 1.8;

smaller_mounting_screw_d = 4;
larger_mounting_screw_d  = 6;
mounting_screw_inset     = 8;

epsilon                  = 0.1;
$fn = 120;


union() {
    // The base (the part that mounts onto the eyepiece)
    if (false) union() {
        // The part that slides over the eyepiece
        difference() {
            cylinder(h=eyepiece_holder_h, d=eyepiece_holder_od);
            translate([0, 0, -epsilon])
                cylinder(h=eyepiece_holder_h + 2*epsilon, d=eyepiece_holder_id);
        }

        // The part that the camera board rests on --- should make it rectangular, and large
        // enough for the RPi Zero to rest on, too
        translate([0, 0, -camera_base_h/2])
            difference() {
                cube(size=[camera_base_w, camera_base_w, camera_base_h], center=true);
                translate([0, 0, -camera_base_h/2-epsilon])
                    cylinder(h=camera_base_h + 2*epsilon, d=camera_lens_aperture);
                translate([0, camera_lens_aperture/2, -camera_base_h/2-epsilon])
                    cube(size=[camera_lens_aperture, camera_connector_w + camera_lens_aperture/2, camera_connector_inset + 2*epsilon], center=true);
                
                // the mounting holes
                translate([camera_base_w/2 - mounting_screw_inset, camera_base_w/2 - mounting_screw_inset, -camera_base_h/2-epsilon])
                    cylinder(h=camera_base_h + 2*epsilon, d=smaller_mounting_screw_d);
                translate([-camera_base_w/2 + mounting_screw_inset, camera_base_w/2 - mounting_screw_inset, -camera_base_h/2-epsilon])
                    cylinder(h=camera_base_h + 2*epsilon, d=smaller_mounting_screw_d);
                translate([camera_base_w/2 - mounting_screw_inset, -camera_base_w/2 + mounting_screw_inset, -camera_base_h/2-epsilon])
                    cylinder(h=camera_base_h + 2*epsilon, d=smaller_mounting_screw_d);
                translate([-camera_base_w/2 + mounting_screw_inset, -camera_base_w/2 + mounting_screw_inset, -camera_base_h/2-epsilon])
                    cylinder(h=camera_base_h + 2*epsilon, d=smaller_mounting_screw_d);
            }
    }
    
    // The lid / the part that mounts on top of the base, and which holds the camera board in place
    translate([0, 0, -40])
        if (true) union() {
            translate([0, 0, -camera_lid_h/2])
                difference() {
                    cube(size=[camera_lid_w, camera_lid_w, camera_lid_h], center=true);
                    translate([0, camera_lens_offset, (camera_lid_h - camera_board_inset)/2 - 0.9*epsilon])
                        cube(size=[camera_board_w, camera_board_w, camera_board_inset + 2*epsilon], center=true);
                    // this needs to be parameterised
                    translate([0, -camera_lens_offset - camera_board_w/2, (camera_lid_h - camera_board_inset)/2 - 0.9*epsilon])
                        cube(size=[20, 6, camera_board_inset + 2*epsilon], center=true);
                    
                    // should also add some corner stand-offs that are recessed by the depth of
                    // the PCB
                    
                    // the mounting holes
                    translate([camera_lid_w/2 - mounting_screw_inset, camera_lid_w/2 - mounting_screw_inset, -camera_lid_h/2-epsilon])
                        cylinder(h=camera_lid_h + 2*epsilon, d=larger_mounting_screw_d);
                    translate([-camera_lid_w/2 + mounting_screw_inset, camera_lid_w/2 - mounting_screw_inset, -camera_lid_h/2-epsilon])
                        cylinder(h=camera_lid_h + 2*epsilon, d=larger_mounting_screw_d);
                    translate([camera_lid_w/2 - mounting_screw_inset, -camera_lid_w/2 + mounting_screw_inset, -camera_lid_h/2-epsilon])
                        cylinder(h=camera_lid_h + 2*epsilon, d=larger_mounting_screw_d);
                    translate([-camera_lid_w/2 + mounting_screw_inset, -camera_lid_w/2 + mounting_screw_inset, -camera_lid_h/2-epsilon])
                        cylinder(h=camera_lid_h + 2*epsilon, d=larger_mounting_screw_d);
                }
            
            // and the mounting pins for the camera board    
            translate([-camera_mount_hole_offset, 0, -camera_board_inset - epsilon])
                cylinder(h=camera_board_inset + 2*epsilon, d=camera_mount_hole_d);
            translate([camera_mount_hole_offset, 0, -camera_board_inset - epsilon])
                cylinder(h=camera_board_inset + 2*epsilon, d=camera_mount_hole_d);
        }
}
