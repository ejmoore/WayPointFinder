using Toybox.Application as App;
using Toybox.WatchUi as Ui;
using Toybox.Position as Position;

class WheredIParkApp extends App.AppBase {

    //! onStart() is called on application start up
    function onStart() {
    
    }

    //! onStop() is called when your application is exiting
    function onStop() {
    	System.println("Stopped");
   		Position.enableLocationEvents(Position.LOCATION_DISABLE,WheredIParkApp);
    }

    //! Return the initial view of your application here
    function getInitialView() {
        return [ new WheredIParkView() ];
    }
}