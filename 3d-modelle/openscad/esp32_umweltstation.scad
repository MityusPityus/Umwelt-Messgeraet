// ESP32 Umweltstation Gehaeuse V13.6
// Einheiten: mm
// OpenSCAD:
// PART = "preview" -> Vorschau
// PART = "body"    -> Unterteil exportieren
// PART = "lid"     -> Deckel exportieren

PART = "preview"; // "body", "lid", "preview"

// =====================================================
// Hauptmasse
// =====================================================
case_w = 168;
case_d = 115;
case_h = 85;

wall = 2.4;
lid_t = 3.0;
clearance = 0.4;

// =====================================================
// Gravuren
// =====================================================
engraving_enabled = true;

lid_text = "Umweltstation";
lid_text_size = 8.5;
lid_engrave_depth = 0.5;
lid_text_x = case_w / 2;
lid_text_y = 13;

body_bottom_text = "Mityu - Prototype";
body_text_size = 7.0;
body_engrave_depth = 0.5;
body_text_x = case_w / 2;
body_text_y = case_d / 2;

// =====================================================
// Display vorne
// =====================================================
display_center_z = 47;

display_view_w = 94;
display_view_h = 52;

display_pocket_w = 112;
display_pocket_h = 64;
display_recess_depth = 8.5;

display_hole_dx = 101;
display_hole_dz = 55;
display_screw_d = 3.0;

display_post_d = 8.0;
display_post_depth = 6.0;

// =====================================================
// USB rechts
// =====================================================
usb_slot_w = 12;
usb_slot_h = 9;
usb_slot_z = 32;

// =====================================================
// Hintere Zusatz-Lueftung
// =====================================================
// Kleine Schlitze hinten mittig fuer bessere Durchlueftung.
back_vent_count = 5;
back_vent_w = 4;
back_vent_h = 30;
back_vent_gap = 6;
back_vent_center_x = case_w / 2;
back_vent_z = 32;

// =====================================================
// Breadboard Niederhalter / Anti-Wackel-Lippen
// Start jetzt bei 12.7 mm, damit Breadboard leichter reingeht.
// =====================================================
breadboard_clips_enabled = true;

bb_clip_w = 24;
bb_clip_d = 1.0;
bb_clip_h = 0.9;
bb_clip_z = 12.7;
bb_clip_inset_x = 48;

// =====================================================
// Button oben
// =====================================================
button_hole = 13.5;
button_x = case_w - 32;
button_y = case_d / 2;

// Durchgehende Support-Bar fuer Button
button_bar_w = 4;
button_bar_l = 34;
button_bar_h = 4;
button_bar_z = -button_bar_h;

// =====================================================
// Lueftung oben
// =====================================================
vent_count = 8;
vent_w = 4;
vent_l = 55;
vent_gap = 5;
vent_x0 = 22;
vent_y = case_d / 2;

// =====================================================
// Deckelschrauben / Body-Halter
// =====================================================
lid_screw_d = 3.2;
top_boss_pilot_d = 2.5;

top_boss_size = 18;
top_boss_h = 10;
top_boss_z = case_h - top_boss_h;

screw_offset = wall + top_boss_size / 2;

// =====================================================
// BME680 Einschub-Halter am Deckel
// Sensor ca. 20 x 20 x 4 mm
// Links offen fuer Pins/Kabel.
// Innenhoehe ca. 9 mm.
// =====================================================
sensor_board_w = 20;
sensor_board_d = 20;

sensor_clearance = 2.0;

sensor_mount_x = 50;
sensor_mount_y = case_d / 2 - (sensor_board_d + sensor_clearance) / 2;

sensor_slot_w = sensor_board_w + sensor_clearance;
sensor_slot_d = sensor_board_d + sensor_clearance;

sensor_rail_wall = 2.2;
sensor_rail_h = 9.0;

sensor_lip_w = 8.0;
sensor_lip_h = 1.2;

sensor_stop_w = 2.5;

// Kleine Einrast-Nupsis fuer Sensorloecher
// - Durchmesser 1 mm
// - Abstand 11 mm
// - erster Nupsi 5 mm von der ersten Seitenwand/Lippe entfernt
// - zweiter Nupsi 11 mm weiter
sensor_peg_enabled = true;
sensor_peg_d = 1.0;
sensor_peg_h = 4.0;
sensor_peg_spacing = 11.0;
sensor_peg_first_offset = 5.0;

// =====================================================
// Sonstiges
// =====================================================
cut_depth = 20;
holder_overlap = 0.8;

$fn = 48;

// =====================================================
// Positionen Deckelschrauben
// =====================================================
module lid_screw_positions() {
    positions = [
        [screw_offset, screw_offset],
        [case_w - screw_offset, screw_offset],
        [screw_offset, case_d - screw_offset],
        [case_w - screw_offset, case_d - screw_offset]
    ];

    for (p = positions) {
        translate([p[0], p[1], 0])
            children();
    }
}

// =====================================================
// Positionen Display-Schrauben vorne
// =====================================================
module display_screw_positions_front() {
    for (sx = [-1, 1]) {
        for (sz = [-1, 1]) {
            translate([
                case_w / 2 + sx * display_hole_dx / 2,
                0,
                display_center_z + sz * display_hole_dz / 2
            ])
            children();
        }
    }
}

// =====================================================
// Hintere Lueftungsschlitze
// =====================================================
module back_vents_cutout() {
    total_w = back_vent_count * back_vent_w + (back_vent_count - 1) * back_vent_gap;
    start_x = back_vent_center_x - total_w / 2;

    for (i = [0 : back_vent_count - 1]) {
        translate([
            start_x + i * (back_vent_w + back_vent_gap),
            case_d - wall - 2,
            back_vent_z
        ])
            cube([
                back_vent_w,
                wall + 6,
                back_vent_h
            ]);
    }
}

// =====================================================
// Deckel-Gravur oben
// =====================================================
module lid_engraving_cut() {
    if (engraving_enabled) {
        translate([
            lid_text_x,
            lid_text_y,
            lid_t - lid_engrave_depth
        ])
            linear_extrude(height = lid_engrave_depth + 0.3)
                text(
                    lid_text,
                    size = lid_text_size,
                    halign = "center",
                    valign = "center",
                    font = "Liberation Sans:style=Bold"
                );
    }
}

// =====================================================
// Boden-Gravur Body unten
// =====================================================
module body_bottom_engraving_cut() {
    if (engraving_enabled) {
        translate([
            body_text_x,
            body_text_y,
            -0.1
        ])
            linear_extrude(height = body_engrave_depth + 0.3)
                text(
                    body_bottom_text,
                    size = body_text_size,
                    halign = "center",
                    valign = "center",
                    font = "Liberation Sans:style=Bold"
                );
    }
}

// =====================================================
// Gehaeuse-Schale
// =====================================================
module shell_only() {
    difference() {
        cube([case_w, case_d, case_h]);

        // Innenraum offen nach oben
        translate([wall, wall, wall])
            cube([
                case_w - 2 * wall,
                case_d - 2 * wall,
                case_h - wall + 1
            ]);

        // Sichtbares Displayfenster vorne
        translate([
            (case_w - display_view_w) / 2,
            -1,
            display_center_z - display_view_h / 2
        ])
            cube([
                display_view_w,
                wall + 3,
                display_view_h
            ]);

        // Displaytasche innen
        translate([
            (case_w - display_pocket_w) / 2,
            wall,
            display_center_z - display_pocket_h / 2
        ])
            cube([
                display_pocket_w,
                display_recess_depth,
                display_pocket_h
            ]);

        // USB-Schlitz rechts
        translate([
            case_w - wall - 2,
            case_d / 2 - usb_slot_w / 2,
            usb_slot_z
        ])
            cube([
                wall + 6,
                usb_slot_w,
                usb_slot_h
            ]);

        // Hintere Zusatz-Lueftung
        back_vents_cutout();

        // Unterseiten-Gravur
        body_bottom_engraving_cut();
    }
}

// =====================================================
// Breadboard-Niederhalter
// =====================================================
module breadboard_clips() {
    if (breadboard_clips_enabled) {

        // vorne links
        translate([
            bb_clip_inset_x,
            wall,
            bb_clip_z
        ])
            cube([
                bb_clip_w,
                bb_clip_d,
                bb_clip_h
            ]);

        // vorne rechts
        translate([
            case_w - bb_clip_inset_x - bb_clip_w,
            wall,
            bb_clip_z
        ])
            cube([
                bb_clip_w,
                bb_clip_d,
                bb_clip_h
            ]);

        // hinten links
        translate([
            bb_clip_inset_x,
            case_d - wall - bb_clip_d,
            bb_clip_z
        ])
            cube([
                bb_clip_w,
                bb_clip_d,
                bb_clip_h
            ]);

        // hinten rechts
        translate([
            case_w - bb_clip_inset_x - bb_clip_w,
            case_d - wall - bb_clip_d,
            bb_clip_z
        ])
            cube([
                bb_clip_w,
                bb_clip_d,
                bb_clip_h
            ]);
    }
}

// =====================================================
// Kurze obere Schraubhalter fuer Deckel
// =====================================================
module top_lid_bosses() {
    translate([wall, wall, top_boss_z])
        cube([top_boss_size, top_boss_size, top_boss_h]);

    translate([case_w - wall - top_boss_size, wall, top_boss_z])
        cube([top_boss_size, top_boss_size, top_boss_h]);

    translate([wall, case_d - wall - top_boss_size, top_boss_z])
        cube([top_boss_size, top_boss_size, top_boss_h]);

    translate([case_w - wall - top_boss_size, case_d - wall - top_boss_size, top_boss_z])
        cube([top_boss_size, top_boss_size, top_boss_h]);
}

// =====================================================
// Pilotloecher in oberen Schraubhaltern
// =====================================================
module top_lid_boss_holes() {
    lid_screw_positions() {
        translate([0, 0, top_boss_z - 1])
            cylinder(
                h = top_boss_h + 4,
                d = top_boss_pilot_d
            );
    }
}

// =====================================================
// Display-Halter innen an der Frontwand
// =====================================================
module display_mount_posts() {
    display_screw_positions_front() {
        translate([0, wall + display_post_depth / 2, 0])
            rotate([90, 0, 0])
                cylinder(
                    h = display_post_depth,
                    d = display_post_d,
                    center = true
                );
    }
}

// =====================================================
// Display-Schraubloecher
// =====================================================
module display_mount_holes() {
    display_screw_positions_front() {
        translate([0, -2, 0])
            rotate([-90, 0, 0])
                cylinder(
                    h = wall + display_post_depth + 6,
                    d = display_screw_d
                );
    }
}

// =====================================================
// Body komplett
// =====================================================
module body_shell() {
    difference() {
        union() {
            shell_only();

            // kurze obere Deckel-Schraubhalter
            top_lid_bosses();

            // Displayhalter innen
            display_mount_posts();

            // Breadboard-Niederhalter
            breadboard_clips();
        }

        // Pilotloecher fuer Deckelschrauben
        top_lid_boss_holes();

        // Displayloecher vorne
        display_mount_holes();
    }
}

// =====================================================
// Button-Support-Bar
// Wird nach Deckelausschnitt addiert und bleibt daher durchgehend.
// =====================================================
module button_support_bar() {
    translate([
        button_x - button_bar_l / 2,
        button_y - button_bar_w / 2,
        button_bar_z
    ])
        cube([
            button_bar_l,
            button_bar_w,
            button_bar_h + holder_overlap
        ]);
}

// =====================================================
// Kleine Sensor-Nupsis
// Ein Nupsi sitzt auf der einen Unterlippe,
// der andere Nupsi sitzt auf der anderen Unterlippe.
// Abstand zwischen den Nupsis: 11 mm.
// Erster Nupsi: 5 mm von der ersten Seitenwand/Lippe entfernt.
// =====================================================
module sensor_pegs_on_lip() {
    if (sensor_peg_enabled) {

        peg_center_x = sensor_mount_x + sensor_slot_w / 2;
        peg_base_z = -sensor_rail_h + sensor_lip_h;

        // Erster Nupsi: 5 mm von der ersten Seitenwand/Lippe entfernt
        peg_y_1 = sensor_mount_y + sensor_peg_first_offset;

        // Zweiter Nupsi: 11 mm weiter
        peg_y_2 = peg_y_1 + sensor_peg_spacing;

        translate([
            peg_center_x,
            peg_y_1,
            peg_base_z
        ])
            cylinder(
                h = sensor_peg_h,
                d = sensor_peg_d
            );

        translate([
            peg_center_x,
            peg_y_2,
            peg_base_z
        ])
            cylinder(
                h = sensor_peg_h,
                d = sensor_peg_d
            );
    }
}

// =====================================================
// BME680-Einschubhalter am Deckel
// U-Form mit seitlicher offener Seite.
// Zwei Lippen links/rechts, Mitte bleibt frei.
// Pins/Kabel koennen auf der linken Seite raus.
// =====================================================
module bme680_slide_holder_lid() {
    z0 = -sensor_rail_h;

    // erste seitliche Schiene
    translate([
        sensor_mount_x,
        sensor_mount_y,
        z0
    ])
        cube([
            sensor_slot_w,
            sensor_rail_wall,
            sensor_rail_h + holder_overlap
        ]);

    // zweite seitliche Schiene
    translate([
        sensor_mount_x,
        sensor_mount_y + sensor_slot_d - sensor_rail_wall,
        z0
    ])
        cube([
            sensor_slot_w,
            sensor_rail_wall,
            sensor_rail_h + holder_overlap
        ]);

    // erste breite Unterlippe
    translate([
        sensor_mount_x,
        sensor_mount_y,
        z0
    ])
        cube([
            sensor_slot_w,
            sensor_lip_w,
            sensor_lip_h
        ]);

    // zweite breite Unterlippe
    translate([
        sensor_mount_x,
        sensor_mount_y + sensor_slot_d - sensor_lip_w,
        z0
    ])
        cube([
            sensor_slot_w,
            sensor_lip_w,
            sensor_lip_h
        ]);

    // Nupsis jeweils auf einer Lippe / mit definiertem Abstand
    sensor_pegs_on_lip();

    // hinterer Anschlag
    translate([
        sensor_mount_x + sensor_slot_w,
        sensor_mount_y,
        z0
    ])
        cube([
            sensor_stop_w,
            sensor_slot_d,
            sensor_rail_h + holder_overlap
        ]);

    // linke Seite bleibt offen fuer Pins/Kabel
}

// =====================================================
// Deckel-Basis mit Ausschnitten
// =====================================================
module lid_base_cut() {
    difference() {
        union() {
            // Deckelplatte
            cube([
                case_w,
                case_d,
                lid_t
            ]);

            // Fuehrungslippe nach unten
            translate([
                wall + clearance,
                wall + clearance,
                -2
            ])
                cube([
                    case_w - 2 * (wall + clearance),
                    case_d - 2 * (wall + clearance),
                    2
                ]);
        }

        // Schraubloecher Deckel komplett durch Deckel + Fuehrungslippe
        lid_screw_positions() {
            translate([0, 0, -cut_depth])
                cylinder(
                    h = lid_t + cut_depth + 5,
                    d = lid_screw_d
                );

            // Senkung fuer Schraubenkopf oben
            translate([0, 0, lid_t - 1])
                cylinder(
                    h = 2.2,
                    d1 = 6.5,
                    d2 = 3.2
                );
        }

        // Buttonloch komplett durch Deckel
        translate([
            button_x - button_hole / 2,
            button_y - button_hole / 2,
            -cut_depth
        ])
            cube([
                button_hole,
                button_hole,
                lid_t + cut_depth + 4
            ]);

        // Lueftungsschlitze komplett durch Deckel
        for (i = [0 : vent_count - 1]) {
            translate([
                vent_x0 + i * (vent_w + vent_gap),
                vent_y - vent_l / 2,
                -cut_depth
            ])
                cube([
                    vent_w,
                    vent_l,
                    lid_t + cut_depth + 4
                ]);
        }

        // Deckel-Gravur oben
        lid_engraving_cut();
    }
}

// =====================================================
// Deckel komplett
// =====================================================
module lid() {
    union() {
        // Erst Deckel mit Loechern und Gravur
        lid_base_cut();

        // Danach Halter addieren, damit sie nicht weggeschnitten werden
        button_support_bar();
        bme680_slide_holder_lid();
    }
}

// =====================================================
// Vorschau
// =====================================================
module preview() {
    body_shell();

    // Deckel angehoben anzeigen
    translate([0, 0, case_h + 8])
        lid();
}

// =====================================================
// Ausgabe
// =====================================================
if (PART == "body") {
    body_shell();
} else if (PART == "lid") {
    lid();
} else {
    preview();
}
