///////////////////////////////////////////////////////////
// PARAMETRIC FLAT CHERRY MX KEYCAP
// Stable dimensions, no Minkowski scaling
///////////////////////////////////////////////////////////

// ------------------ Shape ------------------
corner_radius = 1;
wall_thickness = 1.2;
top_thickness  = 1.5;

// ------------------ Key size ------------------
key_width  = 1 * 18;    // 1u = 18 mm
key_depth  = 1 * 18;
key_height = top_thickness + 0;

// ------------------ Cherry MX stem ------------------
stem_height   = top_thickness + 4;
stem_outer_d  = 6.6;   // outer boss
stem_arm      = 4;   // cross length
stem_thick    = 1.3;   // cross thickness
stem_gap      = 0.15;  // fit tolerance

// ------------------ Quality ------------------
$fn = 64;


// ===================== MAIN =====================
union() {
    keycap_body();
    stem_female();
}


// ===================== BODY =====================
module keycap_body() {
    difference() {
        outer_shell();
        inner_hollow();
    }
}

module outer_shell() {
    linear_extrude(height = key_height)
        rounded_rect(key_width, key_depth, corner_radius);
}

module inner_hollow() {
    translate([0, 0, top_thickness])
        linear_extrude(height = key_height)
            rounded_rect(
                key_width  - 2*wall_thickness,
                key_depth  - 2*wall_thickness,
                corner_radius
            );
}


// ===================== STEM =====================
module stem_female() {
    translate([0, 0, stem_height/2])
    difference() {
        // Outer stem boss (POSITIVE)
        cylinder(
            h = stem_height,
            d = stem_outer_d,
            center = true
        );

        // Cherry MX cross (NEGATIVE)
        union() {
            cube([
                stem_arm + stem_gap,
                stem_thick + stem_gap,
                stem_height + 0.2
            ], center=true);

            cube([
                stem_thick + stem_gap,
                stem_arm + stem_gap,
                stem_height + 0.2
            ], center=true);
        }
    }
}


// ===================== 2D HELPERS =====================
module rounded_rect(w, d, r) {
    offset(r = r)
        square([w - 2*r, d - 2*r], center=true);
}
