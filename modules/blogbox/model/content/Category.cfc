﻿/**
* I am a blog entry category
*/
component persistent="true" entityname="bbCategory" table="bb_category"{
	
	// Properties
	property name="categoryID" fieldtype="id" generator="native" setter="false";
	property name="category"		notnull="true"  length="200";
	property name="slug"			notnull="true"  length="200" unique="true" index="idx_slug";
	
	// M2M -> Entry
	property name="entries" cfc="blogbox.model.content.Entry" fieldtype="many-to-many" type="array" lazy="true"
		linktable="bb_entryCategories" fkcolumn="FK_categoryID" inversejoincolumn="FK_entryID";
	
	// Calculated properties
	property name="numberOfEntries" formula="select count(*) from bb_entryCategories as entryCats where entryCats.FK_categoryID=categoryID" ;
	
	/* ----------------------------------------- PUBLIC -----------------------------------------  */
	
	/**
	* is loaded?
	*/
	boolean function isLoaded(){
		return len( getCommentID() );
	}
}