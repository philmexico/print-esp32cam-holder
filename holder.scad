include<dimensions.scad>

first_half = true;

module bar() {
    cylinder(h = bar_height, r = bar_radius);
}

module clamp() {
    difference()  {
        clamp_positive();
        clamp_negative();
    }
}

module clamp_positive() {
    union() {
        // clamp body
        difference()  {
            cylinder(h = clamp_height, r = bar_radius + clamp_thickness);
            if (first_half == true) {
                rotate([0, 0, 90])translate([0, -1 * (bar_radius + clamp_thickness), 0])cube([bar_radius + clamp_thickness, (bar_radius + clamp_thickness) * 2, clamp_height]);
            } else {
                rotate([0, 0, 90])translate([-1 * (bar_radius + clamp_thickness), -1 * (bar_radius + clamp_thickness), 0])cube([bar_radius + clamp_thickness, (bar_radius + clamp_thickness) * 2, clamp_height]);
            }
        }
        if (first_half == true) {
            // hinge
            translate([hinge_position_x, 0, (clamp_height - hinge_height) / 2])cylinder(h = hinge_height, r = hinge_radius);
            // lock
            translate([- (bar_radius + clamp_thickness + clamp_thickness), -.5 * clamp_thickness, clamp_height / 2 - clamp_thickness])cube([2 * clamp_thickness, .5 * clamp_thickness, 2 * clamp_thickness]);
        } else {
            translate([hinge_position_x, 0, (clamp_height - hinge_height) / 2 + hinge_height / 4])cylinder(h = hinge_height / 2, r = hinge_radius);
        }
    }
}

module clamp_negative() {
    if (first_half == true) {
        translate([hinge_position_x, 0, (clamp_height - hinge_height) / 2 + hinge_height / 4])cylinder(h = hinge_height / 2, r = hinge_radius);
    } else {
        translate([hinge_position_x, 0, (clamp_height - hinge_height) / 2])cylinder(h = hinge_height / 4, r = hinge_radius);
        translate([hinge_position_x, 0, clamp_height / 2 + hinge_height / 4])cylinder(h = hinge_height / 4, r = hinge_radius);
    }
}

module holder() {
    difference() {
        clamp();
        negative();
    }
}

module negative() {
    translate([hinge_position_x, 0, (clamp_height - hinge_height) / 2])cylinder(h = hinge_height, r = hinge_axis_radius);
    translate([0, 0, -bar_height / 2])bar();

    // negative for first half
    if (first_half == true) {
//        rotate([0, 0, 90])translate([0, -1 * (bar_radius + clamp_thickness), 0])cube([bar_radius + clamp_thickness, (bar_radius + clamp_thickness) * 2, clamp_height]);
    }
}