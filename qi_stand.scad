use <MCAD/boxes.scad>
$fn=50;
charger_r=30.25;
charger_h=12.5;
device_h=138;
device_coil_h=device_h/2; // this should be the mid point of the coil
base_extra=5;
rounded_r=2;

module n5() {

    roundedBox([69.2, 8.6, 137.9], 1, false);

};

module charger() {

    translate([0, 0, 71.5]) {
        difference() {
            roundedBox([(charger_r*2)+8, charger_h+3, device_h+base_extra], rounded_r, false); 
            translate([0, 0, (device_coil_h/2)+3]) {
                cube([90, 50, device_coil_h+1], center=true);
            };
            rotate(a=[90, 0, 0]) {
                cylinder(h=charger_h+1, r=charger_r, center=true);
                cylinder(h=charger_h+6, r=charger_r-3, center=true);
            };
            translate([-6.5, 0, -90]) {
                cube([13, 6.5, device_h/2], center=false);
            };
            translate([-6.5, 0, -72]) {
                cube([13, 8.5, 6.5], center=false);
            };
        };
    };
};

module base() {

    translate([0, 0, 12.5]) {
        union() {
            difference() {
                roundedBox([(charger_r*2)+16, 45, 25], rounded_r, false);
                translate([0, 0, 10]) {
                    rotate(a=[330, 0, 0]) {
                        cube([(charger_r*2)+9, 15, 25], center=true);
                        };
                    };
                translate([-6.5, .25, -5]) {
                    cube([13, 50, 6.5], center=false);
                    };
            };
            translate([0, -15, 11]) {
                rotate(a=[330, 0, 0]) {
                    roundedBox([(charger_r*2)+16, 13, 10], rounded_r, false);
                };
            };
            translate([28.25, 22.5, -8.5]) {
                roundedBox([20, 40, 8], rounded_r, false);
            };
            translate([-28.25, 22.5, -8.5]) {
                roundedBox([20, 40, 8], rounded_r, false);
            };
        };
    };
};

module print() {

    charger();

    translate([80, 0, 0]) {
        base();
    };
};

module view() {

    base();

    translate([0, -5, 12]) {
        rotate(a=[330,0,0]) {
            charger();
        };
    };

    translate([0, 22, 85]) {
        rotate(a=[330,0,0]) {
           %n5();
        };
    };
};

print();
