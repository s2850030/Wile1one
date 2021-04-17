/* Insert.scad   by Neil Rieck  15 April 2021
         makes an wagon wheel insert for PLC Reel to fit any yoke
         Thick must be > 0 and less than = 5
*/

// Properties
ID = 24;                   //Inner hole Diameter (yoke Diameter)
OD = 52;                   //Outer Diameter (Hole in Reel)
RW = 25;                   //Reel Width
Spc = 6;                   //Spoke Count
Thick = 2;                 //Thickness of Parts

// Calculated Properties
SL = (RW*3/4);             //Spoke Length
RA = 360/Spc;              //Rotation Angle
TH = OD/10;                //Limit of Thickness for wagon wheel

// Sanity Check
if(Thick>TH) echo("  ........ DESIGN ERROR Thick must be less than ", TH); 

BuildAll();                //Builds the insert


module BuildAll(){
    difference(){
        assembly1();
        Bore();
    }
}
module assembly1(){
    Outer();
    Spokes();
}

module Bore(){
    translate([0,0,-1])
    cylinder(  h=RW+4, d1=ID, d2=ID-1, $fn=100, center=true);
}
module Outer(){
    difference(){
       cylinder(  h=RW, d1=OD, d2=OD-1, $fn=100, center=true);
       translate([0,0,-1])
       cylinder(  h=RW+4, d=OD-Thick*2, $fn=100, center=true);
    }
    cylinder(  h=RW, d=ID+Thick*2, $fn=100, center=true);
}
module Spokes(){
    for ( a=[0:Spc-1] )
        rotate([0,0,RA*a]) Spoke();
        
}
module Spoke(){
    translate([-Thick/2,0,-SL/2])
    cube([Thick,OD/2-0.5,SL],false);
}
