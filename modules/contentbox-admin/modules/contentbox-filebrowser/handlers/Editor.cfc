/**
* ContentBox - A Modular Content Platform
* Copyright since 2012 by Ortus Solutions, Corp
* www.ortussolutions.com/products/contentbox
* ---
* Manages the image editor
*/
component extends="coldbox.system.EventHandler"{

	/**
	* Index
	*/
	function index( event, rc, prc ){
		event.paramValue( "imagePath","" )
			.paramValue( "imageSrc","" )
			.paramValue( "imageName","" );

		var info 		= ImageInfo( rc.imagePath );
		rc.width 		= info.width;
		rc.height 		= info.height;
		rc.imageRelPath = rc.imageSrc;
		rc.imageSrc 	= event.buildLink( '' ) & rc.imageSrc;

		if( event.isAjax() ) {
			event.renderData( data=renderView( view="editor/index", layout="ajax" ) );
		} else {
			event.setView( view="editor/index", layout="ajax" );
		}		
	}
	
	/**
	* Info
	*/
	function info( event, rc, prc ){
		event.paramValue( "imagePath", "" )
			.paramValue( "imageSrc", "" )
			.paramValue( "imageName", "" );

		var info 		= ImageInfo( rc.imagePath );
		rc.width 		= info.width;
		rc.height 		= info.height;
		rc.imageRelPath = rc.imageSrc;
		rc.imageSrc 	= event.buildLink( '' ) & rc.imageSrc;
		
		prc.imageInfo = ImageInfo( rc.imageSrc );

		if( event.isAjax() ) {
			event.renderData( data=renderView( view="editor/info", layout="ajax" ) );
		} else {
			event.setView( view="editor/info", layout="ajax" );
		}		
	}
	
	/**
	* Crop an image
	*/
	function crop( event, rc, prc ){
		// params
		event.paramValue( "imageX", "" )
			.paramValue( "imageY", "" )
			.paramValue( "width", "" )
			.paramValue( "height", "" )
			.paramValue( "imageLocation", "" );

		if ( len( rc.imageLocation ) ){
			// Cleanup random location
			rc.imageLocation = listFirst( rc.imageLocation, "?" );

		    // read the image and create a ColdFusion image object
		    var sourceImage = ImageNew( rc.imageLocation );

		    // crop the image using the supplied coords from the url request
		    ImageCrop(	
		    	sourceImage,
				rc.imageX,
				rc.imageY,
				rc.width,
				rc.height
			);

		    cfimage (
		        action = "writeToBrowser",
		        source = sourceImage
		    );

		    event.noRender();
		}

	}
	
	/**
	* Scale Image
	*/
	function scale( event, rc, prc ){
		// params
		event.paramValue( "width", "" )
			.paramValue( "height", "" )
			.paramValue( "imageLocation", "" );

		if ( len( rc.imageLocation ) ){
			// Cleanup random location
			rc.imageLocation = listFirst( rc.imageLocation, "?" );

		    // read the image and create a ColdFusion image object --->
		    var sourceImage = ImageNew( rc.imageLocation );

		    // crop the image using the supplied coords from the url request 
		    ImageResize(	
		    	sourceImage,
	            rc.width,
	            rc.height
	        );

		    cfimage (
		        action = "writeToBrowser",
		        source = sourceImage
		    );

		    event.noRender();
		}

	}
	
	/**
	* Index
	*/
	function imageSave( event, rc, prc ){
		// params
		event.paramValue( "imageLocation", "" )
			.paramValue( "imagePath", "" )
			.paramValue( "imageName", "" );

		if ( len( rc.imageLocation ) ){
			// Cleanup random location
			rc.imageLocation 	= listFirst( rc.imageLocation, "?" );

			// Read image
		    var sourceImage 	= ImageRead( rc.imageLocation );
			var path 			= rc.filebrowser.settings.directoryRoot & "/cc.jpg";

		    imageWrite( sourceImage, getDirectoryFromPath( rc.imagePath ) & rc.imageName );

		}
		event.noRender();
	}
	
}