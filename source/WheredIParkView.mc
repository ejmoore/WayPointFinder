using Toybox.WatchUi as Ui;
using Toybox.System as Sys;

class WheredIParkView extends Ui.View {

	var distance;
	var currentPosition = null;
	var latitude;
	var longitude;
	var tempLat;
	var tempLon;
	
	var difLat = 0;
	var difLon = 0;
	
	var angle;
	
	var angleFromNorth;
	
	var done = false;
	var background;
	
	var TWO_PI = 2 * Math.PI;
	var ANGLE_ADJUST = Math.PI/2;
    //! Load your resources here
    function onLayout(dc) {
        background = Ui.loadResource(Rez.Drawables.background);
	}
	
    //! Called when this View is brought to the foreground. Restore
    //! the state of this View and prepare it to be shown. This includes
    //! loading resources into memory.
    function onShow() {
    
    }

    //! Update the view
    function onUpdate(dc) {
    	//onPosition(Position.enableLocationEvents(Position.LOCATION_CONTINUOUS,WheredIParkApp));
    
    	if (!done) {
    	onPosition(Position.enableLocationEvents(Position.LOCATION_CONTINUOUS,method(:onPosition)));
	    latitude = currentPosition.position.toDegrees()[0].toString();
	    longitude = currentPosition.position.toDegrees()[1].toString();
	    latitude = latitude.toFloat();
    	longitude = longitude.toFloat();
    	done = true;
    	}
    	else {
    	dc.setColor(0xAAAAAA,0xAAAAAA);
    	dc.drawRectangle(10,10,dc.getWidth(),dc.getHeight());
    	}
    	
    	dc.drawBitmap(0, 0, background);
    	
    	tempLat = currentPosition.position.toDegrees()[0].toString();
		tempLon = currentPosition.position.toDegrees()[1].toString();
		tempLat = tempLat.toFloat();
		tempLon = tempLon.toFloat();
		
		angleFromNorth = currentPosition.heading;
    
    	difLat = latitude - tempLat;
    	difLon = longitude - tempLon;
    	WheredIParkView.distanceFrom(difLat,difLon);
    
    	if (difLat == 0) {
    	difLat += 180;
    	}
    	angle = Math.atan(difLon/difLat);
    	angle -= ANGLE_ADJUST;
    	angle -= angleFromNorth;
    
    	dc.setColor(0x000000,0xffffff);
    	dc.drawCircle(102,64,50);
    	dc.drawLine(102,64,102+50*Math.cos(angle),64+50*Math.sin(angle));
    	dc.drawText(103,128,Graphics.FONT_SMALL,"Latitude:" + latitude.toNumber() + " Longitude:" + longitude.toNumber(),Graphics.TEXT_JUSTIFY_CENTER);
    	dc.drawText(0,0,Graphics.FONT_SMALL,"m:"+distance,Graphics.TEXT_JUSTIFY_LEFT);
    }

    //! Called when this View is removed from the screen. Save the
    //! state of this View here. This includes freeing resources from
    //! memory.
    function onHide() {
    }

	    
    function onPosition(info) {
        currentPosition = Position.getInfo();
        Ui.requestUpdate();
    }
    
    function distanceFrom(x,y) {
    	distance = (Math.sqrt(x*x+y*y) * 111112.21).toNumber();
    }
}
