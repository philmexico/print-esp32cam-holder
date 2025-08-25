include<dimensions.scad>

//first_half = true;

module bar() {
    cylinder(h = bar_height, r = bar_radius);
}

module clamp(first_half = true) {
    // hinge
    if (first_half == true) {
        translate([hinge_position_x, 0, (clamp_height - hinge_height) / 2])cylinder(h = hinge_height / 4 - printer_tolerance, r = hinge_radius);
        translate([hinge_position_x, 0, (clamp_height + hinge_height) / 2 - hinge_height / 4 + printer_tolerance])cylinder(h = hinge_height / 4 - printer_tolerance, r = hinge_radius);
    } else {
        translate([hinge_position_x, 0, (clamp_height - hinge_height) / 2 + hinge_height / 4])cylinder(h = hinge_height / 2, r = hinge_radius);
//        translate([hinge_position_x, 0, (clamp_height - hinge_height) / 2 + hinge_height / 4])cylinder(h = hinge_height / 2, r = hinge_radius);
    }
    difference()  {
        clamp_positive(first_half);
        clamp_negative(first_half);
    }
}

module clamp_positive(first_half = true) {
//  hinge_position_x = bar_radius + clamp_thickness + hinge_axis_radius;

    // clamp body
    cylinder(h = clamp_height, r = bar_radius + clamp_thickness);
    if (first_half == true) {
        // hinge
//        translate([hinge_position_x, 0, (clamp_height - hinge_height) / 2])cylinder(h = hinge_height, r = hinge_radius);
        // lock
        translate([- (bar_radius + clamp_thickness + sqrt(2) * clamp_thickness), -clamp_lock_thickness, clamp_height / 2])rotate([0, 45, 0])cube([clamp_lock_width, clamp_lock_thickness, clamp_lock_width]);
        // connector
        translate([-.5 * clamp_thickness, -(bar_radius + clamp_thickness + 1.9 * clamp_thickness), clamp_height / 2 - .5 * clamp_thickness])rotate([-45, 0, 0])cube([clamp_thickness, 3 * clamp_thickness, clamp_thickness]); 
        translate([0, -(bar_radius + clamp_thickness + 1.5 * clamp_thickness), clamp_height / 2])sphere(r = clamp_thickness);
    } else {
        // hinge
//        translate([hinge_position_x, 0, (clamp_height - hinge_height) / 2 + hinge_height / 4])cylinder(h = hinge_height / 2, r = hinge_radius);
        // lock
        translate([- (bar_radius + clamp_thickness + sqrt(2) * clamp_thickness), 0 * clamp_thickness, clamp_height / 2])rotate([0, 45, 0])cube([clamp_lock_width, clamp_lock_thickness, clamp_lock_width]);
    }
}

module clamp_negative(first_half = true) {

    // body
    if (first_half == true) {
        rotate([0, 0, 90])translate([0, -1 * (bar_radius + clamp_thickness), 0])cube([bar_radius + clamp_thickness, (bar_radius + clamp_thickness) * 2, clamp_height]);
    } else {
        rotate([0, 0, 90])translate([-1 * (bar_radius + clamp_thickness), -1 * (bar_radius + clamp_thickness), 0])cube([bar_radius + clamp_thickness, (bar_radius + clamp_thickness) * 2, clamp_height]);
    }
    // lock
    translate([-1 * (bar_radius + clamp_thickness + .25 * sqrt(2) * clamp_thickness), clamp_lock_thickness, clamp_height / 2])rotate([90, 0, 0])cylinder(h = 2 * clamp_lock_thickness, r = screwhole_radius);
    if (first_half == true) {
        // hinge
        translate([hinge_position_x, 0, (clamp_height - hinge_height / 2) / 2 - printer_tolerance])cylinder(h = hinge_height * .5 + printer_tolerance * 2, r = hinge_radius + printer_tolerance);
    } else {
        // hinge
        translate([hinge_position_x, 0, (clamp_height - hinge_height) / 2])cylinder(h = hinge_height / 4, r = hinge_radius + printer_tolerance);
        translate([hinge_position_x, 0, clamp_height / 2 + hinge_height / 4])cylinder(h = hinge_height / 4, r = hinge_radius + printer_tolerance);
    }
}

module holder(first_half = true) {
    difference() {
        clamp(first_half);
        negative(first_half);
    }
}

module negative(first_half = true) {
    translate([hinge_position_x, 0, (clamp_height - hinge_height) / 2])cylinder(h = hinge_height, r = hinge_axis_radius);
    translate([0, 0, -bar_height / 2])bar();

    // negative for first half
    if (first_half == true) {
//        rotate([0, 0, 90])translate([0, -1 * (bar_radius + clamp_thickness), 0])cube([bar_radius + clamp_thickness, (bar_radius + clamp_thickness) * 2, clamp_height]);
    }
}