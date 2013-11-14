use <MCAD/boxes.scad>
$fn=50;
charger_r=30.25;
charger_h=12.5;
device_h=138;
device_coil_h=device_h/2; // this should be the mid point of the coil
base_extra=5;

rounded_r=2;
sidesonly=false;

module n5() {

    roundedBox([69.2, 8.6, 137.9], 1, false);

};

module charger() {

    translate([0, 0, 71.5]) {
        difference() {
            roundedBox([(charger_r*2)+8, charger_h+3, device_h+base_extra], rounded_r, sidesonly); 
            translate([0, 0, (device_coil_h/2)+3]) {
                cube([90, 50, device_coil_h+1], center=true);
            };
            rotate(a=[90, 0, 0]) {
                cylinder(h=charger_h+1, r=charger_r, center=true);
                cylinder(h=charger_h+6, r=charger_r-3, center=true);
            };
            translate([-6.5, -1, -90]) {
                cube([13, 7.5, device_h/2], center=false);
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
                // Base
                roundedBox([(charger_r*2)+16, 45, 25], rounded_r, sidesonly);
                // Slot for charger
                translate([0, 1.5, 10]) {
                    rotate(a=[330, 0, 0]) {
                        cube([(charger_r*2)+9, 16.5, 25], center=true);
                        };
                    };
                // USB cable slot
                translate([-6.5, 2.25, -13]) {
                    cube([13, 10, 20.5], center=false);
                    };
                translate([-6.5, 11.5, -13]) {
                    cube([13, 30, 7.5], center=false);
                    };
            };
            // lip for device
            if(!sidesonly) {
                translate([0, -15, 11]) {
                    rotate(a=[330, 0, 0]) {
                        roundedBox([(charger_r*2)+16, 13, 10], rounded_r, sidesonly);
                    };
                };
            } else {
                difference() {
                    translate([0, -16, 10.7]) {
                        rotate(a=[330, 0, 0]) {
                            roundedBox([(charger_r*2)+16, 13, 10], rounded_r, false);
                        };
                    };
                    translate([0, -15, 6.2]) {
                            cube([(charger_r*2)+20, 19, 12.5], center=true);
                    };
                };
            };
            translate([28.25, 22.5, -8.5]) {
                roundedBox([20, 40, 8], rounded_r, sidesonly);
            };
            translate([-28.25, 22.5, -8.5]) {
                roundedBox([20, 40, 8], rounded_r, sidesonly);
            };
        };
    };
};

module print(parts="all") {

    if(parts=="charger") {
        charger();
    } else if(parts=="base") {
        base();
    } else if(parts=="all") {
        charger();
        translate([80, 0, 0]) {
            base();
        }
    }
}

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

module main(mode="view", parts="all") {

    if(mode=="print") {
        print(parts);
    } else {
        view();
    }
}

main(mode, parts);
