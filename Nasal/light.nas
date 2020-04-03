##########################################################
#      DE L'HAMAIDE Clément for Dr400-jsbSim             #
#   PAF Team - http://equipe-flightgear.forumactif.com   #
##########################################################

var navLight = aircraft.light.new("/sim/model/lights/nav-lights", [0], "/controls/lighting/nav-lights");
var landingLight = aircraft.light.new("/sim/model/lights/landing-lights", [0], "/controls/lighting/landing-lights");
var taxiLight = aircraft.light.new("/sim/model/lights/taxi-lights", [0], "/controls/lighting/taxi-lights");
var strobeLight = aircraft.light.new("/sim/model/lights/strobe-lights", [0.04, 1], "/controls/lighting/strobe-lights");
