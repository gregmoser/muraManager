<cfcomponent extends="controller">
	
	<cfset variables.instanceService = "" />
	
	<cffunction name="getInstanceService">
		<cfreturn variables.instanceService />
	</cffunction>
	<cffunction name="setInstanceService">
		<cfargument name="instanceService" />
		<cfset variables.instanceService = arguments.instanceService />
	</cffunction>
	
	<cffunction name="before">
		<cfargument name="rc" type="struct" />
		
		<cfset rc.sectionTitle = "Instance Manager" />
	</cffunction>
	
	<cffunction name="detail">
		<cfargument name="rc" type="struct" />
		
		<cfparam name="rc.instanceID" default=0 />
		<cfset rc.instance = getInstanceService().read(rc.instanceID) />
		<cfset rc.itemTitle = ": #rc.instance.getInstanceName()#" />
	</cffunction>
	
	<cffunction name="edit">
		<cfargument name="rc" type="struct" />
		
		<cfset detail(rc) />
		<cfset getFW().setView("admin:instance.detail") />
		<cfset rc.edit = 1 />
		<cfset rc.itemTitle = ": Edit #rc.instance.getInstanceName()#" />
		
	</cffunction>
	
	<cffunction name="create">
		<cfargument name="rc" type="struct" />
		
		<cfset detail(rc) />
		<cfset getFW().setView("admin:instance.detail") />
		<cfset rc.edit = 1 />
		<cfset rc.itemTitle = ": Add New" />
	</cffunction>
	
	<cffunction name="save">
		<cfargument name="rc" type="struct" />
		
		<cfparam name="rc.instanceID" default=0 />
		
		<cfset rc.instance = getInstanceService().read(rc.instanceID) />
		<cfset getFW().populate(cfc=rc.instance, keys="instanceID,instanceName,instanceKey,instanceHostname,instancePasskey") />
		<cfset getInstanceService().save(rc.instance) />
		<cfset getFW().redirect(action="admin:main.default") />
	</cffunction>
	
	<cffunction name="delete">
		<cfargument name="rc" type="struct" />
		
		<cfparam name="rc.instanceID" default=0 />
		
		<cfset rc.instance = getInstanceService().read(rc.instanceID) />
		<cfset getInstanceService().delete(rc.instance) />
		<cfset getFW().redirect(action="admin:main.default") />
	</cffunction>
</cfcomponent>