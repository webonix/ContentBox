<cfoutput>
<!--- Custom HTML --->
#bb.customHTML('beforeSideBar')#
<!--- BlogBoxEvent --->
#bb.event("bbui_BeforeSideBar")#

<!--- Categories --->
<h4>Categories</h4>
<div class="bg"></div>
	
<!--- 
	Display Categories using BlogBox collection template rendering
	the default convention for the template is "category.cfm" you can change it via the quickCategories() 'template' argument.
	I could have done it manually, but again, why?
 --->
#bb.quickCategories()#

<br/>

<h4>Description</h4>
<div class="bg"></div>
<p>#bb.siteDescription()#</p>

<!--- Custom HTML --->
#bb.customHTML('afterSideBar')#
<!--- BlogBoxEvent --->
#bb.event("bbui_afterSideBar")#
</cfoutput>