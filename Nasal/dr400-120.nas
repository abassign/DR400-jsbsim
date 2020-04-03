###############################################################################
##
##  Nasal for DR400-jsbSim
##
##  Clément de l'Hamaide - PAF Team - http://equipe-flightgear.forumactif.com
##  Daniel Dubreuil
##  This file is licensed under the GPL license version 2 or later.
##
###############################################################################

#####################################
#Fuel Management
#####################################

  setprop("/engines/engine/fuel-pressure-psi",0);
  props.globals.initNode("consumables/fuel/tank/selected",0,"BOOL");
  props.globals.initNode("consumables/fuel/fuel-low",0,"BOOL");

#Feeding tank (to engine)

  setlistener("controls/fuel/selected-tank", func() {
  var sel_tank = getprop("controls/fuel/selected-tank");  

     if (sel_tank == 0) {
        setprop("consumables/fuel/tank[0]/selected",1);
        setprop("fdm/jsbsim/propulsion/tank[0]/priority", 1);
     }
     else {
        setprop("consumables/fuel/tank[0]/selected",0); 
        setprop("fdm/jsbsim/propulsion/tank[0]/priority", 0);
     };
  });

var Fuel = func {
  var fuel_level = getprop("consumables/fuel/tank/level-lbs");
  var engine_run = getprop("/engines/engine/running");
  var tank_selector = getprop("consumables/fuel/tank/selected");
  var pump_on = (getprop("/systems/electrical/outputs/fuel-pump") > 20) ? 1 : 0;

#Fuel level low (15.43 lbs = 10 liters) in the selected tank
# two warning thresholds: light then sound

  if (fuel_level < 15.43 and tank_selector == 1) {
      setprop("consumables/fuel/fuel-low",1);
        if (fuel_level < 5 and tank_selector == 1)
            setprop("consumables/fuel/fuel-low2",1);
        else
            setprop("consumables/fuel/fuel-low2",0);
  }
  else {
      setprop("consumables/fuel/fuel-low",0);
      setprop("consumables/fuel/fuel-low2",0);
  }

#Fuel pressure

  if (fuel_level > 0.1) {
    if (tank_selector==1){
      if (pump_on==1){
          interpolate("/engines/engine/fuel-pressure-psi", 4, 1); #300 mbar
      }else{
        if(engine_run==1){
          interpolate("/engines/engine/fuel-pressure-psi", 4, 1); #300 mbar
        }else{
          interpolate("/engines/engine/fuel-pressure-psi", 0, 1);
        }
      }
    }else{
      interpolate("/engines/engine/fuel-pressure-psi", 0, 1);
    }
  }else{
    interpolate("/engines/engine/fuel-pressure-psi", 0, 1);
  }

#Engine does not start if no fuel pressure

  if(getprop("/engines/engine/fuel-pressure-psi") < 0.5){
    setprop("fdm/jsbsim/propulsion/tank/priority", 0);
  }else{
    setprop("fdm/jsbsim/propulsion/tank/priority", 1);
  }
  }

##############################################
######### AUTOSTART / AUTOSHUTDOWN ###########
##############################################

setlistener("/sim/model/start-idling", func(idle){
    var run= idle.getBoolValue();
    if(run){
    Startup();
    }else{
    Shutdown();
    }
},0,0);

var Startup = func{
  setprop("controls/fuel/selected-tank", 0);
  setprop("controls/fuel/tank/boost-pump", 1);
  setprop("controls/engines/engine[0]/master-alt",1);
  setprop("/controls/engines/engine[0]/magnetos",3);
  setprop("controls/engines/engine[0]/mixture",1);
  setprop("/controls/gear/brake-parking",1);
  setprop("/controls/lighting/instruments-norm",1);
  setprop("/instrumentation/comm[0]/power-btn",1);
  setprop("/instrumentation/comm[0]/volume",1);
  setprop("/instrumentation/nav[0]/power-btn",1);  
  setprop("/instrumentation/nav[0]/volume",1);
  setprop("/instrumentation/adf[0]/power-btn",1);
  setprop("/instrumentation/adf[0]/volume",1);
  setprop("/instrumentation/adf[0]/volume-norm",1);
  setprop("controls/electric/battery-switch",1);
  setprop("sim/messages/copilot", "Now press \"s\" to start engine");
}

var Shutdown = func{
  setprop("controls/fuel/selected-tank", -1);
  setprop("controls/engines/engine[0]/master-alt",0);
  setprop("/controls/engines/engine[0]/magnetos",0);
  setprop("controls/engines/engine[0]/mixture",1);
  setprop("/engines/engine[0]/rpm",0);
  setprop("/engines/engine[0]/running",0);
  setprop("/controls/gear/brake-parking",1);
  setprop("/controls/lighting/instruments-norm",0);
  setprop("/instrumentation/comm[0]/power-btn",0);
  setprop("/instrumentation/comm[0]/volume",0);
  setprop("/instrumentation/nav[0]/power-btn",0);
  setprop("/instrumentation/nav[0]/volume",0);
  setprop("/instrumentation/adf[0]/power-btn",0);
  setprop("/instrumentation/adf[0]/volume",0);
  setprop("/instrumentation/adf[0]/volume-norm",0);
  setprop("controls/electric/battery-switch",0);
  setprop("controls/fuel/tank/boost-pump", 0);
  setprop("sim/messages/copilot", "Engine is stopped");
}


