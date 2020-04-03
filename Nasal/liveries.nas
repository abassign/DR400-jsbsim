########################################################
##                Clément de l'Hamaide                ##
## PAF Team - http://equipe-flightgear.forumactif.com ##
########################################################

aircraft.livery.init("Aircraft/DR400-jsbSim/Models/Liveries");

setlistener("/sim/model/config/use-dds", func(n) {
  if ( n.getBoolValue() )
    aircraft.livery.init("Aircraft/DR400-jsbSim/Models/Liveries-dds");
  else
    aircraft.livery.init("Aircraft/DR400-jsbSim/Models/Liveries");
});
