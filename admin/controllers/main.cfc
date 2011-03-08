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
		
		<cfset rc.sectionTitle = "Dashboard" />
	</cffunction>
	
	<cffunction name="default">
		<cfargument name="rc" type="struct" />
		
		<cfset rc.AllInstances = getInstanceService().getAllInstances() />
	</cffunction>
	
</cfcomponent>