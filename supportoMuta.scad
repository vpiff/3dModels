module line(p1,p2,w) {
    hull() {
        translate(p1) circle(r=w);
        translate(p2) circle(r=w);
    }
}
module polyline(points, index, w) {
    if(index < len(points)) {
        line(points[index - 1], points[index],w);
        polyline(points, index + 1, w);
    }
}
function choose(n, k)=
     k == 0? 1
    : (n * choose(n - 1, k - 1)) / k;

function _point_on_bezier_rec(points,t,i,c)=
    len(points) == i ? c
    : _point_on_bezier_rec(points,t,i+1,c+choose(len(points)-1,i) * pow(t,i) * pow(1-t,len(points)-i-1) * points[i]);

function _point_on_bezier(points,t)=
    _point_on_bezier_rec(points,t,0,[0,0]);

//a bezier curve with any number of control points
//parameters: 
//points - the control points of the bezier curve (number of points is variable)
//resolution - the sampling resolution of the bezier curve (number of returned points)
//returns:
//resolution number of samples on the bezier curve
function bezier(points,resolution)=[
    for (t =[0:1.0/resolution:1+1.0/(resolution/2)]) _point_on_bezier(points,t)
];

resolution = 360;    
$fn = resolution;

radius = 45;
firstPartHeight = 20;
curvePartHeight = 20;
seccondPartHeight = 60;
strength = 3;
finalRadius=20;

p00 = [finalRadius,0];
p0 = [finalRadius, firstPartHeight];
p1 = [finalRadius, firstPartHeight + curvePartHeight * 0.5];
p2 = [radius, firstPartHeight + curvePartHeight * 0.5];
p3 = [radius, firstPartHeight + curvePartHeight];
p4 = [radius, firstPartHeight + curvePartHeight + seccondPartHeight];


translate([0,0,-strength])

rotate_extrude()
polyline(bezier([p00,p0,p1,p2,p3,p4],resolution),1,strength);