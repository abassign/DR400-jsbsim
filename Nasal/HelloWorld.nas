# HelloWorld.nas
var mycode = func() {print(" HelloWorld.nas was loaded!");};
#setlistener("/sim/signals/nasal-dir-initialized", mycode);


var test = func() {
    gui.popupTip("Ich habe NASAL gecasted!",10);
    
}
    
var loader = func {
   io.load_nasal("Aircraft/DR400-jsbSim/Nasal/lateinvoke.nas");
   setprop("/sim/time/gmt","2020-08-01T15:00:00");
   gui.popupTip("If this works Changing in Runtime!",2);
 }
 

var showMetar = func() {
    var metarString = getprop("/environment/metar/data");
#    gui.popupTip("Current METAR: "~metarString,10);
     screen.log.write("Current METAR: "~metarString);
}

var showKey = func() {
    var keyNumber = 62;
    var k1 = getprop("/input/keyboard/key["~keyNumber~"]/desc");
    var k2 = getprop("/input/keyboard/key["~keyNumber~"]/binding/script");
    
    gui.popupTip(k1~k2);
    }

