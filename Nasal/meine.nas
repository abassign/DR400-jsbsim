var irgendwas = func() {

    gui.popupTip("Ich habe NASAL gecasted!",10);



# create a new InputDialog with a title, label, and a callback
#canvas.InputDialog.getText("Hello World", "Please enter your name", func(btn,value) {
#    if (value) gui.popupTip("You entered: "~value);
#});

   



#      var myCheck = getprop("/instrumentation
#/usr/share/games/flightgear/Nasal/multiplayer.nas:313:            idcode = me.IDCode(n.getNode("instrumentation/transponder/transmitted-id").getValue());


}

var showMetar = func() {

    var (width,height) = (320,160);
    var title = 'My new Window';

    # create a new window, dimensions are WIDTH x HEIGHT, using the dialog decoration (i.e. titlebar)
    var window = canvas.Window.new([width,height],"dialog")
     .set('title',title);


     ##
     # the del() function is the destructor of the Window
     # which will be called upon termination (dialog closing)
     # you can use this to do resource management (clean up timers, listeners or background threads)
     window.del = func()
     {
       print("Cleaning up window:",title,"\n");
       # explanation for the call() technique at: http://wiki.flightgear.org/Object_oriented_programming_in_Nasal#Making_safer_base-class_calls
         call(canvas.Window.del, [], me);
	 };

	 # adding a canvas to the new window and setting up background colors/transparency
	 var myCanvas = window.createCanvas().set("background", canvas.style.getColor("bg_color"));

	 # Using specific css colors would also be possible:
	 # myCanvas.set("background", "#ffaac0");

	 # creating the top-level/root group which will contain all other elements/group
	 var root = myCanvas.createGroup();
   
 
}
print("meine.nas... has been loaded successfully.");
